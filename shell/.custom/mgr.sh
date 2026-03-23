# Utilities for custom scripts
#

export CUSTOMPREFIX=$HOME/.custom

# add a path to PATH, prevent duplicates
caddpath() {
  case ":$PATH:" in
    *:"$1":*) ;;          # skip if already there
    '::') PATH="$1" ;;    # don't add a colon if it's empty
    *) PATH="$1:$PATH"    # prepend to PATH
  esac
}

# run a script from pref folder
crun() {
  for f in "$@"; do
    f="$CUSTOMPREFIX/pref/$f.sh"
    if [ ! -r "$f" ]; then
      echo "crun: script inaccessible: $f" >&2
      unset f
      return 1
    fi
    . "$f"
  done
  unset f
}

# list all available scripts
clist() {
  h="$CUSTOMPREFIX/pref/"
  for f in $(find "$h" -name '*.sh' ); do
    f="${f#"$h"}"
    f="${f%.sh}"
    echo "$f"
  done
  unset f
  unset h
}

# add .custom/bin to PATH
caddpath "$CUSTOMPREFIX/bin"
