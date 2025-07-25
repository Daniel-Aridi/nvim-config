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

-- Auto-compile when plugins.lua changes
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Colorscheme
  use 'ellisonleao/gruvbox.nvim'

  -- File explorer
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'

  -- Status line
  use 'nvim-lualine/lualine.nvim'

  -- Syntax highlighting
  use 'nvim-treesitter/nvim-treesitter'

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- Autopairs
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
    end,
  }

  -- ===== NEW PLUGINS FOR INTELLISENSE =====
  -- LSP Support
  use 'neovim/nvim-lspconfig'             -- Config for LSP
  use 'williamboman/mason.nvim'           -- LSP installer
  use 'williamboman/mason-lspconfig.nvim' -- Bridge between Mason & LSP

  -- Autocompletion
  use 'hrsh7th/nvim-cmp'     -- Completion engine
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-buffer'   -- Buffer words completion
  use 'hrsh7th/cmp-path'     -- Path completion
  use 'hrsh7th/cmp-cmdline'  -- Command line completion

  -- Snippets
  use 'L3MON4D3/LuaSnip'         -- Snippet engine
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp

  -- UI Enhancements
  use 'onsails/lspkind-nvim' -- VS Code-like icons
  -- ===== END NEW PLUGINS =====




  -- Automatically set up configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)
