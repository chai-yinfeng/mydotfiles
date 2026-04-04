# -----------------------------
# Basic editor and pager setup
# -----------------------------
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

# -----------------------------
# History configuration
# HISTFILE: where command history is stored
# HISTSIZE: number of commands kept in memory
# SAVEHIST: number of commands written to HISTFILE
# -----------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# -----------------------------
# History behavior
# HIST_IGNORE_DUPS: do not record an immediately repeated command
# HIST_IGNORE_ALL_DUPS: remove older duplicate entries
# SHARE_HISTORY: share history across multiple shell sessions
# EXTENDED_HISTORY: save timestamps in history
# -----------------------------
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# -----------------------------
# Shell usability options
# AUTO_CD: allow typing a directory name to cd into it
# INTERACTIVE_COMMENTS: allow comments in interactive shell
# -----------------------------
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS

# -----------------------------
# Completion system
# compinit initializes zsh completion
# -----------------------------
autoload -Uz compinit
compinit

# -----------------------------
# Use Emacs-style keybindings
# -----------------------------
bindkey -e

# -----------------------------
# zoxide
# A smarter directory jumper
# Example: z project-name
# -----------------------------
eval "$(zoxide init zsh)"

# -----------------------------
# Starship prompt
# Cross-shell prompt configuration
# -----------------------------
eval "$(starship init zsh)"

# -----------------------------
# zsh-autosuggestions
# Shows command suggestions based on history
# -----------------------------
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# -----------------------------
# zsh-syntax-highlighting
# Highlights commands before execution
# Keep this near the end of the file
# -----------------------------
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
