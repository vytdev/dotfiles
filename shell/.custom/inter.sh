# Interactive shell options (might only work for bash)
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
HISTIGNORE='ls:cd:pwd:exit:clear'
shopt -s histappend

# GPG needs terminal
export GPG_TTY=$(tty)

# enable color support for ls
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors &&
    eval "$(dircolors -b ~/.dircolors)" ||
    eval "$(dircolors -b)"
fi

# other interactive shell necessities
[ -f ~/.custom/utils.sh ]        && . ~/.custom/utils.sh
[ -f ~/.custom/pref/alias.sh ]   && . ~/.custom/pref/alias.sh
[ -f ~/.custom/pref/prompt.sh ]  && . ~/.custom/pref/prompt.sh
