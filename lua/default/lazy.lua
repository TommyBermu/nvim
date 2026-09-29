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
    -- Se usa la rama 0.1.x (rama estable) en vez de un tag fijo, para recibir fixes.
    -- Nota: el error histórico "ft_to_lang (a nil value)" NO era de telescope sino de
    -- tener nvim-treesitter en la rama `main` (ver el bloque de Treesitter más abajo).
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- fzf nativo (compilado en C) para un filtrado mucho más rápido.
            -- Requiere `make`; lazy lo compila con el campo `build`.
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        }
    },

    -- Colorscheme
    { "ellisonleao/gruvbox.nvim" },

    -- Treesitter
    -- Se fija la rama `master` (clásica/estable). La rama `main` es una reescritura
    -- que eliminó la API vieja (`nvim-treesitter.configs`, `ft_to_lang`, etc.) y rompe
    -- la compatibilidad con telescope 0.1.x y con la config de treesitter.lua.
    -- master mantiene `require('nvim-treesitter.configs').setup{...}` y `ft_to_lang`.
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'master',
        build = ':TSUpdate'
    },

    -- Undotree
    { 'mbbill/undotree' },

    -- Flash (saltos rápidos por pantalla; reemplaza a easymotion)
    { 'folke/flash.nvim' },

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
    -- nvim-web-devicons (iconos) se instala como dependencia de trouble y oil,
    -- así que no hace falta declararlo suelto.
    {
        'folke/trouble.nvim',          -- Error lens / diagnostics
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- Mason para instalar LSP servers automáticamente
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    -- Instala herramientas (formatters, linters) automáticamente vía Mason
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },

    -- Herramientas adicionales para C/C++
    { 'p00f/clangd_extensions.nvim' }, -- Extensiones para clangd

    -- para ver colores hex
    { 'catgoose/nvim-colorizer.lua' },

    -- Formatter (conform.nvim)
    { 'stevearc/conform.nvim' },

    -- which-key: muestra un menú con los atajos disponibles al pulsar <leader>
    { 'folke/which-key.nvim' },

    -- Explorador de archivos: editas el filesystem como si fuera un buffer
    {
        'stevearc/oil.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },

    -- Git signs: marca líneas cambiadas en la columna de signos + navegación de hunks
    { 'lewis6991/gitsigns.nvim' },
})
