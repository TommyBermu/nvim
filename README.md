# Mi config de Neovim (Arch Linux)

Config personal de Neovim en Lua, con enfoque en productividad y desarrollo.

- Gestor de plugins: lazy.nvim
- Busqueda: Telescope + ripgrep
- Codigo: LSP + Treesitter
- Extras: undotree, fugitive, trouble, vim-tmux-navigator

Tambien tengo mi config de tmux: https://github.com/TommyBermu/tmux

## Requisitos

Instala lo basico en Arch:

```bash
sudo pacman -Syu neovim git ripgrep
```

Opcional (segun lo que uses):

```bash
sudo pacman -S nodejs npm python clang
```

## Instalacion rapida

1. Backup de config actual (opcional):

```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

2. Clonar repo:

```bash
git clone https://github.com/TommyBermu/nvim.git ~/.config/nvim
```

3. Abrir Neovim:

```bash
nvim
```

La primera vez se instala lazy.nvim automaticamente y luego los plugins.

## Comandos utiles

- Sincronizar plugins: `:Lazy sync`
- Actualizar plugins: `:Lazy update`
- Ver mensajes de error: `:messages`

## Estructura

- `init.lua`: entrada principal
- `lua/default/`: opciones, remaps, plugins
- `after/plugin/`: configuraciones por plugin

## Problemas comunes

- Telescope no busca: instala `ripgrep` (`rg`).
- Si no carga algun plugin: ejecuta `:Lazy sync`.
- Si sigue fallando: abre con `nvim --clean` para descartar conflictos.
