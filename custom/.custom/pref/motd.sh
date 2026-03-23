# Message-Of-The-Day
#

# respect .hushlogin file
if [ ! -e "$HOME/.hushlogin" ]; then

  crun ansi # colors and stuff

  # a blue-colored block
  b="${cfg_blue}${cbg_blue}##${crset}"

  # the colored message
  printf "\n"
  printf "  $b  $b  $b$b$b  ${cbold}Hi, ${cfg_blue}$USER${cfrs}!${crset}\n"
  printf "  $b  $b    $b\n"
  printf "  $b$b$b    $b    ${cbold}Touch grass.${crset}\n"
  printf "  $b  $b    $b\n"
  printf "  $b  $b  $b$b$b\n"
  printf "\n"

  unset b
fi
