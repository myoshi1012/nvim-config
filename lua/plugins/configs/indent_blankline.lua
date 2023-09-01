local ok, indent_blankline = pcall(require, 'indent_blankline')

if not ok then
  return
end

-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
--
-- vim.cmd [[highlight IndentBlanklineContextStart guisp=#C678DD gui=underline]]
-- vim.cmd [[highlight IndentBlanklineContextChar guifg=#C678DD gui=nocombine]]

indent_blankline.setup {
  show_end_of_line = true,
  space_char_blankline = ' ',
  show_current_context = true,
  show_current_context_start = true,
  -- context_patterns = {
  --   'class', 'return', 'function', 'method', '^if', 'if', '^while', 'jsx_element', '^for', 'for',
  --   '^object', '^table', 'block', 'arguments', 'if_statement', 'else_clause', 'jsx_element',
  --   'jsx_self_closing_element', 'try_statement', 'catch_clause', 'import_statement',
  --   'operation_type'
  -- },
  -- char_highlight_list = {
  --   'IndentBlanklineIndent1',
  --   'IndentBlanklineIndent2',
  --   'IndentBlanklineIndent3',
  --   'IndentBlanklineIndent4',
  --   'IndentBlanklineIndent5',
  --   'IndentBlanklineIndent6',
  -- },
}
