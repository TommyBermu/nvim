-- which-key.nvim (v3): al pulsar <leader> (o cualquier prefijo) y esperar `delay` ms,
-- aparece un popup con los atajos disponibles y su descripción.
local ok, wk = pcall(require, "which-key")
if not ok then
    return
end

wk.setup({
    -- OJO: en which-key v3 el retardo del popup lo controla ESTA opción `delay`,
    -- NO `timeoutlen`. Lo bajamos para que el menú aparezca casi al instante al
    -- mantener <leader>.
    delay = 150,
    preset = "modern",

    -- No mostrar el popup de which-key en ciertos filetypes/buftypes.
    -- `oil`: dentro del explorador oil las teclas son acciones (no edición), y el
    -- popup estorbaba al navegar. (API v3: disable.ft / disable.bt)
    disable = {
        ft = { "oil" },
        bt = {},
    },
})

-- Etiquetas de grupo para que el popup muestre categorías legibles.
-- (Los atajos concretos se siguen definiendo en sus archivos respectivos;
--  aquí solo damos nombre a los prefijos.)
wk.add({
    { "<leader>f", group = "find/format (telescope)" },
    { "<leader>x", group = "trouble (diagnósticos)" },
    { "<leader>h", group = "git hunks" },
    { "<leader>g", group = "git (fugitive)" },
    { "<leader>t", group = "toggles" },
    { "<leader>n", group = "no-highlight" },
    { "<leader>p", group = "proyecto/archivos" },
})
