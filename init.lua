-- Silenciar advertencias de deprecación
local original_notify = vim.notify
vim.notify = function(msg, log_level, opts)
    if msg and msg:find("deprecated") then
        return
    end
    original_notify(msg, log_level, opts)
end
-- Silenciar advertencias de deprecación
-- vim.notify = function(msg, log_level, opts)
--     if msg and msg:find("deprecated") then
--         return
--     end
--     print(msg)  -- Solo imprimir en lugar de notificar
-- end
require("default") -- la carpeta default
