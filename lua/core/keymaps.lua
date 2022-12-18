local map = vim.api.nvim_set_keymap
local g = vim.g -- global variables:w

g.mapleader = ',' -- change leader to a comma

map('n', '<Leader>w', '<Cmd>w<CR>', { noremap = true })
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

--- NvimTree
-- map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { noremap = true })
-- map("n", "<space>nr", "<cmd>NvimTreeRefresh<CR>", { noremap = true })
-- map("n", "<space>nf", "<cmd>NvimTreeFindFile<CR>", { noremap = true })

-- Telescope
-- map("n", "<leader>ff", ":lua require'telescope.builtin'.find_files()<Cr>", { noremap = true, silent = true })
-- map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true })
-- map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true })
-- map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { noremap = true })
-- map("n", "<leader>fb", "<cmd>Telescope file_browser<cr>", { noremap = true })
map('n', '<space>p', ":lua require'telescope'.extensions.project.project{}<cr>", { noremap = true, silent = true })

-- Session Manager
map('n', '<leader>sl', '<Cmd>SessionManager load_session<CR>', { noremap = true })


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
