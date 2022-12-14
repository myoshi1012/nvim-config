local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

local aug_id = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = aug_id,
  pattern = vim.fn.expand("~") .. "/.config/nvim/lua/plugins/*.lua",
  command = "source " .. vim.fn.expand("~") .. "/.config/nvim/lua/plugins/init.lua" .. " | PackerCompile"
})

return require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }

  use { 'glepnir/dashboard-nvim',
    config = function()
      require('plugins.configs.dashboard')
    end
  }

  use { 'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins.configs.nvim_web_devicons')
    end
  }

  use { 'Shatur/neovim-session-manager',
    config = function()
      require('plugins.configs.session_manager')
    end,
  }

  use { 'neovim/nvim-lspconfig',
    config = {}
  }

  use { "lukas-reineke/indent-blankline.nvim",
    config = function()
      require('plugins.configs.indent_blankline')
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use { 'tpope/vim-fugitive' }

  use { 'tpope/vim-commentary' }

  use { 'airblade/vim-rooter' }


  use { "akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
      require('toggleterm').setup({
        open_mapping = [[<c-\>]]
      })
    end
  }

  use { 'neoclide/coc.nvim',
    branch = 'release',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require("plugins.configs.coc")
    end,
  }

  use { 'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    tag = 'release',
    config = function()
      require('gitsigns').setup()
    end
  }

  use { 'p00f/nvim-ts-rainbow', cond = is_not_vscode }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        autotag = { enable = true },
        highlight = { enable = true },
        context_commentstring = {
          enable = true
        },
        rainbow = {
          enable = false,
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil, -- Do not enable for files with more than n lines, int
        }
      })
    end,
  }

  use { 'sheerun/vim-polyglot' }

  use { 'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('plugins.configs.telescope')
    end
  }

  use { 'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make' }

  use { 'nvim-telescope/telescope-project.nvim',
    requires = {
      { 'nvim-telescope/telescope-file-browser.nvim' },
    }
  }

  use { 'nvim-telescope/telescope-ui-select.nvim' }

  use {
    'ojroques/nvim-lspfuzzy',
    requires = {
      { 'junegunn/fzf' },
      { 'junegunn/fzf.vim' }, -- to enable preview (optional)
    },
    config = function()
      require('lspfuzzy').setup()
    end
  }

  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('diffview').setup()
    end
  }

  use { 'windwp/nvim-ts-autotag', }

  use { 'JoosepAlviste/nvim-ts-context-commentstring', }

  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end
  }

  use { 'navarasu/onedark.nvim',
    config = function()
      require('plugins.configs.others').onedark()
    end,
  }

  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require "octo".setup()
    end
  }

  use {
    "tversteeg/registers.nvim",
    config = function()
      require("registers").setup()
    end,
  }
  --use { "ellisonleao/glow.nvim" }

  use { 'kdheepak/lazygit.nvim' }

  use { 'folke/tokyonight.nvim',
    config = function()
      require('tokyonight').setup({
        style = 'night'
      })
    end
  }

  use { 'ruanyl/vim-gh-line' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
