local ok, db = pcall(require, 'dashboard')

if not ok then
  return
end

-- vim.api.nvim_create_autocmd("TabNewEntered", {
--   pattern = "*",
--   command = "Dashboard"
-- })

db.custom_header = {
  '仕事なんてやめよ？            ',
  '°　　  \\　　°　     ／ ￣ ＼ ',
  ' 　　　 \\　◯　。　  |　　　| ',
  '＼ ､＿ ノ\\　　　　　＼ ＿ ／ ',
  '。＼　　  \\　　   　。       ',
  '　　＼＿ノ \\  ⊂(´･_･`)⊃　　◯ ',
  '　◯　 ＼　  \\     ︶　　゜   ',
  '。　　　＼　 \\　゜　。　 ◯　°',
  ' 　　　　　︶　゜◯            ',
  '◯　。／ ￣ ＼　゜　　◯　。°   ',
  '',
}

db.custom_center = {
  {
    icon = '  ',
    desc = 'New file                        ',
    shortcut = '<Leader> n n',
    action = 'DashboardNewFile',
  },
  { icon = '  ',
    desc = 'Load session                    ',
    shortcut = '<Leader> s l',
    action = 'SessionManager load_session'
  },
  {
    icon = '  ',
    desc = 'Find file                       ',
    shortcut = '<Leader> f f',
    action = 'Telescope find_files hidden=tro_ignore=true',
  },
  { icon = '  ',
    desc = 'File Browser                    ',
    action = 'Telescope file_browser',
    shortcut = '<Leader> f b' },
  { icon = '  ',
    desc = 'Find word                       ',
    action = 'Telescope live_grep',
    shortcut = '<Leader> f w'
  },
  { icon = '  ',
    desc = 'Browse dotfiles                 ',
    shortcut = '<Leader> f d',
    action = 'Telescope find_files cwd=' .. os.getenv 'HOME' .. '/.config/nvim/ search_dirs=lua,init.lua',
  },
  {
    icon = '  ',
    desc = 'Update plugins                  ',
    shortcut = ':PackerSync ',
    action = 'PackerSync',
  },
}
