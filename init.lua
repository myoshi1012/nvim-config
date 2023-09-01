if vim.g.vscode then
  require 'vscode'
else
  require 'core'
  require 'plugins'
  -- vim.api.nvim_create_autocmd('UIEnter', {
  --   once = true,
  --   callback = function()
  --     if (vim.api.nvim_get_vvar 'event'['chan']) == 1 then
  --       require 'core.nvim-qt'
  --     end
  --   end
  -- })
end
