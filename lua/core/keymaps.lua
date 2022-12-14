local map = vim.api.nvim_set_keymap
local g = vim.g -- global variables

g.mapleader = ',' -- change leader to a comma

map("n", "<Leader>w", "<Cmd>w<CR>", { noremap = true })
map("n", "<Leader>qq", "<Cmd>q<CR>", { noremap = true })
map("n", "<Leader>qa", "<Cmd>qa<CR>", { noremap = true })
map("n", "<leader>r", "<cmd>ReloadNvimConf<CR>", { noremap = true })
map("n", "<leader>tn", "<cmd>tabnew<CR>", { noremap = true })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { noremap = true })

-- Getting stuck in ~~vim~~ terminal
map("t", "<Esc>", "<C-\\><C-n>", {})

-- Reload vimrc

-- Quick cursor movement
map("n", "<C-Down>", "5j", { noremap = true })
map("n", "<C-Up>", "5k", { noremap = true })

-- Quick pasting/yoinking to system register
map("n", "+y", "\"+y", { noremap = true })
map("n", "+p", "\"+p", { noremap = true })
map("n", "+d", "\"+d", { noremap = true })

map("n", "*y", "\"*y", { noremap = true })
map("n", "*p", "\"*p", { noremap = true })
map("n", "*d", "\"*d", { noremap = true })

--- NvimTree
-- map("n", "<C-n>", "<cmd>:NvimTreeToggle<CR>", {noremap = true})
-- map("n", "<leader>r", "<cmd>:NvimTreeRefresh<CR>", {noremap = true})
-- map("n", "<leader>n", "<cmd>:NvimTreeFindFile<CR>", {noremap = true})

-- CoC
map("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
map("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true, })
map("n", "qf", "<Plug>(coc-fix-current)", { silent = true })
map("n", "gd", "<Plug>(coc-definition)", { silent = true })
map("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
map("n", "gi", "<Plug>(coc-implementation)", { silent = true })
map("n", "gr", "<Plug>(coc-references)", { silent = true })
map("n", "rn", "<Plug>(coc-rename)", { silent = true })
map("x", "<leader>a", "<Plug>(coc-codeaction-selected)", {})
map("n", "<leader>a", "<Plug>(coc-codeaction-selected)", {})
map("n", "<leader>ac", "<Plug>(coc-codeaction)", {})
map("n", "<Leader>j", "<Plug>(coc-diagnostic-next-error)", { silent = true })
map("n", "<Leader>k", "<Plug>(coc-diagnostic-prev-error)", { silent = true })
map("i", "<CR>", "pumvisible() ? coc#_select_confirm() : '<C-G>u<CR><C-R>=coc#on_enter()<CR>'",
  { silent = true, expr = true, noremap = true })
map("n", "K", ":call CocActionAsync(\'doHover\')<CR>", { silent = true })
map("n", "<space>o", ":CocList -I symbols<CR>", { silent = true })
map("i", "<s-space>", "coc#refresh()", { silent = true, expr = true })
map("n", "-r", ":call CocActionAsync(\'format\')<CR>", { silent = true })
map("n", "-o", ":CocList outline<CR>", { silent = true })
map("n", "<Leader>lf", ":CocCommand eslint.executeAutofix<CR>", { silent = true })
map("n", "<space>d", ":call CocAction('jumpDefinition', v:false)<CR>", { silent = true, nowait = true })


-- coc-snippets
map("i", "<C-l>", "<Plug>(coc-snippets-expand)", {})
map("v", "<C-j>", "<Plug>(coc-snippets-select)", {})
g.coc_snippet_next = "<c-j>"
g.coc_snippet_prev = "<c-k>"
map("i", "<C-l>", "<Plug>(coc-snippets-expand-jump)", {})
map("x", "<leader>x", "<Plug>(coc-convert-snippet)", {})

-- coc-explorer
map("n", "<space>e", "<cmd>CocCommand explorer<cr>", {})
map("n", "<leader>er",
  "<Cmd>call CocAction('runCommand', 'explorer.doAction', 'closest', ['reveal:0'], [['relative', 0, 'file']])<CR>)",
  { silent = true, noremap = true })

-- Telescope
map("n", "<leader>ff", ":lua require'telescope.builtin'.find_files()<Cr>", { noremap = true, silent = true })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { noremap = true })
map("n", "<leader>fb", "<cmd>Telescope file_browser<cr>", { noremap = true })
map("n", "<space>p", ":lua require'telescope'.extensions.project.project{}<cr>", { noremap = true, silent = true })
map("n", "<leader>fd",
  '<cmd>Telescope find_files cwd=' .. os.getenv('HOME') .. '/.config/nvim/<CR>',
  { noremap = true, silent = true })

-- Session Manager
map("n", "<leader>sl", "<Cmd>SessionManager load_session<CR>", { noremap = true })
