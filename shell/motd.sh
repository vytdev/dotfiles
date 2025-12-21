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
    b='\033[38;5;10m\033[48;5;10m..\033[0m'

    # the colored message
    printf "\n"
    printf "                    \033[1mHi, \033[32m$(whoami)\033[39m!\033[0m\n"
    printf "\n"
    printf "    $b$b    $b$b    A legend once said:\n"
    printf "    $b$b    $b$b\n"
    printf "        $b$b          For what is a man, what has he got\n"
    printf "      $b$b$b$b        If not himself, then he has naught\n"
    printf "      $b    $b        To say the things he truly feels\n"
    printf "                      And not the words of one who kneels\n"
    printf "                      The record shows, I took the blows\n"
    printf "                      And did it, My Way!\n"
    printf "\n"
    printf "                      \033[1mFrank Sinatra\033[0m\n"

    unset b

    # print color palette
    cnt=0
    while [ "$cnt" -lt 16 ]; do
      [ $((cnt % 8)) -eq 0 ] && printf '\n                    '
      printf '\033[38;5;%sm\033[48;5;%sm..\033[0m' "$cnt" "$cnt"
      cnt=$((cnt + 1))
    done
    printf '\n\n'
    unset cnt

  # fallback to colorless text
  else
    cat "$DOTFILES/shell/motd"
  fi

  unset colorize
fi
