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
  pattern = vim.fn.expand '~' .. '/.config/nvim/lua/plugins/**/*.lua',
  command = 'source ' .. vim.fn.expand '~' .. '/.config/nvim/lua/plugins/init.lua' .. ' | PackerCompile'
})

return require 'packer'.startup(function(use)
  use { 'wbthomason/packer.nvim' }
  use { 'nvim-lua/plenary.nvim' }

  -- {{{ LSP
  use { 'neovim/nvim-lspconfig', config = get_config 'lsp.lsp' }

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
      local saga = require 'lspsaga'
      saga.init_lsp_saga {
        border_style = 'rounded'
      }
    end,
  }
  --}}} LSP

  -- {{{ Telescope
  use { 'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'nvim-telescope/telescope-project.nvim',
        requires = {
          { 'nvim-telescope/telescope-file-browser.nvim' },
        }
      },
      { 'nvim-telescope/telescope-ui-select.nvim' }
    },
    config = function()
      require 'plugins.configs.telescope'
    end
  }
  -- }}} Telescope

  -- {{{ Coding
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

  use { 'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' }
    },
    config = get_config 'nvim-cmp'
  }

  use { 'L3MON4D3/LuaSnip',
    tag = 'v1.*',
    requires = {
      { 'saadparwaiz1/cmp_luasnip' },
      { 'rafamadriz/friendly-snippets' }
    },
    config = function()
      local luasnip = require 'luasnip'
      luasnip.filetype_extend('typescript', { 'typescript' })
      luasnip.filetype_extend('typescriptreact', { 'react-es7' })
      require 'luasnip.loaders.from_vscode'.lazy_load()
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
  use { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' }
  use { 'windwp/nvim-ts-autotag', }

  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require 'todo-comments'.setup()
    end
  }

  use {
    'folke/which-key.nvim',
    config = get_config 'which-key'
  }
  -- }}} Coding

  -- {{{ Git/Github
  use { 'lewis6991/gitsigns.nvim',
    tag = 'release',
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

  use { 'ruanyl/vim-gh-line' }

  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim',
    config = function()
      require 'diffview'.setup()
    end
  }
  -- }}} Git/Github

  -- {{{ UI
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
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
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = get_config 'lualine'
    -- opt = true,
  }

  use { 'folke/tokyonight.nvim',
    config = get_config 'themes.tokyonight'
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
