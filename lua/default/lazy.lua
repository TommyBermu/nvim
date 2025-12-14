-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- Colorscheme
    { "ellisonleao/gruvbox.nvim" },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },

    { 'nvim-treesitter/playground' },

    -- Undotree
    { 'mbbill/undotree' },

    -- Easymotion
    { 'easymotion/vim-easymotion' },

    -- Tmux navigator
    { 'christoomey/vim-tmux-navigator' },

    -- Autopairs
    { 'windwp/nvim-autopairs' },

    -- Vim Be Good (practice game)
    { 'ThePrimeagen/vim-be-good' },

    -- Airline (statusline)
    { 'vim-airline/vim-airline' },
    { 'vim-airline/vim-airline-themes' },

    -- Git integration
    { 'tpope/vim-fugitive' },

    -- LSP Plugins
    { 'neovim/nvim-lspconfig' },    -- Configuraciones para Language Servers
    { 'hrsh7th/nvim-cmp' },         -- Autocompletado
    { 'hrsh7th/cmp-nvim-lsp' },     -- LSP source para nvim-cmp
    { 'hrsh7th/cmp-buffer' },       -- Buffer completions
    { 'hrsh7th/cmp-path' },         -- Path completions
    { 'hrsh7th/cmp-cmdline' },      -- Commandline completions
    { 'L3MON4D3/LuaSnip' },         -- Snippet engine
    { 'saadparwaiz1/cmp_luasnip' }, -- Snippet completions

    -- Herramientas para Rust
    {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recomendado para evitar breaking changes
        lazy = false,   -- Este plugin ya es lazy por defecto
    },

    -- LSP UI improvements
    { 'nvim-tree/nvim-web-devicons' }, -- Icons
    {
        'folke/trouble.nvim',          -- Error lens / diagnostics
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- Mason para instalar LSP servers automáticamente
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },

    -- Herramientas adicionales para C/C++
    { 'p00f/clangd_extensions.nvim' }, -- Extensiones para clangd
})
