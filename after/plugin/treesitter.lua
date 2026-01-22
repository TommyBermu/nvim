-- Verificar que treesitter esté instalado antes de configurar
local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    return
end

treesitter.setup({
    ensure_installed = {
        "c",
        "lua",
        "vim",
        "rust",
        "python",
        "json"
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})
