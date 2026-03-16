[[ $- != *i* ]] && return

export EDITOR="nvim"
export MANPAGER="nvim +Man!"

export PATH="$PATH:$HOME/.go/bin"
export PATH="$PATH:$HOME/Android/Sdk/platform-tools"
export PATH="$PATH:$HOME/Android/Sdk/emulator"
export PATH="$PATH:$HOME/Development/tools/bin"
export PATH="$PATH:$HOME/.config/scripts"
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
export GOPATH="$HOME/.go/"

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ls='eza --color=auto'
alias la='eza -alh'
alias nim="nvim"
alias ev="$EDITOR ~/.config/nvim/init.lua"
alias ei="$EDITOR ~/.config/i3/config"
alias npm='pnpm'
alias npx='pnpx'
alias tldr='tlgr'
alias cd='z'

bind '"\C-f":"tmux_session_fzf\n"'

shopt -s histappend
shopt -s checkwinsize

HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups:ignorespace

## PROMPT
GREEN="\[\033[0;32m\]"
YELLOW="\[\033[0;33m\]"
CYAN="\[\033[0;36m\]"
RESET="\[\033[0m\]"
parse_git_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null | sed 's/.*/ (\0)/'
}
PS1="${CYAN}\u@\h ${YELLOW}\w${GREEN}\$(parse_git_branch)${RESET}\$ "

command -v fzf &>/dev/null && source <(fzf --bash)
export PNPM_HOME="$HOME/.local/share/pnpm"
[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"
eval "$(zoxide init bash)"
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi
