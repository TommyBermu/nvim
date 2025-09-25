-- Silenciar advertencias de deprecación
vim.notify = function(msg, log_level, opts)
    if msg and msg:find("deprecated") then
        return
    end
    return require("vim.notify")(msg, log_level, opts)
end

require("default") -- la carpeta default
