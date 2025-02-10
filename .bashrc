[ -z "$PS1" ] && return

RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
PURPLE="\[\033[0;35m\]"
CYAN="\[\033[0;36m\]"
WHITE="\[\033[0;37m\]"
RESET="\[\033[0m\]"

parse_git_branch() {
  git branch 2>/dev/null | grep -e '^*' | sed 's/* \(.*\)/ (\1)/'
}

PS1="${CYAN}\u@\h ${YELLOW}\w${GREEN}\$(parse_git_branch)${RESET}\$ "
HISTCONTROL=ignoredups:ignorespace

shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

alias ls="exa --color=auto"
alias la="exa -alh"

export EDITOR="nvim"

alias ev="$EDITOR ~/.config/nvim/init.lua"
alias ei="$EDITOR ~/.config/i3/config"
alias du="du -h"
alias npm="pnpm"
alias npx="pnpx"

alias cd="z"
source <(zoxide init bash)

v() {
  if [[ -e Session.vim ]]; then
    nvim -S Session.vim $@
  else
    nvim $@
  fi
}

cdd() {
  cd ~/Development/projects
  local target=$(ls | fzf)
  cd $target
}

eb() {
  $EDITOR ~/.bashrc
  source ~/.bashrc
}

export MANPAGER="nvim +Man!"

# PATH
export PATH="$PATH:/home/mouhamed/Development/third-party/flutter/bin"
export PATH="$PATH:/home/mouhamed/go/bin"
export PATH="$PATH:/home/mouhamed/Android/Sdk/platform-tools"
export PATH="$PATH:/home/mouhamed/Android/Sdk/emulator"
