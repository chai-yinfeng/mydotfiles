# dotfiles

Portable user-level configuration for my Arch Linux development environment.

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

This configuration assumes an Arch Linux system with the following baseline already working:

- Arch Linux installed and bootable
- NetworkManager installed, enabled, and functioning
- OpenSSH server installed, enabled, and functioning
- NVIDIA driver stack installed and functioning
- GNOME + GDM installed and functioning
- a normal user account configured with sudo access
- GitHub access configured
- a dotfiles repository initialized and pushed to GitHub

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
- `nodejs`
- `npm`
- `python`
- `python-pip`

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

### Base user environment
```bash
sudo pacman -Syu
sudo pacman -S base-devel git curl wget zip unzip man-db man-pages
sudo pacman -S zsh starship tmux zoxide zsh-autosuggestions zsh-syntax-highlighting
sudo pacman -S neovim ripgrep fd fzf tree htop btop
sudo pacman -S nodejs npm python python-pip gcc
sudo pacman -S networkmanager openssh firefox
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu
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
3. the rebuild checklist for recreating the development environment on a fresh Arch system

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

This repository is the portable user-configuration layer for an Arch Linux development system.

It documents:
- what is tracked
- what is intentionally excluded
- which tools the environment depends on
- how shell, terminal, and editor configuration are organized
- how to rebuild the same user environment on another machine

The repository should remain readable enough to function both as configuration storage and as operational documentation.

