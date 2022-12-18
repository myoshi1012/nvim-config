local ok, wk = pcall(require, 'which-key')
if not ok then
  return
end

wk.setup {}

wk.register {
  ['<C-N>'] = { '<cmd>NvimTreeToggle<cr>', 'NvimTreeToggle' },
  ['<leader>'] = {
    f = {
      name = 'file',
      f = { '<cmd>Telescope find_files<cr>', 'Find File' },
      g = { '<cmd>Telescope live_grep<cr>', 'Live Grep' },
      b = { '<cmd>Telescope file_browser<cr>', 'File Browser' },
      h = { '<cmd>Telescope help_tags<cr>', 'Help Tags' },
      r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
      d = { '<cmd>Telescope find_files cwd=' .. os.getenv 'HOME' .. '/.config/nvim/<cr>', 'Find in Dotfiles' },
    },
    n = {
      name = 'NvimTree',
      r = { '<cmd>NvimTreeRefresh<cr>', 'NvimTreeRefresh' },
      f = { '<cmd>NvimTreeFindFile<cr>', 'NvimTreeFindFile' },
    }
  }
}
