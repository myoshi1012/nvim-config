local ok, session_manager = pcall(require, 'session_manager')

if not ok then
  return
end

session_manager.setup {
  autoload_mode = require 'session_manager.config'.AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
  autosave_only_in_session = true, -- Always autosaves session. If true, only autosaves after a session is active.
}

local config_group = vim.api.nvim_create_augroup('MyConfigGroup', {})

vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = 'SessionLoadPost',
  group = config_group,
  callback = function()
    require 'nvim-tree'.toggle(false, true)
  end,
})
