local ok, null_ls = pcall(require, 'null-ls')
if not ok then
  return
end

local cspell_opts = {
  extra_args = { '--config', '.vscode/cspell.json' },
  condition = function(utils)
    return utils.has_file '.vscode/cspell.json'
  end
}

local sources = {
  null_ls.builtins.diagnostics.cspell.with {
    unpack(cspell_opts),
    condition = function(utils)
      return utils.has_file '.vscode/cspell.json'
    end,
    diagnostics_postprocess = function(diagnostic)
      diagnostic.severity = vim.diagnostic.severity['WARN']
    end,
  },
  null_ls.builtins.code_actions.cspell.with(cspell_opts),
  null_ls.builtins.code_actions.eslint.with {
    prefer_local = 'node_modules/.bin'
  },
  null_ls.builtins.diagnostics.eslint.with {
    prefer_local = 'node_modules/.bin'
  },
  null_ls.builtins.formatting.prettier.with {
    prefer_local = 'node_modules/.bin'
  },
  null_ls.builtins.diagnostics.tsc.with {
    local_only = 'node_modules/.bin',
  },
  null_ls.builtins.diagnostics.golangci_lint.with {},
  null_ls.builtins.code_actions.gitsigns.with {
    config = {
      filter_actions = function(title)
        -- filter out blame actions
        return title:lower():match 'blame' == nil
      end,
    },
  }
}

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

null_ls.setup { sources = sources, debug = true,
  on_attach = function(client, bufnr) -- enable format on save
    if client.supports_method 'textDocument/formatting' then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}

vim.api.nvim_create_user_command('NullLsToggle', function()
  -- you can also create commands to disable or enable sources
  require 'null-ls'.toggle {}
end, {})
