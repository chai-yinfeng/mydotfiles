# Neovim

This directory contains the repository-managed LazyVim configuration and is linked to `~/.config/nvim`. It uses the official LazyVim starter structure with local changes under `lua/config/` and `lua/plugins/`.

LazyVim requires Neovim 0.11.2 or newer. Track `lazy-lock.json` so plugin revisions remain reproducible; review and commit lockfile changes after `:Lazy sync`.

## Language support

- C/C++: `clangd` with background indexing and clang-tidy diagnostics.
- Python: Pyright and Ruff.
- Rust: rust-analyzer with Clippy checks through rustaceanvim.
- Go: gopls with gofumpt formatting and staticcheck analysis.
- Lua: `lua_ls` and Stylua from LazyVim's core configuration.

Language extras are declared in `lazyvim.json`; LazyVim/Mason installs the configured LSP servers and selected formatters, including `clang-format`. Rust's `rust-analyzer`, `rustfmt`, and `clippy` come from the Rust toolchain.

## Formatting

Conform is configured for:

- Lua: `stylua`
- Python: `isort`, then `black`
- Go: `goimports`, then `gofumpt`
- Rust: `rustfmt`
- C/C++: `clang-format` on demand

C/C++ format-on-save remains disabled. Use `<leader>cf` to format a C/C++ buffer manually.

## Markdown rendering

Markdown files render inside the terminal with `render-markdown.nvim`. Use
`<leader>um` (Space, then `u`, then `m`) or `:RenderMarkdown toggle` to toggle
rendering. Insert mode and the cursor line show the source for editing.
Treesitter's `markdown` and `markdown_inline` parsers come from LazyVim's core
configuration. No browser is required.

## Code locations from Codex

From a Zsh shell in the project directory, use `nv 'path/to/file.py:1626'` to
open a file at the given line, or `nv 'path/to/file.py:1626:8'` for a column.
Reload `~/.zshrc` after updating the shell configuration.

Inside Neovim, use `:CodeLocation path/to/file.py:1626` or `<leader>fL`
(Space, then `f`, then uppercase `L`) and paste the reference into the prompt.
Backtick-wrapped references, Markdown links to local files, `path#L1626`, and
line ranges such as `path:1626-1630` are supported; ranges jump to their start.
Relative paths resolve against Neovim's current directory (`:pwd`); absolute
paths work from anywhere. Web URLs require opening the repository locally first.

## Treesitter installation

Mason manages `tree-sitter-cli` and loads before Treesitter so an outdated system
CLI cannot take precedence. A C compiler, `curl`, and `tar` are also required.
The first launch installs missing parsers; allow installation to finish.
For parser errors, run `:checkhealth nvim-treesitter` and inspect `:TSLog`.
After updating the plugin, use `:TSUpdate` to rebuild compatible parsers.

## File navigation

Neo-tree is intentionally not enabled. Use `<leader>e` (Space, then `e` by default) to run Yazi at the LazyVim project root in a Snacks floating terminal; the terminal closes when Yazi exits and returns to Neovim. From Zsh, `y` uses the shell wrapper. Yazi configuration lives under `../yazi/`.
