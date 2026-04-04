# dotfiles

Personal machine-independent configuration for my Arch Linux development environment.

This repository tracks reusable user-level configuration, not full machine provisioning.
It also documents the packages and tools expected to exist on the system so the configs here work correctly.

---

## Scope

### Included in this repo
- zsh
- starship
- tmux
- git
- neovim

### Not included in this repo
- GPU drivers
- display manager / desktop environment
- host-specific power settings
- SSH private keys
- local SSH host config on other machines
- machine-specific network configuration
- secrets / tokens / credentials
- package manager cache or generated runtime files

---

## Current environment status

This repo currently reflects an Arch Linux setup with the following baseline:

- Arch Linux installed and bootable
- NetworkManager configured and working
- OpenSSH server enabled and working
- NVIDIA driver working
- GNOME + GDM installed and working
- zsh configured without Oh My Zsh
- Starship used as prompt
- zsh-autosuggestions enabled
- zsh-syntax-highlighting enabled
- zoxide enabled
- dotfiles repo initialized and pushed to GitHub

---

## Shell stack

### Current shell design
The shell setup intentionally avoids large framework coupling.

Current stack:
- zsh
- starship
- zoxide
- zsh-autosuggestions
- zsh-syntax-highlighting

### Why not Oh My Zsh
Oh My Zsh was tested initially, but the current setup uses plain zsh for:
- better transparency
- easier migration
- fewer framework-specific assumptions
- simpler dotfiles management

The old Oh My Zsh directory may still exist locally as a backup, but it is no longer part of the active shell config.

### Current zsh goals
- minimal and explicit config
- readable command history behavior
- no excessive alias-driven workflow
- plugin behavior kept understandable
- portable across machines

---

## Managed files

Planned / current tracked files:

- git/.gitconfig
- zsh/.zshrc
- starship/starship.toml
- tmux/.tmux.conf
- nvim/ (later)

---

## Package and tool inventory

This section is intentionally broader than what is tracked in the repo.
It documents what should be installed on a fresh Arch setup so the configs here work correctly.

### Core system utilities
- base-devel
- git
- curl
- wget
- zip
- unzip
- man-db
- man-pages

### Shell and terminal tools
- zsh
- starship
- tmux
- zoxide
- zsh-autosuggestions
- zsh-syntax-highlighting

### CLI productivity tools
- ripgrep
- fd
- fzf
- tree
- htop
- btop

### Editor
- neovim

### Network / remote access
- networkmanager
- openssh

### Fonts
- noto-fonts
- noto-fonts-cjk
- noto-fonts-emoji
- ttf-dejavu

### Input method (planned / optional depending on workflow)
- fcitx5-im
- fcitx5-chinese-addons
- fcitx5-configtool

### Browser
- firefox

### Graphics / desktop stack on current machine
These are documented here for reference, but are not part of the portable dotfiles layer.

- nvidia-open
- nvidia-utils
- nvidia-settings
- gnome
- gdm

---

## Example package install commands

### Base user environment
```bash
sudo pacman -Syu
sudo pacman -S base-devel git curl wget zip unzip man-db man-pages
sudo pacman -S zsh starship tmux zoxide zsh-autosuggestions zsh-syntax-highlighting
sudo pacman -S neovim ripgrep fd fzf tree htop btop
sudo pacman -S networkmanager openssh firefox
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu
```

### Optional Chinese input stack
```bash
sudo pacman -S fcitx5-im fcitx5-chinese-addons fcitx5-configtool
```

### Machine-specific desktop / GPU stack
```bash
sudo pacman -S nvidia-open nvidia-utils nvidia-settings
sudo pacman -S gnome gdm
```

---

## Configuration notes

### zsh
Current design choices:
- plain zsh instead of Oh My Zsh
- starship for prompt
- zoxide for smart directory jumping
- autosuggestions enabled
- syntax highlighting enabled
- history de-duplication enabled
- no heavy alias-driven workflow

### starship
Starship is preferred for:
- better portability
- shell-agnostic prompt design
- cleaner long-term migration path
- dedicated config file separate from zsh logic

### tmux
tmux is being configured as a lightweight persistent terminal workspace.
The goal is:
- stable remote sessions
- readable pane/window workflow
- minimal config first, plugins later if needed

### neovim
Neovim setup is planned after tmux.
The intended direction is:
- minimal and maintainable
- modern Lua-based config
- plugin manager kept explicit
- avoid overbuilding too early

---

## Local-only items not committed here

These are intentionally excluded from this repo:

- ~/.ssh/
- local SSH config on Mac
- SSH private keys
- host-specific addresses and machine aliases
- desktop power management settings
- generated zsh completion cache such as ~/.zcompdump*
- shell history files

---

## Bootstrap philosophy

This repo does not try to fully automate machine installation yet.
Instead, it serves as:

1. a source of truth for reusable config files
2. a reference for required packages
3. a checklist for rebuilding the environment on a new Arch machine

The expected workflow on a new machine is:

1. install required packages
2. clone this repo
3. copy or symlink config files into place
4. verify shell / tmux / editor behavior
5. apply any machine-specific configuration separately

---

## Planned next steps

- refine tmux config
- build initial neovim config
- add starship.toml
- document input method setup if retained
- possibly add bootstrap scripts for Arch package installation
- possibly add symlink helper scripts

---

## Notes to self

When adding new configuration:
- prefer explicit config over framework magic
- keep machine-specific settings out of portable dotfiles
- avoid storing secrets or private infrastructure details
- update this README whenever a new tool becomes part of the expected baseline

