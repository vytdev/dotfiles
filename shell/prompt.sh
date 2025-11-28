# Setup custom prompt string
#

# check support for ansi colors
case "$TERM" in
  *color*|xterm*|screen*|tmux*|vt100*) colorize=yes ;;
  *) [ -n "$COLORTERM" ] && colorize=yes ;;
esac

# custom prompt
cust_ncol='\u@\h:\w\$ '
cust_wcol='\[\e[0m\]\[\e[32m\]\[\e[0m\]\[\e[42m\]\[\e[30m\]\w \[\e[0m\]\[\e[32m\]\[\e[0m\]  '

[ -n "$colorize" ] && PS1="$cust_wcol" || PS1="$cust_ncol"

unset cust_ncol
unset cust_wcol
unset colorize
