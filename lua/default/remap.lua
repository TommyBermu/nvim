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

-- para navegar entre buffers
vim.keymap.set("n", "<Tab>", ":bn<CR>", { noremap = true}) 
vim.keymap.set("n", "<C-Tab>", ":bp<CR>", { noremap = true}) 
vim.keymap.set("n", "<Leader>e", ":bd<CR>", { noremap = true}) 

-- Formatear con LSP
vim.keymap.set("n", "<Leader>f", function() 
    vim.lsp.buf.format({ async = true }) 
end, { noremap = true, desc = "Format code" })

-- Formatear en modo visual (solo la selección)
vim.keymap.set("v", "<Leader>f", function() 
    vim.lsp.buf.format({ async = true }) 
end, { noremap = true, desc = "Format selection" })
