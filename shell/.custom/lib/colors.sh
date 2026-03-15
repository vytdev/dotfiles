# Color definitions
#

########################################################
__now=$(stat -c %Y ~/.custom/lib/colors.sh)
if [ $__now -gt ${__custom_loaded_lib_colors:-0} ]; then
__custom_loaded_lib_colors=$__now
########################################################


# detect support for ansi colors
case "$TERM" in
  *color*|xterm*|screen*|tmux*|vt100*) colorize=yes ;;
  *) [ -n "$COLORTERM" ] && colorize=yes ;;
esac

if [ "$colorize" = yes ]; then

  crset='\033[0m'
  cbold='\033[1m'
  cdimm='\033[2m'
  cital='\033[3m'
  cundr='\033[4m'
  cblnk='\033[5m'
  cswap='\033[7m'

  cf00='\033[38;5;0m'
  cf01='\033[38;5;1m'
  cf02='\033[38;5;2m'
  cf03='\033[38;5;3m'
  cf04='\033[38;5;4m'
  cf05='\033[38;5;5m'
  cf06='\033[38;5;6m'
  cf07='\033[38;5;7m'
  cf08='\033[38;5;8m'
  cf09='\033[38;5;9m'
  cf10='\033[38;5;10m'
  cf11='\033[38;5;11m'
  cf12='\033[38;5;12m'
  cf13='\033[38;5;13m'
  cf14='\033[38;5;14m'
  cf15='\033[38;5;15m'
  cfrs='\033[39m'

  cb00='\033[48;5;0m'
  cb01='\033[48;5;1m'
  cb02='\033[48;5;2m'
  cb03='\033[48;5;3m'
  cb04='\033[48;5;4m'
  cb05='\033[48;5;5m'
  cb06='\033[48;5;6m'
  cb07='\033[48;5;7m'
  cb08='\033[48;5;8m'
  cb09='\033[48;5;9m'
  cb10='\033[48;5;10m'
  cb11='\033[48;5;11m'
  cb12='\033[48;5;12m'
  cb13='\033[48;5;13m'
  cb14='\033[48;5;14m'
  cb15='\033[48;5;15m'
  cbrs='\033[49m'

fi; unset colorize

cfg_black="$cf00"
cfg_red="$cf01"
cfg_green="$cf02"
cfg_yellow="$cf03"
cfg_blue="$cf04"
cfg_magenta="$cf05"
cfg_cyan="$cf06"
cfg_white="$cf07"
cfg_grey="$cf08"
cfg_bred="$cf09"
cfg_bgreen="$cf10"
cfg_byellow="$cf11"
cfg_bblue="$cf12"
cfg_bmagenta="$cf13"
cfg_bcyan="$cf14"
cfg_bwhite="$cf15"

cbg_black="$cb00"
cbg_red="$cb01"
cbg_green="$cb02"
cbg_yellow="$cb03"
cbg_blue="$cb04"
cbg_magenta="$cb05"
cbg_cyan="$cb06"
cbg_white="$cb07"
cbg_grey="$cb08"
cbg_bred="$cb09"
cbg_bgreen="$cb10"
cbg_byellow="$cb11"
cbg_bblue="$cb12"
cbg_bmagenta="$cb13"
cbg_bcyan="$cb14"
cbg_bwhite="$cb15"


########################################################
fi; unset __now
########################################################
