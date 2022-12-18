local ok, indent_blankline = pcall(require, 'indent_blankline')

if not ok then
  return
end

indent_blankline.setup {
  space_char_blankline = ' ',
  use_treesitter = true,
  show_current_context = true,
  context_patterns = {
    'class', 'return', 'function', 'method', '^if', 'if', '^while', 'jsx_element', '^for', 'for',
    '^object', '^table', 'block', 'arguments', 'if_statement', 'else_clause', 'jsx_element',
    'jsx_self_closing_element', 'try_statement', 'catch_clause', 'import_statement',
    'operation_type'
  }
}
