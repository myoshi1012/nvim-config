local ok, todo = pcall(require, 'todo-comments')
if not ok then
  return
end

todo.setup {
  signs = true, -- show icons in the signs column
  sign_priority = 8, -- sign priority
  -- keywords recognized as todo comments
  -- keywords = {
  --   FIX = {
  --     icon = ' ', -- icon used for the sign, and in search results
  --     color = 'error', -- can be a hex color, or a named color (see below)
  --     alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
  --     -- signs = false, -- configure signs for some keywords individually
  --   },
  -- }
}
