# Interactive shell options (might only work for bash)
#

# command history
HISTSIZE=5000
HISTFILESIZE=10000
HISTCONTROL=ignoredups:erasedups
HISTIGNORE='ls:cd:pwd:exit:clear'
shopt -s histappend

# GPG needs terminal
export GPG_TTY=$(tty)

# dircolors
eval "$(dircolors -b)"
