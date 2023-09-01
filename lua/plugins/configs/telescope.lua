local ok, telescope = pcall(require, 'telescope')

if not ok then
  return
end

telescope.setup {
  defaults = {
    path_display = {
      'smart'
      --shorten = {
      --  len = 3, exclude = { 1, -1 }
      --},
      --truncate = true,
    },
    dynamic_preview_title = true,
    hidden = true,
    file_ignore_patterns = { 'node_modules', '.*.git/.*' }
  },
  pickers = {
    find_files = {
      hidden = true
    },
    buffers = { path_display = { 'tail' }, }
  },
  extensions = {
    ['ui-select'] = {
      require 'telescope.themes'.get_dropdown {}
    },
    ['file_browser'] = {
      hidden = true,
      theme = 'ivy',
    },
    ['project'] = {
      base_dirs = {},
      hidden_files = true,
      sync_with_nvim_tree = true
    }
  },
}
require 'telescope'.load_extension 'fzf'
require 'telescope'.load_extension 'project'
require 'telescope'.load_extension 'ui-select'
require 'telescope'.load_extension 'file_browser'
require 'telescope'.load_extension 'notify'

--require 'telescope'.load_extension 'projects'
--require 'telescope'.extensions.projects.projects {}
