# Message-Of-The-Day
#

# respect .hushlogin file
if [ ! -e "$HOME/.hushlogin" ]; then

  # detect support for ansi colors
  case "$TERM" in
    *color*|xterm*|screen*|tmux*|vt100*) colorize=yes ;;
    *) [ -n "$COLORTERM" ] && colorize=yes ;;
  esac

  disk=$(df -h "$HOME" | awk 'NR==2 {printf "%s / %s (%s)\n", $3, $2, $5}')
  ram=$(free -h | awk 'NR==2 {printf "%s / %s", $3, $2}')
  shell=$(ps -p $$ -o comm=)
  kernel="$(uname -s) $(uname -r)"

  if [ -n "$colorize" ]; then

    # a green-colored block
    b='\033[38;5;11m\033[48;5;11m..\033[0m'

    # the colored message
    printf "\n"
    printf "                    \033[1mHi, \033[33m$USER\033[39m!\033[0m\n"
    printf "\n"
    printf "    $b$b    $b$b    \033[33mDisk:\033[0m %s\n"     "$disk"
    printf "    $b$b    $b$b    \033[33mRAM:\033[0m %s\n"      "$ram"
    printf "        $b$b        \033[33mKernel:\033[0m %s\n"   "$kernel"
    printf "      $b$b$b$b      \033[33mShell:\033[0m %s\n"    "$shell"
    printf "      $b    $b\n"
    printf "                    \033[1mTouch grass.\033[0m\n"

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
    echo
    echo "  Hi, $USER!"
    echo
    echo "  Disk: $disk"
    echo "  RAM: $ram"
    echo "  Kernel: $kernel"
    echo "  Shell: $shell"
    echo
    echo "  Touch grass."
    echo
  fi

  unset disk
  unset ram
  unset shell
  unset kernel
  unset colorize
fi
