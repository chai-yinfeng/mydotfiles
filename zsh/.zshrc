export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS

autoload -Uz compinit
compinit

bindkey -e

PROMPT='%n@%m %1~ %# '
