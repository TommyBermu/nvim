-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use { "ellisonleao/gruvbox.nvim" }

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

    use('nvim-treesitter/playground')

    use('mbbill/undotree')

    use('easymotion/vim-easymotion')

    use('christoomey/vim-tmux-navigator')

    use('windwp/nvim-autopairs')

    use('ThePrimeagen/vim-be-good')

    use('vim-airline/vim-airline')

    use('vim-airline/vim-airline-themes')

    use('tpope/vim-fugitive')

    -- LSP Plugins

    use('neovim/nvim-lspconfig')            -- Configuraciones para Language Servers
    use('hrsh7th/nvim-cmp')                 -- Autocompletado
    use('hrsh7th/cmp-nvim-lsp')             -- LSP source para nvim-cmp
    use('hrsh7th/cmp-buffer')               -- Buffer completions
    use('hrsh7th/cmp-path')                 -- Path completions
    use('hrsh7th/cmp-cmdline')              -- Commandline completions
    use('L3MON4D3/LuaSnip')                 -- Snippet engine
    use('saadparwaiz1/cmp_luasnip')         -- Snippet completions


    -- LSP UI improvements
    use('nvim-tree/nvim-web-devicons')      -- Icons
    use {
        'folke/trouble.nvim',               -- Error lens / diagnostics
        requires = "nvim-tree/nvim-web-devicons",
    }

    -- Mason para instalar LSP servers automáticamente
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    }

    -- Herramientas adicionales para C/C++
    use('p00f/clangd_extensions.nvim')      -- Extensiones para clangd

end)
