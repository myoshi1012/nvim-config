local ok, telescope = pcall(require, 'telescope')

if not ok then
  return
end

telescope.setup({
  defaults = {
    hidden = true,
    file_ignore_patterns = { "node_modules" }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    },
    ["file_brower"] = {
      theme = "ivy",
    }
  }
})
require('telescope').load_extension('fzf')
require('telescope').load_extension('project')
require("telescope").load_extension("ui-select")
require("telescope").load_extension("file_browser")
