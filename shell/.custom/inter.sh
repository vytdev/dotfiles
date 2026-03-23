# Interactive shell options (might only work for bash). Preferrably
# source from ~/.bashrc .
#

# ignore non-interactive shells
case $- in
  *i*) ;;
  *) return;;
esac

test -f ~/.custom/mgr.sh && . ~/.custom/mgr.sh

# command history
HISTSIZE=5000
HISTFILESIZE=10000
HISTCONTROL=ignoredups:erasedups
HISTIGNORE='ls:cd:pwd:exit:clear'
shopt -s histappend

# GPG needs terminal
export GPG_TTY=$(tty)

# enable color support for ls
if [ -x /usr/bin/dircolors ]; then
  test -r $HOME/.dircolors &&
    eval "$(dircolors -b $HOME/.dircolors)" ||
    eval "$(dircolors -b)"
fi

# other interactive shell necessities
crun alias
crun prompt
