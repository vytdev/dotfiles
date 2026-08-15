# Custom prompt string. Too lazy to use starship.
#

OLDPS1="$PS1"

test -n "$BASH_VERSION" && \
  eval 'PROMPT_COMMAND+=("__prompt_preps1")'  # bash-only

__prompt_preps1() {
  LASTSTATUS=$?
  __prompt_before
  PS1="$(__prompt_main)\[\033[0m\]"
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
  printf "\033[0m"
}

# the prompt line (requires '\[\]' for non-printables)
__prompt_main() {
  test "$LASTSTATUS" -eq 0  \
    && __color="\[\033[38;5;2m\]" \
    || __color="\[\033[38;5;1m\]"
  printf ' %s❯ ' "$__color"
  unset __color
}
