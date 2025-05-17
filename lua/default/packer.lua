-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use { "ellisonleao/gruvbox.nvim" }
  
  use ( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

  use ('nvim-treesitter/playground')

  use ('mbbill/undotree')

  use ('easymotion/vim-easymotion')
  
  use ('christoomey/vim-tmux-navigator')

  use ('jiangmiao/auto-pairs')

  use ('ThePrimeagen/vim-be-good')
  
  use('vim-airline/vim-airline')

  use('vim-airline/vim-airline-themes')

  use ('tpope/vim-fugitive')
end)
