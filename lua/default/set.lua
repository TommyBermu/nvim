-- CONFIGURACIONES BÁSICAS
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.scrolloff = 8
vim.cmd("syntax enable")
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.list = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "h", "hpp" },
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.expandtab = true
    end,
})

-- BÚSQUEDA (más amigable)
vim.opt.ignorecase = true -- ignora mayúsculas/minúsculas al buscar...
vim.opt.smartcase = true  -- ...salvo que escribas alguna mayúscula
vim.opt.incsearch = true  -- resalta coincidencias mientras escribes
vim.opt.hlsearch = true   -- mantiene resaltadas las coincidencias

-- UNDO PERSISTENTE (el historial sobrevive al cerrar el archivo; va con undotree)
vim.opt.undofile = true

-- COLUMNA DE SIGNOS ESTABLE (evita que el texto "salte" al aparecer diagnósticos/git)
vim.opt.signcolumn = "yes"

-- VENTANAS Y TIEMPOS
vim.opt.splitright = true -- las divisiones verticales se abren a la derecha
vim.opt.splitbelow = true -- las divisiones horizontales se abren abajo
vim.opt.updatetime = 250  -- diagnósticos y CursorHold más ágiles
vim.opt.timeoutlen = 300  -- espera entre teclas de una secuencia de mapeo
-- NOTA: el retardo del popup de which-key NO depende de timeoutlen, sino de la
-- opción `delay` en after/plugin/which-key.lua.
