vim.g.coc_global_extensions = {
  'coc-json',
  'coc-sumneko-lua',
  'coc-pairs',
  'coc-snippets',
  'coc-prettier',
  'coc-eslint',
  'coc-json',
  'coc-yaml',
  'coc-tsserver',
  'coc-eslint',
  'coc-styled-components'
}

vim.api.nvim_create_user_command("Tsc", ":call CocAction(\"runCommand\", \"tsserver.watchBuild\")", { nargs = 0 })
