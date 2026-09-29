-- ÚNICO lugar donde se aplica el colorscheme.
-- (Antes también se aplicaba en default/init.lua; se consolidó aquí.)

local function apply_colors(color)
    color = color or "gruvbox"
    vim.cmd.colorscheme(color)
    -- Fondo sólido de gruvbox (sin transparencia): se veía mal en airline.
end

apply_colors()

-- Se mantiene el nombre ColorMyPencils como alias por si lo llamas a mano o en mapeos.
ColorMyPencils = apply_colors
