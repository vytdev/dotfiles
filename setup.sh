#!/bin/sh

trgdir="$HOME"
dotfiles="$(realpath "$(dirname "$0")")"
[ -n "$1" ] && trgdir="$1"

# ask yes or no. returns 0 if yes, 1 if not yes.
# yes is the default val (when nothing is entered).
ask_yes() {
  read ans
  case "$ans" in
    [yY]*|'') return 0;;
    *)        return 1;;
  esac
}

# $1: src from this repo
# $2: dest relative to target dir
make_link() {
  trg="$trgdir/$2"
  mkdir -p "$(dirname "$trg")"

  if [ -e "$trg" ]; then
    printf "%s already exists. replace? [y]: " "$2"
    ask_yes || return
  fi

  echo "$1 -> $2"
  rm -rf "$trg"
  ln -s "$dotfiles/$1" "$trg"
}

echo "vytdev's personal dev environment setup."
echo "tip: you can specify the target directory"
echo "usage: $0 [target]"
echo
echo "will populate configs to: $trgdir"
printf "is this correct? [y]: "
ask_yes || exit
echo

# copy necessary files
make_link 'config/gitconfig'    '.gitconfig'
make_link 'config/bashrc'       '.bashrc'
make_link 'config/bash_profile' '.bash_profile'
echo

# nvim config (imma use nvchad)
printf "update nvim config? [y]: "
if ask_yes; then
  rm -rf "$dotfiles/.config/nvim"
  rm -rf "$dotfiles/.local/share/nvim"
  rm -rf "$dotfiles/.local/state/nvim"
  make_link 'nvim' '.config/nvim'
fi
echo

# py-venv (for quick scripting)
if command -v python >/dev/null 2>&1; then
  printf "setup a global py-venv? [y]: "
  if ask_yes; then
    python -m venv "$trgdir/py-venv"
    echo "global py-venv setup done"
  fi
  echo
fi

echo "setup done!"
