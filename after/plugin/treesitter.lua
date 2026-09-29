-- nvim-treesitter rama `main` (API nueva, para Neovim 0.12+).
-- OJO: esta rama es una reescritura. Ya NO existe `nvim-treesitter.configs`,
-- ni `ensure_installed`/`highlight={enable=true}`/`auto_install` de la API vieja.
-- - Los parsers se instalan con `require('nvim-treesitter').install{...}`.
-- - El highlighting lo provee Neovim y se activa con `vim.treesitter.start()`
--   en un autocmd FileType.
local ok, ts = pcall(require, "nvim-treesitter")
if not ok then
    return
end

-- setup es opcional; se deja el install_dir por defecto (stdpath('data')/site).
pcall(function()
    ts.setup({})
end)

-- Lista de lenguajes que quieres tener instalados.
local ensure = {
    "c",
    "lua",
    "vim",
    "vimdoc",
    "rust",
    "python",
    "json",
    "java",
    "bash",
    "markdown",
    "markdown_inline",
}

-- install() es asíncrono y es no-op si ya están instalados.
pcall(function()
    ts.install(ensure)
end)

-- Activar highlighting (y fold + indent experimental) por filetype.
-- Se envuelve en pcall por si un buffer no tiene parser disponible.
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        -- vim.treesitter.start usa el parser correspondiente al filetype del buffer.
        pcall(vim.treesitter.start)

        -- Folding basado en treesitter (opcional pero útil).
        pcall(function()
            vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end)

        -- Indentación por treesitter (experimental en la rama main).
        pcall(function()
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end)
    end,
})
