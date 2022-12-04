require 'keymaps'
require 'plugins'
require 'lualine-bubble'

-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
local cmd = vim.cmd
local g = vim.g
local opt = vim.opt
local api = vim.api

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a' -- enable mouse support
opt.clipboard = 'unnamedplus' -- copy/paste to system clipboard
opt.swapfile = false -- don't use swapfile
opt.guifont = 'CaskaydiaCove Nerd Font'
opt.sessionoptions['blank'] = nil
g.rooter_patterns = { '.git', 'package.json', 'go.mod' }

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true -- show line number
opt.showmatch = true -- highlight matching parenthesis
opt.foldmethod = 'marker' -- enable folding (default 'foldmarker')
opt.colorcolumn = '80' -- line lenght marker at 80 columns
opt.splitright = true -- vertical split to the right
opt.splitbelow = true -- orizontal split to the bottom
opt.ignorecase = true -- ignore case letters when search
opt.smartcase = true -- ignore lowercase for the whole pattern
opt.linebreak = true -- wrap on word boundary

-- remove whitespace on save
cmd [[au BufWritePre * :%s/\s\+$//e]]


-- highlight on yank
api.nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)


-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true -- enable background buffers
opt.history = 100 -- remember n lines in history
opt.lazyredraw = true -- faster scrolling
opt.synmaxcol = 240 -- max column for syntax highlight

-----------------------------------------------------------
-- Colorscheme
-----------------------------------------------------------
opt.termguicolors = true -- enable 24-bit RGB colors

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 4 -- shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.smartindent = true -- autoindent new lines


-- don't auto commenting new lines
--cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- remove line lenght marker for selected filetypes
--cmd [[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]]

-- 2 spaces for selected filetypes
cmd [[
  autocmd FileType json,xml,html,xhtml,css,scss,javascript,lua,yaml,typescriptreact,typescript setlocal shiftwidth=2 tabstop=2
]]


-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------
-- insert mode completion options
opt.completeopt = 'menu,menuone,noselect'

-----------------------------------------------------------
-- Terminal
-----------------------------------------------------------
-- open a terminal pane on the right using :Term
-- cmd [[command Term :botright vsplit term://$SHELL]]

-- Terminal visual tweaks
--- enter insert mode when switching to terminal
--- close terminal buffer on process exit
cmd [[
  autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
  autocmd TermOpen * startinsert
  autocmd BufLeave term://* stopinsert
]]


-----------------------------------------------------------
-- Neovide
-----------------------------------------------------------
g.neovide_floating_opacity = 1.0
g.neovide_cursor_vfx_mode = "railgun"
g.neovide_cursor_vfx_opacity = 300.0
g.neovide_cursor_vfx_particle_lifetime = 1.5
g.neovide_cursor_vfx_particle_density = 8.0
g.neovide_cursor_vfx_particle_speed = 15.0
g.neovide_cursor_vfx_particle_curl = 0.1
