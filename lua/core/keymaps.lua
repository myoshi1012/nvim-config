local map = vim.api.nvim_set_keymap
local g = vim.g -- global variables:w

g.mapleader = ',' -- change leader to a comma

map('n', '<Leader>ww', '<Cmd>w<CR>', { noremap = true })
map('n', '<Leader>wq', '<Cmd>wq<CR>', { noremap = true })
map('n', '<Leader>qq', '<Cmd>q<CR>', { noremap = true })
map('n', '<Leader>qa', '<Cmd>qa<CR>', { noremap = true })
map('n', '<leader>rr', '<cmd>ReloadNvimConf<CR>', { noremap = true })
map('n', '<leader>tn', '<cmd>tabnew<CR>', { noremap = true })
map('n', '<leader>tc', '<cmd>tabclose<CR>', { noremap = true })

-- Getting stuck in ~~vim~~ terminal
map('t', '<Esc>', '<C-\\><C-n>', {})

-- Reload vimrc

-- Quick cursor movement
map('n', '<C-Down>', '5j', { noremap = true })
map('n', '<C-Up>', '5k', { noremap = true })

-- Quick pasting/yoinking to system register
map('n', '+y', '\"+y', { noremap = true })
map('n', '+p', '\"+p', { noremap = true })
map('n', '+d', '\"+d', { noremap = true })

map('n', '*y', '\"*y', { noremap = true })
map('n', '*p', '\"*p', { noremap = true })
map('n', '*d', '\"*d', { noremap = true })


vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
