# Message-Of-The-Day
#

# load color defs
. ~/.custom/lib/colors.sh

# respect .hushlogin file
if [ ! -e "$HOME/.hushlogin" ]; then

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
fi
