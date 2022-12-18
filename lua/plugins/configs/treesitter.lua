local ok, ts_config = pcall(require, 'nvim-treesitter.configs')

if not ok then
  return
end

ts_config.setup {
  autotag = { enable = true },
  highlight = { enable = true },
  context_commentstring = {
    enable = true
  },
  rainbow = {
    enable = false,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  }
}
