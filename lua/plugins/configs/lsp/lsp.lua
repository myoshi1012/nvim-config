local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border
  opts.pad_top = 1
  opts.pad_bottom = 1
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local lsp_formatting = function(bufnr)
  local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  vim.lsp.buf.format {
    filter = function(client)
      if filetype == 'lua' then
        -- apply whatever logic you want (in this example, we'll only use null-ls)
        return client.name == 'sumneko_lua'
      end
      if filetype == 'typescript' or filetype == 'typescriptreact' or filetype == 'typescript.tsx' then
        return client.name == 'tsserver'
      end
    end,
    bufnr = bufnr,
  }
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local telescope = require 'telescope.builtin'

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gx', telescope.diagnostics, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', telescope.lsp_definitions, bufopts)
  vim.keymap.set('n', 'gi', telescope.lsp_implementations, bufopts)
  vim.keymap.set('n', 'gr', telescope.lsp_references, bufopts)
  vim.keymap.set('n', 't', telescope.lsp_dynamic_workspace_symbols, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', telescope.lsp_type_definitions, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)


  -- Avoid formatting conflicts
  --[[ if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end ]]
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require 'lspconfig'['tsserver'].setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    on_attach(client, bufnr)
  end,
  filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
  flags = lsp_flags,
}

require 'lspconfig'.sumneko_lua.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    client.server_capabilities.document_formatting = true
    if client.server_capabilities.document_formatting then
      local au_lsp = vim.api.nvim_create_augroup('lua_lsp', { clear = true })
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.lua',
        callback = function()
          vim.lsp.buf.formatting_sync()
        end,
        group = au_lsp,
      })
    end
  end,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}


require 'lspconfig'['eslint'].setup {
  flags = lsp_flags,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    client.server_capabilities.document_formatting = true
    if client.server_capabilities.document_formatting then
      local au_lsp = vim.api.nvim_create_augroup('eslint_lsp', { clear = true })
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*',
        callback = function()
          vim.lsp.buf.formatting_sync()
        end,
        group = au_lsp,
      })
    end
  end,
}

local capabilities_jsonls = vim.lsp.protocol.make_client_capabilities()
capabilities_jsonls.textDocument.completion.completionItem.snippetSupport = true
require 'lspconfig'['jsonls'].setup {
  capabilities = capabilities_jsonls
}
