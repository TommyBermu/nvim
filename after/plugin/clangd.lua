-- clangd_extensions.nvim (versión moderna, Nvim 0.10+)
--
-- IMPORTANTE: clangd se configura y se arranca UNA sola vez desde
-- after/plugin/lsp.lua mediante vim.lsp.config('clangd', ...) + vim.lsp.enable('clangd').
-- La versión moderna de este plugin YA NO arranca el servidor: solo añade las
-- funciones extra (AST, memory usage, symbol info, type hierarchy, switch source/header).
-- Por eso aquí NO usamos la clave `server` ni `extensions` (API vieja), que causaban
-- una posible segunda instancia de clangd.
--
-- Este setup() es opcional; solo personaliza los iconos del visor de AST.
local ok, clangd_ext = pcall(require, "clangd_extensions")
if not ok then
    return
end

clangd_ext.setup({
    ast = {
        role_icons = {
            type = "",
            declaration = "",
            expression = "",
            specifier = "",
            statement = "",
            ["template argument"] = "",
        },
        kind_icons = {
            Compound = "",
            Recovery = "",
            TranslationUnit = "",
            PackExpansion = "",
            TemplateTypeParm = "",
            TemplateTemplateParm = "",
            TemplateParamObject = "",
        },
        highlights = {
            detail = "Comment",
        },
    },
    memory_usage = {
        border = "none",
    },
    symbol_info = {
        border = "none",
    },
})

-- Los inlay hints ahora son nativos en Neovim. Se activan por buffer con:
--   vim.lsp.inlay_hint.enable(true, { bufnr = ... })
-- Los activamos cuando clangd se adjunta a un buffer C/C++.
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "clangd" then
            if vim.lsp.inlay_hint then
                pcall(vim.lsp.inlay_hint.enable, true, { bufnr = args.buf })
            end
        end
    end,
})
