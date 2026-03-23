# Custom prompt string. Too lazy to use starship.
#

crun ansi # colors and stuff

# always run this before PS1
__prompt_pre() {
  __prompt_lstatus=$?
}

__prompt_pwd() {
  case "$1" in
    base) basename "$PWD";;
    abs) echo "$PWD";;
    rel|*) echo "${PWD/#$HOME/\~}";;
  esac
}

__prompt_mode() {
  [ "$UID" = 0 ] && echo "#" || echo "\$"
}

__prompt_git() {
  __fmt="$( [ $# -ge 1 ] && echo "$1" || echo '%s' )"
  __br="$(git branch 2>/dev/null | grep '*' | sed 's/* //')"
  [ -n "$__br" ] && printf "$__fmt" "$__br"
  unset __br __fmt
}

__prompt_stat() {
  __fmt="$( [ $# -ge 1 ] && echo "$1" || echo '%s' )"
  [ "$__prompt_lstatus" -ne 0 ] && printf "$__fmt" "$__prompt_lstatus"
  unset __fmt
}


# define modules
cp_pwd="\[${cfg_blue}\]\$(__prompt_pwd rel)\[${crset}\]"
cp_git="\[${cfg_yellow}\]\$(__prompt_git '[%s]')\[${crset}\]"
cp_stat="\[${cfg_red}\]\$(__prompt_stat '!%s')\[${crset}\]"
cp_mode="\[${cfg_cyan}\]\$(__prompt_mode)\[${crset}\]"

cp_main=" ${cp_pwd}${cp_git}${cp_stat}${cp_mode} "
cp_xtitle="\[${cxbegtl}term: \w${cxendtl}\]"

# don't change the following
PROMPT_COMMAND='__prompt_pre'
PS1="${cp_xtitle}\[${crset}\]${cp_main}\[${crset}\]"
