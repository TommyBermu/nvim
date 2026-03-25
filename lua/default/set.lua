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
vim.opt.compatible = false
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
