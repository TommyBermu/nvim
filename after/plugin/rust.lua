vim.g.rustaceanvim = {
    server = {
        on_attach = function(_, bufnr)
            local bufopts = { noremap = true, silent = true, buffer = bufnr }

            -- Keymaps LSP estándar
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

            -- Hover actions específicos de Rust
            vim.keymap.set("n", "<C-space>", function()
                vim.cmd.RustLsp { 'hover', 'actions' }
            end, bufopts)

            -- Code action groups
            vim.keymap.set("n", "<Leader>a", function()
                vim.cmd.RustLsp('codeAction')
            end, bufopts)
        end,
    },
}
