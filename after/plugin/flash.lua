-- flash.nvim: saltos rápidos por la pantalla (reemplaza a easymotion)
local ok, flash = pcall(require, "flash")
if not ok then
    return
end

flash.setup({
    -- defaults sensatos; se puede personalizar labels, modos, etc.
})

-- s  -> salto flash (escribe 1-2 caracteres y salta a la etiqueta)
-- S  -> salto por nodos de Treesitter (selecciona bloques de código)
-- Funciona en normal (n), visual (x) y operator-pending (o).
vim.keymap.set({ "n", "x", "o" }, "s", function() flash.jump() end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function() flash.treesitter() end, { desc = "Flash Treesitter" })

-- r  -> flash en modo operator remoto (ej. yr para operar en otro lugar)
vim.keymap.set("o", "r", function() flash.remote() end, { desc = "Remote Flash" })
