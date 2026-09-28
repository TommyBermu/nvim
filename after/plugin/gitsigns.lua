-- gitsigns.nvim: marca en la columna de signos las líneas añadidas/cambiadas/borradas,
-- y permite navegar/previsualizar/hacer stage de hunks. Complementa a fugitive.
local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
    return
end

gitsigns.setup({
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Navegación entre hunks
        map("n", "]c", function() gs.nav_hunk("next") end, "Siguiente hunk de git")
        map("n", "[c", function() gs.nav_hunk("prev") end, "Hunk de git anterior")

        -- Acciones sobre hunks
        map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>hp", gs.preview_hunk, "Previsualizar hunk")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame de la linea")
        map("n", "<leader>hd", gs.diffthis, "Diff contra el index")

        -- Toggles
        map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle blame en linea")
    end,
})
