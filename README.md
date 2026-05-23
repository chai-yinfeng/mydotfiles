# dotfiles

Portable user-level configuration for my Linux development environments.

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

This configuration was started on Arch Linux and is also used from an Ubuntu arm64 virtual machine on VMware.
The portable dotfiles should work across both environments, but package names and some tool install paths differ by distribution.

The primary Arch desktop baseline assumes:

- Arch Linux installed and bootable
- NetworkManager installed, enabled, and functioning
- OpenSSH server installed, enabled, and functioning
- NVIDIA driver stack installed and functioning
- GNOME + GDM installed and functioning
- a normal user account configured with sudo access
- GitHub access configured
- a dotfiles repository initialized and pushed to GitHub

The Ubuntu VM baseline assumes:

- Ubuntu arm64 installed and bootable under VMware
- `apt` package management available
- a normal user account configured with sudo access
- GitHub access configured
- development tools installed from a mix of `apt`, `npm`, `go install`, and `rustup`

The repo focuses on the portable user-space layer that sits on top of that baseline.

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

The exact directory layout may evolve, but the boundary remains the same:
portable user configuration belongs here, machine-local operational state does not.

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

An old local Oh My Zsh directory may still exist as a backup on some machines, but it is not part of the active configuration design.

### zsh behavior goals
- minimal and explicit configuration
- readable prompt and command workflow
- command history with duplicate control
- no heavy alias-driven workflow
- plugins used only for clearly scoped functionality
- configuration that remains understandable months later

### Linux path compatibility
The `zsh` configuration handles both common Arch and Ubuntu plugin locations:

- Arch-style zsh plugins under `/usr/share/zsh/plugins/...`
- Ubuntu/Debian-style zsh plugin files under `/usr/share/zsh-autosuggestions/...` and `/usr/share/zsh-syntax-highlighting/...`

It also puts common user-level tool directories on `PATH`:

- `$HOME/.local/bin`
- `$HOME/go/bin`
- `$HOME/.cargo/bin`

These paths are required for tools installed by `pipx` or local scripts, `go install`, and `rustup`/`cargo`.

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

Neovim is treated as a first-class part of the environment rather than a one-off editor install.

### Current direction
- Lua-based configuration
- modern plugin management
- portable config stored under the repo
- editor behavior documented alongside shell and terminal configuration
- explicit LSP setup for the languages currently used

### Current setup approach
The environment is moving toward a `kickstart.nvim`-based configuration rather than a fully custom-from-scratch setup.

Reason:
- faster path to a stable modern Neovim baseline
- easier access to community-tested defaults
- simpler incremental learning
- better foundation before making deeper custom changes

### Neovim goals
- reliable everyday editing
- maintainable configuration structure
- strong search/navigation ergonomics
- modern syntax and LSP support
- minimal unnecessary complexity at the start

### Current LSP and formatting coverage
The active Neovim configuration enables these language servers:

- `clangd` for C/C++, started with `--background-index` and `--clang-tidy`
- `pyright` for Python
- `rust_analyzer` for Rust, with checks routed through `clippy`
- `gopls` for Go, with `gofumpt`, `staticcheck`, and extra analyses enabled
- `lua_ls` for Lua and Neovim configuration editing

Formatting is configured through `conform.nvim`:

- Lua: `stylua`
- Python: `isort`, `black`
- Go: `goimports`, `gofumpt`
- Rust: `rustfmt`
- C/C++: `clang-format`, available manually; format-on-save is disabled for C/C++

Mason is currently used conservatively to install `lua_ls` and `stylua`.
The other language servers and formatters should be installed at the system or user-tool level so the same config works cleanly on Ubuntu arm64 and Arch.

---

## Package and tool inventory

This section intentionally includes more than the files tracked in the repo.
It documents the tools expected to exist on a fresh system so the configuration in this repository works correctly.

### Core system utilities
- `base-devel`
- `git`
- `curl`
- `wget`
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
- `lua-language-server`
- `stylua`
- `pyright`
- `black`
- `isort`
- `gopls`
- `goimports`
- `gofumpt`
- `staticcheck`
- `rust-analyzer`
- `rustfmt`
- `clippy`

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

### Arch base user environment
```bash
sudo pacman -Syu
sudo pacman -S base-devel git curl wget zip unzip man-db man-pages
sudo pacman -S zsh starship tmux zoxide zsh-autosuggestions zsh-syntax-highlighting
sudo pacman -S neovim ripgrep fd fzf tree htop btop
sudo pacman -S nodejs npm python python-pip gcc make clang rustup go tree-sitter-cli
sudo pacman -S networkmanager openssh firefox
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu
```

### Arch Neovim language tooling
```bash
sudo pacman -S lua-language-server stylua pyright python-black python-isort clang
sudo pacman -S gopls gofumpt rust-analyzer
go install golang.org/x/tools/cmd/goimports@latest
go install honnef.co/go/tools/cmd/staticcheck@latest
rustup component add clippy rustfmt
```

### Ubuntu arm64 VM base user environment
```bash
sudo apt update
sudo apt install zsh git curl wget zip unzip build-essential
sudo apt install tmux zoxide zsh-autosuggestions zsh-syntax-highlighting
sudo apt install neovim ripgrep fd-find fzf tree htop btop
sudo apt install nodejs npm python3 python3-pip python3-venv pipx
sudo apt install clang clangd clang-format clang-tidy golang-go
```

Install `starship` from the distro package if available, or from the upstream installer when the Ubuntu repository does not provide a current package.

On Ubuntu, `fd` is usually installed as `fdfind`.
If a tool expects the `fd` command, add a user-local symlink:

```bash
mkdir -p "$HOME/.local/bin"
ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
```

### Ubuntu arm64 Neovim language tooling
```bash
npm install -g pyright
pipx install black
pipx install isort
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
go install mvdan.cc/gofumpt@latest
go install honnef.co/go/tools/cmd/staticcheck@latest
rustup component add rust-analyzer clippy rustfmt
```

The Ubuntu shell config already adds `$HOME/.local/bin`, `$HOME/go/bin`, and `$HOME/.cargo/bin` to `PATH`, which is why the user-level installs above are preferred for VM compatibility.

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
Neovim configuration should remain understandable enough to be maintained directly from the repo.
The editor setup should favor stable defaults, explicit plugin ownership, and gradual customization over unnecessary early complexity.

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
3. the rebuild checklist for recreating the development environment on a fresh Linux system

A typical rebuild flow is:

1. install required system packages
2. clone this repository
3. place config files via copy or symlink
4. verify shell, prompt, tmux, and editor behavior
5. apply machine-specific configuration separately

---

## Maintenance guidelines

When adding or revising configuration:
- keep the portable vs machine-local boundary explicit
- prefer small, understandable changes
- avoid storing anything secret or infrastructure-specific
- update this README whenever a new tool becomes part of the expected baseline
- document package requirements whenever a tracked config depends on them

---

## Summary

This repository is the portable user-configuration layer for Linux development systems, currently covering an Arch desktop and an Ubuntu arm64 VMware VM.

It documents:
- what is tracked
- what is intentionally excluded
- which tools the environment depends on
- how shell, terminal, and editor configuration are organized
- how to rebuild the same user environment on another machine

The repository should remain readable enough to function both as configuration storage and as operational documentation.
