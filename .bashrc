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

# pnpm
export PNPM_HOME="/home/mouhamed/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

alias ls="eza --color=auto"
alias la="eza -alh"

alias v="nvim"

export EDITOR="nvim"

alias ev="$EDITOR ~/.config/nvim/init.lua"
alias ei="$EDITOR ~/.config/i3/config"
alias du="du -h"
alias npm="pnpm"
alias npx="pnpx"
alias tldr="tlgr"

alias cd="z"
source <(zoxide init bash)

cdd() {
  cd ~/Development/projects
  local target=$(ls | fzf)
  cd $target
}

eb() {
  $EDITOR ~/.bashrc
  source ~/.bashrc
}

flutter_watch() {
  tmux \
    send-keys "flutter run $1 $2 $3 $4 --pid-file=/tmp/fp.pid" Enter \; \
    split-window -v \; \
    send-keys 'while true; do find ./lib -name *.dart | entr -cpsd "cat /tmp/fp.pid | xargs -Ixx kill -USR1 xx" ; done' Enter \; \
    resize-pane -y 5 \; \
    select-pane -t 0 \;
}

tmux_session() {
  selected=$(find ~/Development/projects/ -maxdepth 1 -mindepth 1 -type d | fzf)

  if [[ -z $selected ]]; then
    exit 0
  fi

  selected_name=$(basename "$selected" | tr . _)
  tmux_running=$(pgrep tmux)

  if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
  fi

  if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
  fi

  if [[ -z $TMUX ]]; then
    tmux attach -t $selected_name
  else
    tmux switch-client -t $selected_name
  fi
}
bind '"\C-f":"tmux_session\n"'

export MANPAGER="nvim +Man!"

# PATH
export PATH="$PATH:/home/mouhamed/go/bin"
export PATH="$PATH:/home/mouhamed/Android/Sdk/platform-tools"
export PATH="$PATH:/home/mouhamed/Android/Sdk/emulator"

# flutter completions
source <(flutter bash-completion)
source <(fzf --bash)
