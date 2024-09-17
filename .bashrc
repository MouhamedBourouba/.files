[ -z "$PS1" ] && return

RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
PURPLE="\[\033[0;35m\]"
CYAN="\[\033[0;36m\]"
WHITE="\[\033[0;37m\]"
RESET="\[\033[0m\]"

# Function to show the current git branch if you're in a git repo
parse_git_branch() {
  git branch 2>/dev/null | grep -e '^*' | sed 's/* \(.*\)/ (\1)/'
}

# Custom PS1
PS1="${CYAN}\u@\h ${YELLOW}\w${GREEN}\$(parse_git_branch)${RESET}\$ "
HISTCONTROL=ignoredups:ignorespace

shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

alias ls="exa --color=auto"
alias la="exa -alh"

export EDITOR="nvim"
alias v="$EDITOR"

alias ev="$EDITOR ~/.config/nvim/init.lua"
alias ei="$EDITOR ~/.config/i3/config"
alias dd="cd ~/dev/"

eb() {
  $EDITOR ~/.bashrc
  source ~/.bashrc
}
