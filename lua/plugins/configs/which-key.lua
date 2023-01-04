local ok, wk = pcall(require, 'which-key')
if not ok then
  return
end
wk.setup {}

local gitsigns = require 'gitsigns'

wk.register {
  ['<C-N>'] = { '<cmd>NvimTreeToggle<cr>', 'NvimTreeToggle' },
  ['K'] = { vim.lsp.buf.hover, 'Hover Action' },
  ['<C-K>'] = { vim.lsp.buf.signature_help, 'Signature Help' },
  ['['] = {
    name = 'Jump Prev',
    g = { vim.diagnostic.goto_prev, 'Jump Prev Diagnotics' },
    c = { function() if vim.wo.diff then return '[c' end
      vim.schedule(function() gitsigns.prev_hunk() end)
      return '<Ignore>'
    end, 'Jump Prev Hunk' },
  },
  [']'] = {
    name = 'Jump Next',
    g = { vim.diagnostic.goto_next, 'Jump Next Diagnotics' },
    c = { function() if vim.wo.diff then return ']c' end
      vim.schedule(function() gitsigns.next_hunk() end)
      return '<Ignore>'
    end, 'Jump Next Hunk' },
  },
  ['z'] = {
    ['R'] = { require 'ufo'.openAllFolds, 'Open All Folds' },
    ['M'] = { require 'ufo'.closeAllFolds, 'Close All Folds' }
  },
  ['<leader>'] = {
    ['ca'] = { vim.lsp.buf.code_action, 'Code Action' },
    ['rn'] = { vim.lsp.buf.rename, 'Rename Current Buffer' },
    f = {
      name = 'File',
      f = { '<cmd>Telescope find_files<cr>', 'Find Files' },
      g = { '<cmd>Telescope live_grep<cr>', 'Live Grep' },
      b = { '<cmd>Telescope file_browser<cr>', 'File Browser' },
      h = { '<cmd>Telescope help_tags<cr>', 'Help Tags' },
      r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
      p = { '<cmd>Telescope project<cr>', 'Select Telescope Project' },
      d = { '<cmd>Telescope find_files cwd=' .. os.getenv 'HOME' .. '/.config/nvim/<cr>', 'Find in Dotfiles' },
      s = { '<cmd>Telescope lsp_dynamic_workspace_symbols', 'Find Symbols In Workspace' },
    },
    n = {
      name = 'NvimTree',
      r = { '<cmd>NvimTreeRefresh<cr>', 'NvimTreeRefresh' },
      f = { '<cmd>NvimTreeFindFile<cr>', 'NvimTreeFindFile' },
    }
  },
  g = {
    name = 'GoTo',
    x = { '<cmd>Telescope diagnotics<cr>', 'Diagnotics' },
    d = { '<cmd>Telescope lsp_definitions<cr>', 'GoTo Definitions' },
    i = { '<cmd>Telescope lsp_implementations<cr>', 'GoTo Implementations' },
    r = { '<cmd>Telescope lsp_references<cr>', 'GoTo References' },
    t = { '<cmd>Telescope lsp_type_definitions<cr>', 'GoTo Type Declarations' },
    ['D'] = { vim.lsp.buf.declaration, 'GoTo Declaration' },
  },
  ['<space>'] = {
    f = { function() vim.lsp.buf.format { async = true } end, 'Format Current Buffer' },
    ['gh'] = { '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
      'Peek GH Link' },
    w = {
      name = 'Workspace',
      a = { vim.lsp.buf.add_workspace_folder, 'Add Wordpace Folder' },
      r = { vim.lsp.buf.remove_workspace_folder, 'Remove Wordpace Folder' },
      l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'List Wordpace Folder' },
    }
  }
}
