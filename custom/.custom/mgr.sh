# ~/.custom utilities. Required by inter.sh and login.sh.
#

# where .custom is installed
export CUSTOMPREFIX

# add a path to PATH, prevent duplicates
caddpath() {
  case ":$PATH:" in
    *:"$1":*) ;;          # skip if already there
    '::') PATH="$1" ;;    # don't add a colon if it's empty
    *) PATH="$1:$PATH" ;; # prepend to PATH
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
  pref="$CUSTOMPREFIX/pref"
  for f in "$pref"/*.sh; do
    f="${f#"$pref/"}"
    f="${f%.sh}"
    echo "$f"
  done
  unset f pref
}

# run each file in a folder
crundir() {
  if [ -d "$1" ]; then
    for f in "$1"/*; do
      test -x "$f" && "$f"
    done
    unset f
  fi
}

# add .custom/bin to PATH
caddpath "$CUSTOMPREFIX/bin"
