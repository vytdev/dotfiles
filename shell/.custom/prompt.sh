# Setup custom prompt string
#

# check support for ansi colors
case "$TERM" in
  *color*|xterm*|screen*|tmux*|vt100*) colorize=yes ;;
  *) [ -n "$COLORTERM" ] && colorize=yes ;;
esac

# custom prompt
cust_ncol='\W '
cust_wcol='\[\033[0m\]\[\033[38;5;4m\]\W\[\033[0m\] '

[ -n "$colorize" ] && PS1="$cust_wcol" || PS1="$cust_ncol"

unset cust_ncol
unset cust_wcol
unset colorize
