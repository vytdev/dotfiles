# Utilities for custom scripts
#

# run a script from ~/.custom
crun() {
  for f in "$@"; do
    f="$HOME"/.custom/"$f".sh
    if [ ! -f "$f" ]; then
      echo "$0: script not found: $f" >&2
      unset f
      return 1
    fi
    . "$f"
  done
  unset f
}

# list all available scripts
clist() {
  h="$HOME"/.custom/
  for f in $(find "$h" -name '*.sh' ); do
    f="${f#"$h"}"
    f="${f%.sh}"
    echo "$f"
  done
  unset f
  unset h
}
