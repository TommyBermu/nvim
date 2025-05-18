-- Habilitar la línea de pestañas (bufferline) en vim-airline
vim.g["airline#extensions#tabline#enabled"] = 2

vim.g["airline#extensions#tabline#left_sep"] = ''
vim.g["airline#extensions#tabline#left_alt_sep"] = ''
vim.g["airline#extensions#tabline#right_sep"] = ''
vim.g["airline#extensions#tabline#right_alt_sep"] = ''

-- Mostrar solo el nombre del archivo (parte final del path)
vim.g["airline#extensions#tabline#formatter"] = "unique_tail"

-- Tema de airline
vim.g.airline_theme = "onedark"

-- Usar fuentes powerline (para mostrar los triangulitos y separadores)
vim.g.airline_powerline_fonts = 1

vim.g["airline_left_sep"] = ''
vim.g["airline_left_alt_sep"] = ''
vim.g["airline_right_sep"] = ''
vim.g["airline_right_alt_sep"] = ''
