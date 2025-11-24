# Setup custom prompt string
#

# check support for ansi colors
case "$TERM" in
  *color*|xterm*|screen*|tmux*|vt100*) colorize=yes ;;
  *) [ -n "$COLORTERM" ] && colorize=yes ;;
esac

# debian-style prompt
deb_ncol='\u@\h:\w\$ '
deb_wcol='\[\e[0m\]\[\e[32m\]\u@\h\[\e[0m\]:\[\e[34m\]\w\[\e[37m\]\$\[\e[0m\] '

[ -n "$colorize" ] && PS1="$deb_wcol" || PS1="$deb_ncol"

unset deb_ncol
unset deb_wcol
unset colorize
