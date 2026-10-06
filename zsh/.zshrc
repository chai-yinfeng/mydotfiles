# -----------------------------
# Basic editor and pager setup
# -----------------------------
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

# Paste a code reference from Codex and open it at the indicated line/column.
function nv() {
  if (( $# != 1 )); then
    print -u2 'Usage: nv "path:line[:column]"'
    return 2
  fi
  NVIM_CODE_LOCATION="$1" command nvim '+CodeLocation'
}

# Machine-specific settings live outside this repository.
if [[ -r "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi

# Yazi's wrapper returns the last directory to this shell.
if command -v yazi >/dev/null 2>&1; then
  function y() {
    local tmp cwd
    tmp="$(mktemp -t 'yazi-cwd.XXXXXX')" || return
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [[ "$cwd" != "$PWD" && -d "$cwd" ]] && builtin cd -- "$cwd" || builtin true
    command rm -f -- "$tmp"
  }
fi

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
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# -----------------------------
# Starship prompt
# Cross-shell prompt configuration
# -----------------------------
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# -----------------------------
# zsh-autosuggestions
# Shows command suggestions based on history
# -----------------------------
if [[ -n "${HOMEBREW_PREFIX:-}" && -r "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
elif [[ -r /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# -----------------------------
# zsh-syntax-highlighting
# Highlights commands before execution
# Keep this near the end of the file
# -----------------------------
if [[ -n "${HOMEBREW_PREFIX:-}" && -r "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
elif [[ -r /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Add user-managed tool directories only when installed.
typeset -U path
for user_bin in "$HOME/.cargo/bin" "$HOME/go/bin" "$HOME/.local/bin"; do
  [[ -d "$user_bin" ]] && path=("$user_bin" $path)
done
unset user_bin
