-- Blindado con pcall: si telescope falla al cargar/configurar (p. ej. por una versión
-- incompatible), NO debe cortar la carga de los demás archivos de after/plugin
-- (which-key, gitsigns, etc., que se cargan alfabéticamente después que este).
local ok_t, telescope = pcall(require, 'telescope')
local ok_b, builtin = pcall(require, 'telescope.builtin')
if not (ok_t and ok_b) then
    vim.notify("telescope no se pudo cargar", vim.log.levels.WARN)
    return
end

-- Configurar Telescope
telescope.setup({
    defaults = {
        -- Configuración del previewer para evitar errores
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    },
    extensions = {
        -- fzf nativo: filtrado más rápido y con sintaxis fzf (^ para prefijo,
        -- $ para sufijo, 'exacto, !negar, etc.)
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
})

-- Cargar la extensión fzf (si está compilada). pcall para no romper si aún no
-- se ha corrido `make` en telescope-fzf-native.
pcall(telescope.load_extension, 'fzf')

-- Pickers
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope: buscar archivos' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope: archivos de git' })

-- live_grep: busca TEXTO en todo el proyecto en tiempo real (necesita ripgrep/rg).
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope: grep en proyecto' })

-- buffers abiertos, ayuda, y palabra bajo el cursor / prompt manual
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope: buscar buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope: buscar ayuda' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Telescope: grep palabra bajo cursor' })

-- Grep con prompt manual (lo que ya tenías)
vim.keymap.set('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = 'Telescope: grep con prompt' })
