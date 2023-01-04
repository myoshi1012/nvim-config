local lspconfig = require 'lspconfig'
local util = require 'lspconfig/util'
local configs = require 'lspconfig/configs'

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border
  opts.pad_top = 1
  opts.pad_bottom = 1
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local default_capabilities = require 'cmp_nvim_lsp'.default_capabilities()
default_capabilities.textDocument.foldingRang = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

-- golang
lspconfig.gopls.setup {
  cmd = { 'gopls', 'serve' },
  filetypes = { 'go', 'gomod' },
  root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
  on_attach = function()
    local function go_org_imports(wait_ms)
      local params = vim.lsp.util.make_range_params()
      params.context = { only = { 'source.organizeImports' } }
      local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, wait_ms)
      for cid, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
          if r.edit then
            local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
            vim.lsp.util.apply_workspace_edit(r.edit, enc)
          end
        end
      end
    end

    local au_go_lsp = vim.api.nvim_create_augroup('go_lsp', { clear = true })
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*.go',
      group = au_go_lsp,
      callback = function()
        go_org_imports()
        vim.lsp.buf.formatting_sync()
      end
    })
  end
}


-- lua
lspconfig.sumneko_lua.setup {
  capabilities = default_capabilities,
  on_attach = function(client)
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

-- tsserver
lspconfig.tsserver.setup {
  capabilities = default_capabilities,
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
  end,
  filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
}


-- require 'lspconfig'['eslint'].setup {
--   on_attach = function(client)
--     client.server_capabilities.document_formatting = true
--     if client.server_capabilities.document_formatting then
--       local au_lsp = vim.api.nvim_create_augroup('eslint_lsp', { clear = true })
--       vim.api.nvim_create_autocmd('BufWritePre', {
--         pattern = '*',
--         callback = function()
--           vim.lsp.buf.formatting_sync()
--         end,
--         group = au_lsp,
--       })
--     end
--   end,
-- }

lspconfig.jsonls.setup {
  capabilities = default_capabilities,
  init_options = {
    provideFormatter = false
  },
  settings = {
    json = {
      schemas = require 'schemastore'.json.schemas(),
      validate = { enable = true },
    }
  }
}
