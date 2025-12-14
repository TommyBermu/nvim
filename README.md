Mi configuración personal de Neovim ✨
Incluye:

🎨 Temas y colores que me gustan
🔧 Plugins para productividad
⌨️ Atajos que hacen mi vida más fácil
📚 Ajustes para programar a gusto

Revisa también mi [configuración de Tmux](https://github.com/TommyBermu/tmux).

## Resumen
- Lenguaje: Lua
- Gestor de plugins: lazy.nvim
- Uso pensado para desarrollo general y edición cómoda con Telescope, LSP, Treesitter, etc.

---

## Requisitos
- Neovim >= 0.9 (recomendado)
- git
- ripgrep (rg) — requerido para que Telescope busque archivos y contenido correctamente
- Opcional pero recomendado: Node.js, Python 3 (para providers y algunos LSPs), clangd / pylsp u otros servidores de lenguaje según tu stack

Instalación rápida de ripgrep (ejemplos):
- Debian / Ubuntu: sudo apt install ripgrep
- Arch: sudo pacman -S ripgrep
- macOS: brew install ripgrep
- Windows (scoop/choco): scoop install ripgrep  — o — choco install ripgrep

---

## Instalación (rápida)
1. Haz backup de tu configuración actual (si aplica):
   mv ~/.config/nvim ~/.config/nvim.backup

2. Clona este repositorio en la ruta de configuración de Neovim:
   git clone https://github.com/TommyBermu/nvim.git ~/.config/nvim

3. Arranca Neovim:
   nvim

   lazy.nvim se encargará de instalar los plugins la primera vez (si no está instalado, el bootstrap del init.lua clona lazy automáticamente). Si quieres forzar la instalación/actualización, dentro de Neovim ejecuta:
   :Lazy sync
   o
   :Lazy update

Si prefieres revisar/instalar lazy.nvim manualmente, aquí tienes el snippet de bootstrap recomendado (este u otro similar ya debería estar en el repo — solo para referencia):

```lua
-- Bootstrap lazy.nvim (ejemplo)
local fn = vim.fn
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
```

---

## Estructura y dónde mirar
- La configuración principal está en el directorio `lua/` (aquí están las configuraciones y la lista de plugins).
- `init.lua` arranca la configuración y hace el bootstrap de lazy.nvim.
- Revisa `lua/` para ver archivos de configuración específicos (plugins, keymaps, opciones, etc.).

---

## Uso y mantenimiento
- Instalar / sincronizar plugins: dentro de Neovim -> `:Lazy sync`
- Actualizar plugins: dentro de Neovim -> `:Lazy update`
- Abrir Neovim después de clonar: los plugins se instalarán automáticamente al ejecutar `:Lazy sync` si hace falta.

---

## Problemas comunes
- Telescope no encuentra contenido o no busca archivos: asegúrate de tener ripgrep (`rg`) instalado.
- Si lazy.nvim no se instala automáticamente al abrir Neovim, revisa que tengas conexión y permisos para clonar en `stdpath("data") .. "/lazy/lazy.nvim"`. Puedes clonar manualmente con el comando git del snippet anterior.
- Si algo falla en la configuración (errores en inicio), abre Neovim con `nvim --clean` para descartar interferencias externas y revisa `:messages` para detalles.

---

## Personalizar
- Para cambiar plugins o atajos, edita los archivos dentro de `lua/` (la estructura está dividida para facilitar modificaciones).
- Si quieres añadir servidores LSP, herramientas o formatores, puedes usar tus propios comandos o integrar `mason.nvim` / `mason-lspconfig` según prefieras.
