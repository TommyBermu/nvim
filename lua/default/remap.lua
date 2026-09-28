vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Atajo para easymotion
vim.api.nvim_set_keymap("n", "<Leader>s", "<Plug>(easymotion-s2)", {})

-- Atajos para guardar y salir
vim.keymap.set("n", "<Leader>w", ":w<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>q", ":q<CR>", { noremap = true })

-- Otros atajos
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- edita todas los textos que sean como en el que esta
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- limpiar el resaltado de la última búsqueda
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { noremap = true, silent = true, desc = "Limpiar resaltado" })

-- para navegar entre buffers
-- <Tab> = siguiente, <S-Tab> = anterior (la mayoría de terminales no distinguen
-- <C-Tab> de <Tab>, por eso se usa <S-Tab> para "buffer anterior").
vim.keymap.set("n", "<Tab>", ":bn<CR>", { noremap = true, silent = true, desc = "Buffer siguiente" })
vim.keymap.set("n", "<S-Tab>", ":bp<CR>", { noremap = true, silent = true, desc = "Buffer anterior" })
vim.keymap.set("n", "<Leader>e", ":bd<CR>", { noremap = true, silent = true, desc = "Cerrar buffer" })

-- NOTA: el atajo de formateo (<Leader>f == <space>f) se define de forma centralizada
-- en after/plugin/conform.lua para normal y visual. No lo dupliques aquí.
