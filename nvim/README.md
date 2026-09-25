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

## File navigation

Neo-tree is intentionally not enabled. Use LazyVim's search/picker workflow inside Neovim and Yazi from the terminal; Yazi configuration is maintained separately under `../yazi/`.
