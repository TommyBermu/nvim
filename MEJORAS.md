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

- [x] **5. Búsqueda más amigable (hecho).** En `set.lua`: `ignorecase`, `smartcase`,
  `incsearch`, `hlsearch`. Atajo `<leader>h` → `:nohlsearch<CR>` añadido en `remap.lua`
  para limpiar el resaltado.

- [x] **6. Undo persistente (hecho).** `vim.opt.undofile = true` en `set.lua`
  (el historial de deshacer sobrevive al cerrar el archivo; complementa undotree).

- [x] **7. Columna de signos estable (hecho).** `vim.opt.signcolumn = "yes"` en `set.lua`.

- [x] **8. Ventanas y tiempos (hecho).** `splitright`, `splitbelow`, `updatetime = 250`,
  `timeoutlen = 300` en `set.lua`.

- [x] **15. Redundancia eliminada (hecho).** Se quitó `vim.opt.compatible = false` de
  `set.lua` (no tiene efecto en Neovim).

- [x] **10. which-key.nvim (hecho).** Añadido `folke/which-key.nvim` a `lazy.lua` y
  configurado en `after/plugin/which-key.lua` con `setup()` + `add()` de etiquetas de
  grupo para los prefijos de leader (`<leader>f/x/h/g/t/n/p`). El retardo del popup lo
  controla `timeoutlen = 300` (ya puesto en set.lua).

- [x] **11. Explorador de archivos moderno (hecho).** Añadido `stevearc/oil.nvim`
  (+ web-devicons) a `lazy.lua`, configurado en `after/plugin/oil.lua`
  (`default_file_explorer`, muestra ocultos, `q` para cerrar). Atajos: `<leader>pv` abre
  oil en el directorio del archivo, `-` sube al directorio padre. Reemplaza a netrw.

- [x] **12. gitsigns.nvim (hecho).** Añadido `lewis6991/gitsigns.nvim` a `lazy.lua`,
  configurado en `after/plugin/gitsigns.lua`. Navegación de hunks (`]c`/`[c`) y acciones
  bajo `<leader>h*` (stage/reset/preview/blame/diff) + toggle blame `<leader>tb`.

- [x] **13. easymotion → flash.nvim (hecho).** Se quitó `easymotion/vim-easymotion` de
  `lazy.lua` y se añadió `folke/flash.nvim`, configurado en `after/plugin/flash.lua`
  (`s` = salto, `S` = Treesitter, `r` = remote en operator-pending). Se eliminó el mapeo
  viejo `<Leader>s` de easymotion en `remap.lua`.

- Nota de conflicto resuelto: el atajo de "limpiar resaltado" se movió de `<leader>h`
  a `<leader>nh` porque `<leader>h*` quedó reservado para los hunks de gitsigns.

- [x] **Fix (RESUELTO): error de telescope `ft_to_lang` — causa raíz: nvim-treesitter en
  rama `main`.** El diagnóstico inicial (culpar al tag de telescope) era incorrecto. La
  causa real: nvim-treesitter estaba en la rama `main` (reescritura nueva) que ELIMINÓ el
  módulo `nvim-treesitter.configs` y la función `ft_to_lang`. Telescope 0.1.x llama a
  `require('nvim-treesitter.parsers').ft_to_lang(ft)` en su previewer, y al no existir,
  fallaba en cada tecla. Además, `treesitter.lua` usa la API vieja (`configs.setup`) que
  tampoco existe en `main`.
  - Fix: se fijó `branch = 'master'` para nvim-treesitter en `lazy.lua` y se cambió de rama
    en disco (`git fetch/checkout master` + `:TSUpdate`). Telescope quedó en `branch='0.1.x'`.
  - Confirmado por el usuario: el error rojo ya no aparece.

- [x] **Fix: which-key no cargaba (parte 1) — MISMO origen que treesitter.** El error de
  treesitter `main` al arrancar cortaba la carga de `after/plugin/` y `which-key.lua`
  (último por orden alfabético) nunca se registraba. Al arreglar treesitter, which-key
  vuelve a cargar. `:checkhealth which-key` pasa (solo warnings informativos).

- [x] **Fix: which-key no abría el popup con `<leader>` (parte 2) — `<Space>` mapeado a
  `<Nop>`.** Yo había añadido `vim.keymap.set({"n","v"}, "<Space>", "<Nop>")` para evitar
  el movimiento del cursor, pero eso hace que which-key vea `<Space>` como un mapeo
  TERMINAL en vez de un prefijo, y no dispara el popup. Se eliminó ese mapeo. Con
  `mapleader = " "` los mapeos `<leader>...` capturan el espacio sin necesidad del <Nop>.
  - Recordatorio: el popup está desactivado a propósito dentro de oil (`disable.ft`),
    así que hay que probarlo en un archivo normal, no en el explorador oil.

- [x] **Aclaración de uso (no es un bug): which-key se usa PULSANDO el leader, no
  MANTENIÉNDOLO.** Si se mantiene la tecla espacio físicamente apretada, el auto-repeat
  del teclado envía una ráfaga de espacios y which-key los procesa como teclas (por eso
  "escribe espacios"). Uso correcto: tocar `<leader>` una vez y soltar → el popup aparece
  y se queda; luego pulsar la letra del grupo (`f`, `h`, ...). Confirmado funcionando.

- [x] **Fix: which-key aparecía solo un frame y luego se movía el cursor.** Dos causas:
  (1) en which-key v3 el retardo lo controla la opción `delay` del plugin, NO `timeoutlen`
  — se puso `delay = 150` y `preset = "modern"` en `which-key.lua`; (2) `<Space>` por sí
  solo mueve el cursor en normal/visual, así que se mapeó a `<Nop>` en `remap.lua`.

- Recordatorio: `vim-easymotion` sigue en disco; se elimina al correr `:Lazy sync`
  (ya fue quitado de `lazy.lua`).

- [x] **9. Telescope: live_grep + fzf-native + más pickers (hecho).** Se añadió
  `telescope-fzf-native.nvim` (con `build = 'make'`) como dependencia de telescope en
  `lazy.lua`, y en `after/plugin/telescope.lua` se configuró la extensión `fzf`
  (`load_extension` con pcall) y nuevos mapeos:
  - `<leader>fg` → `live_grep` (buscar texto en todo el proyecto; usa ripgrep)
  - `<leader>fb` → `buffers`
  - `<leader>fh` → `help_tags`
  - `<leader>fw` → `grep_string` (palabra bajo el cursor)
  - `<leader>fs` → grep con prompt manual (lo que ya existía)
  - `<leader>ff` (find_files) y `<C-p>` (git_files) se conservan.
  Requisitos: ripgrep (verificado: `rg 15.2.0` en /usr/bin) y `make`+compilador C para
  compilar fzf-native. Requiere `:Lazy sync` para instalar/compilar.

- [x] **Fix: popup de which-key apareciendo dentro del explorador oil.** Lo que se veía
  como "+Changes/+Visual" era en realidad el popup de which-key listando los keymaps del
  BUFFER de oil (oil + flash), no un problema de `c`/`v` en archivos normales. Solución
  (API v3 correcta): `disable = { ft = { "oil" } }` en `which-key.lua`. Se descartó el
  intento previo con `plugins.presets.operators/motions` porque en which-key v3 esas
  opciones están DEPRECADAS (ver `opts.defer`) y no tenían efecto. No requiere `:Lazy sync`.
  - Además: se quitó el mapeo global de `-` → Oil en `oil.lua`, porque dentro de oil `-`
    ya significa "subir de directorio" y colisionaba. `<leader>pv` sigue abriendo oil.

---

## 🔧 Por arreglar (conflictos o bugs reales)

_No quedan puntos pendientes en esta sección. (1, 2, 3 y 14 resueltos — ver "Hecho".)_

---

## ✨ Quality of life — opciones (sin plugins nuevos)

_Todos los puntos de esta sección están resueltos (5, 6, 7, 8 y 15 — ver "Hecho")._

---

## 🔌 Quality of life — plugins nuevos recomendados

_9, 10, 11, 12 y 13 resueltos — ver "Hecho"._

---

## 🧹 Auditoría / limpieza (archivo por archivo)

Correcciones seguras aplicadas:
- [x] Comentario de telescope en `lazy.lua` corregido (la causa de `ft_to_lang` era
  treesitter `main`, no telescope).
- [x] `nvim-web-devicons` ya no se declara suelto en `lazy.lua` (viene como dependencia
  de trouble y oil; lazy lo deduplica).
- [x] `enabled = true` redundante quitado de la entrada de nvim-colorizer.

Decisiones del usuario (aplicadas):
- [x] **`colors.lua` consolidado como ÚNICO lugar del colorscheme.**
  Se quitó `colorscheme gruvbox` de `default/init.lua`. `colors.lua` aplica gruvbox.
  Decisión del usuario: fondo SÓLIDO (se probó transparente pero se veía mal en airline,
  así que se quitó la transparencia).
- [x] **`colorizer.setup()` movido a su propio `after/plugin/colorizer.lua`** (antes estaba
  suelto en `default/init.lua`).
- [x] **Tema de airline unificado a `gruvbox`** (antes onedark). Reversible cambiando una
  línea en `airline.lua` si no gusta.
- [x] **`vim-be-good` y `vim-tmux-navigator` se MANTIENEN** (el usuario los usa).

Detalles técnicos de diagnósticos (aplicados):
- [x] **`virtual_text` con formato** en `lsp.lua`: `{ spacing = 2, prefix = "●" }` para que
  en líneas largas el mensaje no se pegue al código.
- [x] **`severity_sort = true`** en `lsp.lua`: en una línea con varios diagnósticos, muestra
  primero los errores, luego warnings/hints/info.

Revisado y OK (no requiere cambios):
- Duplicación de keymaps LSP en `rust.lua`: es necesaria (rustaceanvim usa su propio
  `on_attach`, separado del de `lsp.lua`).
- `<C-space>` (rust hover) vs `<C-Space>` (cmp complete): conviven porque actúan en
  modos distintos (normal vs insert).
- Todos los archivos de `after/plugin/` nuevos tienen `pcall` de protección.

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
