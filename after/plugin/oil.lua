-- oil.nvim: navega y edita el sistema de archivos como si fuera un buffer.
-- Crear/renombrar/mover/borrar archivos = editar líneas y guardar con :w
local ok, oil = pcall(require, "oil")
if not ok then
    return
end

oil.setup({
    default_file_explorer = true, -- reemplaza a netrw
    view_options = {
        show_hidden = true,       -- muestra archivos ocultos (dotfiles)
    },
    keymaps = {
        ["q"] = "actions.close",
    },
})

-- <leader>pv : abre oil en el directorio del archivo actual (reemplaza a :Ex)
vim.keymap.set("n", "<leader>pv", "<cmd>Oil<CR>", { desc = "Explorador de archivos (oil)" })
-- NOTA: NO mapeamos `-` globalmente para abrir Oil, porque dentro del buffer de oil
-- `-` ya significa "subir al directorio padre" (mapeo propio de oil) y chocaba.
-- Si quieres abrir oil con `-` desde un archivo normal, descomenta la línea de abajo;
-- oil sobreescribe `-` con su propia acción cuando estás dentro de él.
-- vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Abrir directorio padre (oil)" })

-- NOTA: el popup de which-key dentro del buffer de oil se desactiva desde
-- after/plugin/which-key.lua con la opción `disable.ft = { "oil" }` (API v3).
