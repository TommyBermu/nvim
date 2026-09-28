# Registro de mejoras de la configuración de Neovim

Documento de seguimiento: qué se ha hecho, qué falta y qué más se podría mejorar.

Última actualización: 2026-09-28

---

## ✅ Hecho

- [x] **Reemplazar `nvim-colorizer` sin mantenimiento.** Se cambió `norcalli/nvim-colorizer.lua`
  por el fork mantenido `catgoose/nvim-colorizer.lua` en `lua/default/lazy.lua`.
  Motivo: el original usaba `vim.tbl_flatten` (deprecado en Nvim 0.11, se elimina en 0.13)
  y lanzaba un warning al arrancar.
  - Pendiente de tu lado: correr `:Lazy sync` y reiniciar para aplicarlo.

- [x] **1. Doble formateo al guardar (resuelto).** Se eliminó el autocmd `BufWritePre`
  de `after/plugin/lsp.lua`. Ahora conform.nvim es el único responsable del formateo al
  guardar (`format_on_save` con `lsp_format = "fallback"`, que usa el LSP en los filetypes
  sin formatter propio en conform). Se dejó un comentario explicativo en `lsp.lua`.

- [x] **2. Keymap de formateo `<space>f` unificado (resuelto).** Se dejó una sola
  definición global en `after/plugin/conform.lua` (normal + visual). Se quitaron las
  duplicadas de `lsp.lua` (dentro de `on_attach`) y de `remap.lua` (`<Leader>f`).
  En `rust.lua` el atajo por-buffer se reapuntó a conform con fallback al LSP, para
  comportamiento consistente en archivos Rust.

- [x] **3. Navegación de buffers arreglada (resuelto).** En `remap.lua` se cambió
  `<C-Tab>` (que las terminales no distinguen de `<Tab>`) por `<S-Tab>` para "buffer
  anterior". Se añadió `silent = true` y `desc` a los mapeos de buffer (`<Tab>`,
  `<S-Tab>`, `<Leader>e`).

- [x] **14. Doble instancia de clangd eliminada (resuelto).** `after/plugin/clangd.lua`
  se reescribió para la API moderna de `clangd_extensions.nvim` (Nvim 0.10+): se quitó
  el bloque `server = {...}` (era el que arrancaba una 2ª instancia de clangd) y la clave
  `extensions` (API vieja). Ahora clangd se arranca SOLO desde `lsp.lua`
  (`vim.lsp.config` + `vim.lsp.enable`), y el plugin solo aporta los extras (AST, memory
  usage, etc.). Los inlay hints pasaron a la API nativa `vim.lsp.inlay_hint`, activados
  por buffer vía un autocmd `LspAttach` cuando el cliente es clangd.
  - Verificar de tu lado: abrir un archivo C/C++ y correr `:LspInfo` / `:checkhealth lsp`
    para confirmar que hay un solo cliente clangd adjunto.

---

## 🔧 Por arreglar (conflictos o bugs reales)

_No quedan puntos pendientes en esta sección. (1, 2, 3 y 14 resueltos — ver "Hecho".)_

---

## ✨ Quality of life — opciones (sin plugins nuevos)

Todo esto va en `lua/default/set.lua`. Cambios pequeños, alto impacto.

- [ ] **5. Búsqueda más amigable**
  ```lua
  vim.opt.ignorecase = true
  vim.opt.smartcase = true   -- ignora mayúsculas salvo que escribas alguna
  vim.opt.incsearch = true
  vim.opt.hlsearch = true
  ```
  Más un atajo para limpiar el resaltado, p. ej. `<leader>h` → `:nohlsearch<CR>`.

- [ ] **6. Undo persistente** (ya tienes undotree instalado)
  ```lua
  vim.opt.undofile = true
  ```

- [ ] **7. Columna de signos estable** (evita que el texto "salte")
  ```lua
  vim.opt.signcolumn = "yes"
  ```

- [ ] **8. Ventanas y tiempos más cómodos**
  ```lua
  vim.opt.splitright = true
  vim.opt.splitbelow = true
  vim.opt.updatetime = 250
  vim.opt.timeoutlen = 300
  ```

- [ ] **15. Quitar redundancia:** `vim.opt.compatible = false` no hace nada en Neovim
  (nocompatible siempre está activo). Se puede borrar.

---

## 🔌 Quality of life — plugins nuevos recomendados

- [ ] **9. Telescope: live_grep + fzf-native + más pickers.**
  Falta buscar texto en todo el proyecto (`live_grep`), que es de lo más usado.
  ```lua
  vim.keymap.set('n', '<leader>fg', builtin.live_grep,  { desc = 'Grep en proyecto' })
  vim.keymap.set('n', '<leader>fb', builtin.buffers,    { desc = 'Buscar buffers' })
  vim.keymap.set('n', '<leader>fh', builtin.help_tags,  { desc = 'Buscar ayuda' })
  ```
  Añadir `nvim-telescope/telescope-fzf-native.nvim` (build con make) acelera mucho el filtrado.

- [ ] **10. which-key.nvim** *(el mayor salto de comodidad)*.
  Al presionar `<leader>` y esperar, muestra un menú con los atajos disponibles.
  Muy útil dada la cantidad de leader-mappings que tienes.

- [ ] **11. Explorador de archivos moderno.** Hoy usas netrw (`<leader>pv` → `:Ex`).
  Alternativas más cómodas: `oil.nvim` (editas el filesystem como un buffer, minimalista)
  o `nvim-tree`/`neo-tree` (árbol lateral clásico).

- [ ] **12. gitsigns.nvim.** Muestra en la columna izquierda las líneas
  añadidas/cambiadas/borradas, permite navegar entre hunks y hacer stage.
  Complementa muy bien a fugitive.

- [ ] **13. easymotion → flash.nvim (o leap.nvim).** easymotion es vimscript antiguo;
  flash.nvim es el equivalente moderno en Lua, más rápido e integrado con Treesitter.
  (Opcional, solo si quieres modernizar.)

---

## 💡 Ideas extra para más adelante

Ninguna es urgente; son mejoras que suelen valer la pena en configs de uso diario.

- [ ] **Autocomando "yank highlight":** resaltar brevemente el texto copiado.
  ```lua
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank() end,
  })
  ```

- [ ] **Restaurar posición del cursor** al reabrir un archivo (autocmd sobre `BufReadPost`).

- [ ] **`mini.nvim` o `Comment.nvim`** para comentar/descomentar con `gcc` / `gc` en visual.
  (Neovim reciente ya trae comentado nativo con `gc`; vale la pena confirmar tu versión
  antes de instalar nada.)

- [ ] **`indent-blankline.nvim`** para guías visuales de indentación.

- [ ] **`todo-comments.nvim`** para resaltar y navegar `TODO:`, `FIXME:`, etc.

- [ ] **`nvim-cmp`: iconos/formato con `lspkind.nvim`** para que el menú de autocompletado
  muestre iconos por tipo de símbolo.

- [ ] **Diagnósticos: `virtual_text` puede saturar** en líneas largas. Considera
  `virtual_text = { spacing = 2, prefix = "●" }` o moverlos a un float con
  `vim.diagnostic.open_float` en un atajo, y activar `severity_sort = true`.

- [ ] **`autoformat` togglable:** un comando/atajo para activar o desactivar el formateo
  al guardar cuando trabajes en un repo ajeno con otro estilo.

- [ ] **Migrar `after/plugin/*.lua` a specs de lazy** (config dentro de cada plugin en
  `lazy.lua` con `opts`/`config`). Mejora el lazy-loading y el arranque. Es refactor grande,
  solo si te interesa optimizar tiempos de inicio.

- [ ] **`vim.opt.colorcolumn = "80"`** (o el límite que uses) para ver el ancho de línea.

- [ ] **`vim.opt.cursorline = true`** para resaltar la línea actual.

---

## Notas

- La config sigue un estilo modular tipo ThePrimeagen (`lua/default/` + `after/plugin/`),
  lo cual está bien y es fácil de mantener.
- Prioridad sugerida de ataque: arreglos **1–3** → opciones QoL **5–8** →
  **which-key (10)** y **live_grep (9)**.
