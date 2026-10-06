# dotfiles

Portable user-level configuration for my macOS development environment, with basic compatibility for Arch Linux and Ubuntu arm64.

This repository is the source of truth for reusable shell, editor, terminal, and development workflow configuration.
It is not intended to capture full machine provisioning, hardware drivers, host-specific networking, secrets, or other one-off local state.

---

## Repository scope

### Included in this repository
- `git`
- `zsh`
- `starship`
- `tmux`
- `neovim`
- `yazi`

### Explicitly excluded from this repository
- GPU drivers
- display manager and desktop environment state
- host-specific power management settings
- SSH private keys
- local SSH client configuration on other machines
- machine-specific network addresses, aliases, and credentials
- secrets, tokens, API keys, and private infrastructure details
- caches, histories, generated plugin/runtime data, and package manager state

---

## System baseline

This configuration is used primarily on macOS arm64. Arch Linux and Ubuntu arm64 remain secondary compatibility environments; package names and tool locations differ, and this repository does not provision full machines.

The primary macOS baseline assumes:

- macOS on Apple Silicon
- Homebrew installed
- a normal user account
- GitHub access configured

The secondary Linux environments assume:

- Arch Linux desktop or Ubuntu arm64 under VMware
- the relevant system package manager and a normal user account
- GitHub access configured

Host-specific drivers, desktop state, and networking remain outside the portable user-space layer.

---

## Design principles

- prefer explicit configuration over framework magic
- keep machine-specific settings out of portable dotfiles
- keep shell behavior understandable and maintainable
- avoid storing secrets or private infrastructure details
- treat this repository as both configuration storage and environment documentation
- document required tools even when they are not tracked as files in the repo

---

## Managed configuration layout

Current or intended tracked files:

- `git/.gitconfig`
- `zsh/.zshrc`
- `starship/starship.toml`
- `tmux/.tmux.conf`
- `nvim/`
- `yazi/`

The exact directory layout may evolve, but the boundary remains the same:
portable user configuration belongs here, machine-local operational state does not.

The managed `~/.zshrc` links to `zsh/.zshrc` and optionally sources `~/.zshrc.local`. Link `nvim/` to `~/.config/nvim` and `yazi/` to `~/.config/yazi`; keep host-specific settings outside this repository.

---

## Shell stack

### Current shell architecture
The shell layer is intentionally kept lightweight and explicit.

Current stack:
- `zsh`
- `starship`
- `zoxide`
- `zsh-autosuggestions`
- `zsh-syntax-highlighting`

### Why this setup
This stack was chosen for:
- portability across machines
- low framework coupling
- easier long-term maintenance
- clearer ownership of each layer
- simpler migration into a dotfiles workflow

### Why not Oh My Zsh
Oh My Zsh was tested initially, but the active configuration uses plain `zsh` instead.

Reasons:
- fewer framework-specific assumptions
- easier debugging
- easier migration and repo maintenance
- better transparency around where functionality comes from

The active shell configuration uses Starship and standalone plugins; it does not require Oh My Zsh or Powerlevel10k.

### zsh behavior goals
- minimal and explicit configuration
- readable prompt and command workflow
- command history with duplicate control
- no heavy alias-driven workflow
- plugins used only for clearly scoped functionality
- configuration that remains understandable months later

### Cross-platform shell paths
The `zsh` configuration loads plugin files from the Homebrew prefix on macOS and the common Arch/Ubuntu system locations.

It adds these user-level tool directories to `PATH` only when they exist:

- `$HOME/.local/bin`
- `$HOME/go/bin`
- `$HOME/.cargo/bin`

The optional `~/.zshrc.local` holds host-specific setup such as Homebrew, Conda, NVM, and local proxy functions.

---

## Prompt and shell UX

### Starship
`starship` is used as the prompt layer because it separates prompt styling from shell logic.

Benefits:
- cross-shell portability
- easier prompt migration
- cleaner separation of concerns
- dedicated config file for appearance and prompt behavior

### zoxide
`zoxide` is used as the directory-jumping tool.

Reason:
- portable and modern replacement for older directory-jump tools
- useful enhancement without changing the core command model too much

### Autosuggestions and syntax highlighting
These are provided by:
- `zsh-autosuggestions`
- `zsh-syntax-highlighting`

They improve shell usability without forcing a full shell framework.

---

## tmux

`tmux` is part of the baseline terminal workflow.

Role:
- persistent terminal sessions
- safer remote work over SSH
- easier long-running commands
- split-pane and multi-window workflow

Configuration goals:
- stable remote session handling
- readable window and pane navigation
- lightweight base configuration before adding optional plugins
- compatibility with later Neovim integration

---

## Neovim

The repository's `nvim/` directory contains a LazyVim Starter-based configuration linked to `~/.config/nvim`. Neovim 0.11.2 or newer is required; `nvim/lazy-lock.json` records plugin revisions and should be committed.

Language extras are enabled in `nvim/lazyvim.json`: C/C++ (`clangd`), Go (`gopls`), Python (Pyright and Ruff), and Rust (rust-analyzer with Clippy). Lua support comes from LazyVim core. Mason installs configured language servers and selected formatters; Rust tools remain managed by the Rust toolchain.

Conform formats Lua with Stylua, Python with isort and Black, Go with goimports and gofumpt, and Rust with rustfmt. C/C++ uses clang-format on demand; format-on-save remains disabled for those filetypes.

Markdown files render directly in the terminal with `render-markdown.nvim`, including over SSH. Toggle rendering with `<leader>um` (Space, then `u`, then `m`) or `:RenderMarkdown toggle`; no browser is required. See [Neovim notes](nvim/README.md) for editing behavior.

Neo-tree is intentionally not enabled. Use LazyVim's pickers for search and `<leader>e` (Space, then `e` by default) to open Yazi in a Snacks floating terminal at the project root; it closes and returns to Neovim when Yazi exits.

---

## Yazi

Yazi is the terminal file manager. Its tracked configuration lives in `yazi/` and is linked to `~/.config/yazi`. The repository overrides only `show_hidden = true`; Yazi's built-in defaults provide the remaining settings and keybindings.

The shared Zsh config defines `y` when Yazi is installed. Type `y` to start it; this is a shell command, not a global hotkey or Neovim mapping. Running `yazi` directly also works but does not change the parent shell's directory.

Yazi's default keys are in use: `h/j/k/l` navigate, `.` toggles hidden files, `q` exits and lets the `y` wrapper adopt the current directory, and `Q` exits without changing the shell directory. No custom `keymap.toml` or theme is maintained.

Yazi requires the `file` command for file-type detection. Optional preview features use additional tools such as ffmpeg, 7-Zip, jq, poppler, fd, ripgrep, fzf, zoxide, resvg, or ImageMagick; see the [official installation guide](https://yazi-rs.github.io/docs/installation/) for details.

---

## Package and tool inventory

This section intentionally includes more than the files tracked in the repo.
It documents the tools expected to exist on a fresh system so the configuration in this repository works correctly.

### Core system utilities
- `base-devel`
- `git`
- `curl`
- `wget`
- `file`
- `zip`
- `unzip`
- `man-db`
- `man-pages`

### Shell and terminal tools
- `zsh`
- `starship`
- `tmux`
- `zoxide`
- `zsh-autosuggestions`
- `zsh-syntax-highlighting`

### CLI productivity tools
- `ripgrep`
- `fd`
- `fzf`
- `tree`
- `htop`
- `btop`
- `yazi`

### Editor and editor support
- `neovim`
- `gcc`
- `make`
- `nodejs`
- `npm`
- `python`
- `python-pip`
- `clang`
- `clangd`
- `clang-format`
- `go`
- `rustup`
- `tree-sitter-cli`

### Neovim language tooling

LazyVim/Mason installs the configured language servers and formatters: `lua_ls`, `stylua`, `clangd`, `pyright`, `gopls`, `goimports`, `gofumpt`, `black`, `isort`, and `clang-format`.

The Rust extra expects `rust-analyzer`, `rustfmt`, and `clippy` from the Rust toolchain. C/C++ format-on-save is disabled; `clang-format` is available for manual formatting. Go's staticcheck analysis is enabled through gopls.

### Network and remote access
- `networkmanager`
- `openssh`

### Fonts
- `noto-fonts`
- `noto-fonts-cjk`
- `noto-fonts-emoji`
- `ttf-dejavu`

### Browser
- `firefox`

### Input method stack
- `fcitx5-im`
- `fcitx5-chinese-addons`
- `fcitx5-configtool`

### Machine-local graphics and desktop stack
These are documented for environment reconstruction but are not part of the portable dotfiles layer.

- `nvidia-open`
- `nvidia-utils`
- `nvidia-settings`
- `gnome`
- `gdm`

---

## Example package installation commands

### macOS arm64 shell tools
```bash
brew install starship zoxide zsh-autosuggestions zsh-syntax-highlighting yazi
```

### Arch base user environment
```bash
sudo pacman -Syu
sudo pacman -S base-devel git curl wget file zip unzip man-db man-pages
sudo pacman -S zsh starship tmux zoxide zsh-autosuggestions zsh-syntax-highlighting
sudo pacman -S neovim ripgrep fd fzf tree htop btop yazi
sudo pacman -S nodejs npm python python-pip gcc make clang rustup go tree-sitter-cli
sudo pacman -S networkmanager openssh firefox
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu
```

### Arch Neovim toolchain
```bash
sudo pacman -S clangd clang-format rust-analyzer
rustup component add clippy rustfmt
```

LazyVim/Mason installs the other configured language servers and formatters; see `nvim/README.md`.

### Ubuntu arm64 VM base user environment
```bash
sudo apt update
sudo apt install zsh git curl wget file zip unzip build-essential
sudo apt install tmux zoxide zsh-autosuggestions zsh-syntax-highlighting
sudo apt install neovim ripgrep fd-find fzf tree htop btop
sudo apt install nodejs npm python3 python3-pip python3-venv pipx
sudo apt install clang clangd clang-format clang-tidy golang-go
```

LazyVim requires Neovim 0.11.2 or newer. Check `nvim --version`; if the Ubuntu package is older, use a current Linux arm64 release from the [official downloads](https://github.com/neovim/neovim/releases/latest).

Install `starship` from the distro package if available, or from the upstream installer when the Ubuntu repository does not provide a current package.

On Ubuntu, `fd` is usually installed as `fdfind`.
If a tool expects the `fd` command, add a user-local symlink:

```bash
mkdir -p "$HOME/.local/bin"
ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
```


### Ubuntu arm64 Yazi
Use the official [Yazi APT repository](https://yazi-rs.github.io/docs/installation/) for arm64:
```bash
curl -fsSL https://yazi-rs.github.io/builds/yazi-keyring.gpg | sudo tee /usr/share/keyrings/yazi-keyring.gpg >/dev/null
echo 'deb [signed-by=/usr/share/keyrings/yazi-keyring.gpg] https://yazi-rs.github.io/builds/ stable main' | sudo tee /etc/apt/sources.list.d/yazi.list >/dev/null
sudo apt update && sudo apt install yazi
```

### Ubuntu arm64 Neovim language tooling
LazyVim/Mason installs the configured language servers and formatters. Rust tools remain tied to the Rust toolchain:
```bash
rustup component add rust-analyzer clippy rustfmt
```

### Input method stack
```bash
sudo pacman -S fcitx5-im fcitx5-chinese-addons fcitx5-configtool
```

### Machine-specific desktop and GPU stack
```bash
sudo pacman -S nvidia-open nvidia-utils nvidia-settings
sudo pacman -S gnome gdm
```

---

## Configuration notes

### git
Git is configured as part of the portable user environment.
Global identity and editor behavior belong in the repo; host-specific credential state does not.

### zsh
The shell is intentionally configured without a large external framework.
Prompt logic, history behavior, completion-related enhancements, and shell usability are kept explicit.

### starship
Starship owns prompt rendering and should remain separate from shell logic.
Prompt theme and styling belong in `starship.toml`, not in ad hoc shell code.

### tmux
tmux should remain a lightweight but reliable terminal multiplexer layer.
Its configuration should prioritize readability, persistence, and clean navigation before adding more advanced plugin-based features.

### neovim
LazyVim provides the plugin baseline; user-specific options and plugins live under `nvim/lua/config/` and `nvim/lua/plugins/`. Keep `nvim/lazy-lock.json` under version control; Neo-tree is intentionally disabled in favor of Yazi for terminal file browsing.

### input method
Input method support is part of the system baseline when Chinese input is needed, but the actual portable boundary remains the same:
package and environment expectations can be documented here, while local desktop/session quirks remain outside the repo.

---

## Local-only items not committed here

These are intentionally excluded:

- `~/.ssh/`
- local SSH config on macOS
- SSH private keys
- shell history files
- generated zsh completion cache such as `~/.zcompdump*`
- machine-specific hostnames, IP addresses, and aliases
- `~/.zshrc.local` and other host-specific shell settings
- desktop/session power management state
- plugin download directories and runtime caches
- Neovim plugin state under `~/.local/share/nvim`
- Neovim cache/state under `~/.cache/nvim` and `~/.local/state/nvim`

---

## Bootstrap philosophy

This repository is not yet a full machine bootstrap system.
Instead, it serves as:

1. the canonical source for portable user-level config
2. the reference list of packages and tools expected on the machine
3. the rebuild checklist for recreating the development environment on macOS or supported Linux hosts

A typical rebuild flow is:

1. install required system packages
2. clone this repository
3. symlink standard configuration paths, including `~/.config/nvim` and `~/.config/yazi`, to the tracked files so repository edits take effect directly
4. keep host-specific shell settings in `~/.zshrc.local`
5. verify shell, prompt, tmux, and editor behavior

---

## Tool version policy

System package managers own globally installed tool versions; shared dotfiles do not pin them. Update selected Homebrew packages with `brew upgrade <formula>` or all outdated formulae with `brew upgrade`. Do not run upgrades automatically from shell startup.

When a project requires a specific toolchain version, record that requirement at the project level rather than hard-coding a global version in shared shell configuration.

## Maintenance guidelines

When adding or revising configuration:
- keep the portable vs machine-local boundary explicit
- prefer small, understandable changes
- avoid storing anything secret or infrastructure-specific
- update this README whenever a new tool becomes part of the expected baseline
- document package requirements whenever a tracked config depends on them

---

## Summary

This repository is the portable user-configuration layer for a macOS arm64 development environment, with basic compatibility for an Arch desktop and an Ubuntu arm64 VMware VM.

It documents:
- what is tracked
- what is intentionally excluded
- which tools the environment depends on
- how shell, terminal, and editor configuration are organized
- how to rebuild the same user environment on another machine

The repository should remain readable enough to function both as configuration storage and as operational documentation.
