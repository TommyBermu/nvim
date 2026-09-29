-- indent-blankline (ibl): dibuja líneas verticales tenues en cada nivel de indentación
-- para seguir visualmente los bloques anidados.
local ok, ibl = pcall(require, "ibl")
if not ok then
    return
end

ibl.setup({
    indent = {
        char = "│", -- carácter de la guía
    },
    scope = {
        enabled = true, -- resalta el bloque (scope) actual
        show_start = false,
        show_end = false,
    },
})
