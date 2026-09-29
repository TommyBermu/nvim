-- nvim-colorizer (fork de catgoose): resalta los códigos de color (hex, nombres CSS,
-- rgb(), etc.) con su color real en el propio texto.
local ok, colorizer = pcall(require, "colorizer")
if not ok then
    return
end

colorizer.setup()
