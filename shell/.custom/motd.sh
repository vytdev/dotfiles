# Message-Of-The-Day
#

# respect .hushlogin file
if [ ! -e "$HOME/.hushlogin" ]; then

  # detect support for ansi colors
  case "$TERM" in
    *color*|xterm*|screen*|tmux*|vt100*) colorize=yes ;;
    *) [ -n "$COLORTERM" ] && colorize=yes ;;
  esac

  if [ -n "$colorize" ]; then

    # a green-colored block
    b='\033[38;5;4m\033[48;5;4m..\033[0m'

    # the colored message
    printf "\n"
    printf "  $b  $b  $b$b$b  \033[1mHi, \033[38;5;4m$USER\033[39m!\033[0m\n"
    printf "  $b  $b    $b\n"
    printf "  $b$b$b    $b    \033[1mTouch grass.\033[0m\n"
    printf "  $b  $b    $b\n"
    printf "  $b  $b  $b$b$b\n"
    printf "\n"

  # fallback to colorless text
  else
    echo
    echo "  Hi, $USER!"
    echo
    echo "  Touch grass."
    echo
  fi

  unset colorize
fi
