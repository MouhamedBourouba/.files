[[ $- != *i* ]] && return

HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups:ignorespace

export EDITOR="nvim"
export MANPAGER="nvim +Man!"

export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/Android/Sdk/platform-tools"
export PATH="$PATH:$HOME/Android/Sdk/emulator"
export PATH="$PATH:$HOME/.config/scripts"

shopt -s histappend
shopt -s checkwinsize

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias ls='eza --color=auto'
alias la='eza -alh'

alias vim="nvim"
alias ev="$EDITOR ~/.config/nvim/init.lua"
alias ei="$EDITOR ~/.config/i3/config"

alias du='du -h'
alias npm='pnpm'
alias npx='pnpx'
alias tldr='tlgr'

eval "$(zoxide init bash)"
alias cd='z'

[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

if [[ -f /etc/bash_completion ]] && ! shopt -oq posix; then
  source /etc/bash_completion
fi

export PNPM_HOME="$HOME/.local/share/pnpm"
[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"


bind '"\C-f":"tmux_session\n"'

RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
PURPLE="\[\033[0;35m\]"
CYAN="\[\033[0;36m\]"
WHITE="\[\033[0;37m\]"
RESET="\[\033[0m\]"

parse_git_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null | sed 's/.*/ (\0)/'
}
PS1="${CYAN}\u@\h ${YELLOW}\w${GREEN}\$(parse_git_branch)${RESET}\$ "

# fzf shell integrations
command -v fzf &>/dev/null && source <(fzf --bash)
