#!/bin/sh

dotfiles="$(realpath "$(dirname "$0")")"

# $1: src from this repo
# $2: dest relative to user's home
make_link() {
  trg="$HOME/$2"
  mkdir -p "$(dirname "$trg")"
  rm -rf "$trg"
  ln -s "$dotfiles/$1" "$trg"
}

make_link 'config/gitconfig'    '.gitconfig'
make_link 'config/bashrc'       '.bashrc'
make_link 'config/bash_profile' '.bash_profile'
make_link 'nvim'                '.config/nvim'
