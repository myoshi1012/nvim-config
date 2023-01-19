require 'catppuccin'.setup {
  flavour = 'mocha',
  -- custom_highlights = function(colors)
  --     return {
  --         ['UfoFoldedBg']=  macchiato.
  --     }
  -- end,
  integrations = {
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { 'italic' },
        hints = { 'italic' },
        warnings = { 'italic' },
        information = { 'italic' },
      },
      underlines = {
        errors = { 'undercurl' },
        hints = { 'undercurl' },
        warnings = { 'undercurl' },
        information = { 'undercurl' },
      },
    },
  },
}
