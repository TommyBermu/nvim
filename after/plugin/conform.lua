local ok, conform = pcall(require, "conform")
if not ok then
    return
end

-- Asegurar que las herramientas instaladas por Mason (black, isort) estén en el PATH
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
if not string.find(vim.env.PATH or "", mason_bin, 1, true) then
    vim.env.PATH = mason_bin .. ":" .. (vim.env.PATH or "")
end

conform.setup({
    formatters_by_ft = {
        -- black para formateo, isort para ordenar imports
        python = { "isort", "black" },
    },
    -- Formatear al guardar (reemplaza al LSP para los filetypes de arriba)
    format_on_save = {
        timeout_ms = 1000,
        lsp_format = "fallback",
    },
})

-- Formateo manual con <space>f (mismo mapeo que ya usas para el LSP)
vim.keymap.set({ "n", "v" }, "<space>f", function()
    conform.format({
        async = true,
        lsp_format = "fallback",
    })
end, { desc = "Formatear buffer/seleccion" })
