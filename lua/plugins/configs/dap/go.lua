require 'dap-go'.setup()
require 'dap.ext.vscode'.load_launchjs()

local dap = require 'dap'

dap.adapters.go = function(callback, config)
  local stdout = vim.loop.new_pipe(false)
  local handle
  local pid_or_err
  local port = 38697
  local opts = {
    stdio = { nil, stdout },
    args = { 'dap', '-l', '127.0.0.1:' .. port },
    detached = true
  }
  handle, pid_or_err = vim.loop.spawn('dlv', opts, function(code)
    stdout:close()
    handle:close()
    if code ~= 0 then
      print('dlv exited with code', code)
    end
  end)
  assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require 'dap.repl'.append(chunk)
      end)
    end
  end)
  -- Wait for delve to start
  vim.defer_fn(
    function()
      callback { type = 'server', host = '127.0.0.1', port = port }
    end,
    100)
end

dap.configurations.go = {
  {
    type = 'go',
    name = 'Debug',
    request = 'launch',
    cwd = '${workspaceFolder}',
    program = '${workspaceFolder}/internal'
  },
  {
    type = 'go',
    name = 'Debug test', -- configuration for debugging test files
    request = 'launch',
    mode = 'test',
    program = '${file}'
  },
  -- works with go.mod packages and sub packages
  {
    type = 'go',
    name = 'Debug test (go.mod)',
    request = 'launch',
    mode = 'test',
    program = './${relativeFileDirname}'
  }
}

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<leader>d', ":lua require'dapui'.toggle()<CR>", { silent = true })
map('n', '<leader>df', ":lua require'dapui'.eval()<CR>", { silent = true })
map('n', '<F5>', ":lua require'dap'.continue()<CR>", { silent = true })
map('n', '<F10>', ":lua require'dap'.step_over()<CR>", { silent = true })
map('n', '<F11>', ":lua require'dap'.step_into()<CR>", { silent = true })
map('n', '<F12>', ":lua require'dap'.step_out()<CR>", { silent = true })
map('n', '<leader>b', ":lua require'dap'.toggle_breakpoint()<CR>", { silent = true })
map('n', '<leader>bc', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { silent = true })
map('n', '<leader>l', ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
  { silent = true })
