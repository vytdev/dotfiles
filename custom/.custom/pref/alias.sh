# Shortcuts
#

# colorize ls
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# colorize grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# cd aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ls aliases
alias lk='ls -alFhv --group-directories-first'
alias ll='ls -lFhv --group-directories-first'
alias lt='ls -trlFh'

# hot git cmds
alias gs='git status'
alias gg='git log'
alias gd='git diff'

# other aliases
alias dfa='df -ahT'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# make a new dir and cd into it
mkcd() {
  mkdir -p "$1" &&
    cd "$1"
}

# change the terminal title
chtitle() {
  printf "${cxbegtl}%s${cxendtl}" "$@"
}
