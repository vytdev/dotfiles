# Interactive shell options (might only work for bash).
#

# ignore non-interactive shells
case $- in
  *i*) ;;
  *) return;;
esac

# command history
HISTSIZE=5000
HISTFILESIZE=10000
HISTCONTROL=ignoredups:erasedups
HISTIGNORE='ls:cd:pwd:exit:clear:ll:lt:l'
shopt -s histappend

# GPG needs terminal
export GPG_TTY=$(tty)

# enable color support for ls
if command -v dircolors >/dev/null 2>&1; then
  test -r $HOME/.dircolors &&
    eval "$(dircolors -b $HOME/.dircolors)" ||
    eval "$(dircolors -b)"

  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# cd aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ls aliases
alias l='ls -lFhv --group-directories-first'
alias ll='ls -alFhv --group-directories-first'
alias lt='ls -trlFh'

# hot git cmds
alias gs='git status'
alias gg='git log'
alias gd='git diff'

# other aliases
alias dfa='df -ahT'

# make a new dir and cd into it
mkcd() {
  mkdir -p "$1" &&
    cd "$1"
}

# change the terminal title
chtitle() {
  printf "\033]0;%s\033\\" "$1"
}
