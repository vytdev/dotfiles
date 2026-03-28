# Custom prompt string. Too lazy to use starship.
#

crun ansi # colors and stuff
OLDPS1="$PS1"

test -n "$BASH_VERSION" && \
  eval 'PROMPT_COMMAND+=("__prompt_preps1")'  # bash-only

__prompt_preps1() {
  LASTSTATUS=$?
  __prompt_before
  PS1="$(__prompt_main)\[${crset}\]"
}

__prompt_pwd() {
  case "$1" in
    base) basename "$PWD";;
    abs) echo "$PWD";;
    rel|*) echo "${PWD/#$HOME/\~}";;
  esac
}

# do stuff before the shell prints PS1
__prompt_before() {
  printf "${crset}"
}

# the prompt line (requires '\[\]' for non-printables)
__prompt_main() {
  test "$LASTSTATUS" -eq 0  \
    && __color="\[${cfg_green}\]" \
    || __color="\[${cfg_red}\]"
  printf ' %s❯ ' "$__color"
  unset __color
}
