require 'plugins.configs.themes'

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

local function get_config(name)
  return string.format('require("plugins/configs/%s")', name)
end

local aug_id = vim.api.nvim_create_augroup('packer_user_config', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = aug_id,
  pattern = vim.fn.expand '~' .. '/.config/nvim/lua/plugins/*.lua',
  command = 'source ' .. vim.fn.expand '~' .. '/.config/nvim/lua/plugins/init.lua' .. ' | PackerCompile'
})

return require 'packer'.startup(function(use)
  use { 'rcarriga/nvim-notify', config = get_config 'notify' }
  use { 'wbthomason/packer.nvim' }
  use { 'nvim-lua/plenary.nvim' }

  use { 'b0o/schemastore.nvim' }

  use { 'L3MON4D3/LuaSnip',
    tag = 'v1.*',
    requires = {
      { 'rafamadriz/friendly-snippets' }
    },
    config = function()
      local luasnip = require 'luasnip'
      luasnip.filetype_extend('typescript', { 'typescript' })
      luasnip.filetype_extend('typescriptreact', { 'react-es7' })
      -- require 'luasnip.loaders.from_vscode'.lazy_load()
    end
  }

  use { 'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-nvim-lsp', after = { 'nvim-cmp' } },
      { 'hrsh7th/cmp-buffer',   after = { 'nvim-cmp' } },
      { 'hrsh7th/cmp-path',     after = { 'nvim-cmp' } },
      { 'hrsh7th/cmp-cmdline',  after = { 'nvim-cmp' } }
    },
    after = { 'nvim-autopairs' },
    config = get_config 'nvim-cmp'
  }

  use { 'saadparwaiz1/cmp_luasnip', after = { 'nvim-cmp' } }

  -- {{{ LSP
  use { 'neovim/nvim-lspconfig',
    after = { 'nvim-cmp', 'cmp-nvim-lsp' },
    config = get_config 'lsp.lspconfig'
  }

  use { 'williamboman/mason.nvim',
    requires = { 'williamboman/mason-lspconfig.nvim' },
    config = get_config 'lsp.mason'
  }

  use { 'jose-elias-alvarez/null-ls.nvim',
    config = get_config 'lsp.null-ls'
  }

  use {
    'ojroques/nvim-lspfuzzy',
    requires = {
      { 'junegunn/fzf' },
      { 'junegunn/fzf.vim' }, -- to enable preview (optional)
    },
    config = function()
      require 'lspfuzzy'.setup()
    end
  }

  use {
    'glepnir/lspsaga.nvim',
    branch = 'main',
    config = function()
      require 'lspsaga'.setup {
        ui = {
          border = 'none'
        }
      }
    end,
  }
  --}}} LSP

  -- {{{ Telescope
  use { 'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      {
        'nvim-telescope/telescope-project.nvim',
        requires = {
          { 'nvim-telescope/telescope-file-browser.nvim' },
        }
      },
      { 'nvim-telescope/telescope-ui-select.nvim' }
    },
    config = get_config 'telescope'
  }
  -- }}} Telescope

  -- {{{ DAP
  use { 'mfussenegger/nvim-dap',
    requires = { 'leoluz/nvim-dap-go' },
    config = get_config 'dap.go'
  }

  use {
    'rcarriga/nvim-dap-ui',
    requires = {
      'nvim-treesitter/nvim-treesitter'
    },
    config = function()
      vim.fn.sign_define('DapBreakpoint', { text = '⛔', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = '', numhl = '' })
      require 'dapui'.setup()
    end
  }
  -- }}} DAP

  -- {{{ Coding
  use {
    'windwp/nvim-autopairs',
    config = function()
      require 'nvim-autopairs'.setup {
        disable_filetype = { 'TelescopePrompt', 'vim' },
      }
    end
  }

  -- use { 'anuvyklack/pretty-fold.nvim',
  --   config = function()
  --     require 'pretty-fold'.setup()
  --   end
  -- }

  use { 'kevinhwang91/nvim-ufo',
    requires = { 'kevinhwang91/promise-async', },
    after = { 'nvim-treesitter', 'nvim-lspconfig' },
    config = get_config 'ufo'
  }

  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = get_config 'trouble'
  }

  use {
    'numToStr/Comment.nvim',
    requires = { { 'JoosepAlviste/nvim-ts-context-commentstring', } },
    config = function()
      require 'Comment'.setup {
        pre_hook = require 'ts_context_commentstring.integrations.comment_nvim'.create_pre_hook()
      }
    end
  }



  use { 'lukas-reineke/indent-blankline.nvim',
    config = get_config 'indent_blankline'
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      { 'sheerun/vim-polyglot' },
    },
    config = get_config 'treesitter'
  }
  use { 'p00f/nvim-ts-rainbow', after = { 'nvim-treesitter' } }
  use { 'windwp/nvim-ts-autotag', }

  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = get_config 'todo-comments'
  }

  use {
    'folke/which-key.nvim',
    requires = {
      'nvim-telescope/telescope.nvim',
    },
    config = get_config 'which-key'
  }

  use { 'simrat39/symbols-outline.nvim', config = function()
    require 'symbols-outline'.setup()
  end }
  -- }}} Coding

  -- {{{ Git/Github
  use { 'lewis6991/gitsigns.nvim',
    config = get_config 'gitsigns'
  }

  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require 'octo'.setup()
    end
  }


  use {
    'ruifm/gitlinker.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require 'gitlinker'.setup {
        mappings = '<space>zz'
      }
    end
  }

  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim',
    config = function()
      require 'diffview'.setup()
    end
  }
  -- }}} Git/Github

  -- {{{ UI
  use { 'nvim-tree/nvim-web-devicons' }
  use { 'romgrk/barbar.nvim', wants = 'nvim-web-devicons' }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly',                 -- optional, updated every week. (see issue #1193)
    config = get_config 'nvim-tree'
  }

  use { 'glepnir/dashboard-nvim',
    config = get_config 'dashboard',
    cmd = { 'Dashboard*' }
  }
  use { 'kyazdani42/nvim-web-devicons',
    config = get_config 'nvim_web_devicons'
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = get_config 'lualine'
  }

  use { 'folke/tokyonight.nvim',
    config = get_config 'themes.tokyonight'
  }

  use { 'catppuccin/nvim',
    as = 'catppuccin',
    config = get_config 'themes.catppuccin'
  }
  -- }}} UI

  use {
    'tversteeg/registers.nvim',
    config = function()
      require 'registers'.setup()
    end,
  }

  use { 'Shatur/neovim-session-manager',
    config = get_config 'session_manager'
  }

  -- use {
  --   'ahmedkhalf/project.nvim',
  --   config = function()
  --
  --     require 'project_nvim'.setup {
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     }
  --   end
  -- }

  use { 'airblade/vim-rooter' }

  use { 'akinsho/toggleterm.nvim',
    tag = '*',
    config = function()
      require 'toggleterm'.setup {
        open_mapping = [[<c-]>]]
      }
    end
  }

  --use { "ellisonleao/glow.nvim" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require 'packer'.sync()
  end
end)
