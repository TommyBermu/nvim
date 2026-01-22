require('nvim-treesitter.configs').setup({
    -- Lista de parsers a instalar
    ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "rust",
        "python",
        "javascript",
        "typescript",
        "html",
        "css",
        "json"
    },

    -- Instalar parsers de forma sincrónica
    sync_install = false,

    -- Instalar automáticamente parsers faltantes
    auto_install = true,

    -- Configuración de highlighting
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    -- Configuración de indentación
    indent = {
        enable = true
    },

    -- Configuración de incremental selection
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
})
