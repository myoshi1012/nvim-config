local ok, db = pcall(require, "dashboard")

if not ok then
  return
end

local home = os.getenv('HOME')
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
    shortcut = ':enew       ',
    action = 'enew',
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
    action = "Telescope find_files hidden=tro_ignore=true",
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
  {
    icon = "  ",
    desc = "Update plugins                  ",
    shortcut = ":PackerSync ",
    action = "PackerSync",
  },
  { icon = '  ',
    desc = 'Browse dotfiles                 ',
    shortcut = "<Leader> v d",
    action = 'Telescope find_files cwd=' .. home .. '/.config/nvim/ search_dirs=lua,init.lua',
  },
}
