-- todo-comments: resalta comentarios tipo TODO:, FIXME:, HACK:, NOTE:, etc.
-- y permite navegar entre ellos y listarlos.
local ok, todo = pcall(require, "todo-comments")
if not ok then
    return
end

-- signs = false para no ocupar la columna de signos (ya la usan gitsigns/diagnósticos);
-- el resaltado del texto del comentario se mantiene.
todo.setup({
    signs = false,
})

-- Navegación entre TODOs
vim.keymap.set("n", "]t", function() todo.jump_next() end, { desc = "Siguiente TODO" })
vim.keymap.set("n", "[t", function() todo.jump_prev() end, { desc = "TODO anterior" })

-- Listar TODOs con Telescope (si está disponible) y en Trouble
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Buscar TODOs (Telescope)" })
vim.keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<CR>", { desc = "TODOs en Trouble" })
