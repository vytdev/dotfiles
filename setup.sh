#!/bin/sh

base="$HOME"
dotfiles="$(realpath "$(dirname "$0")")"
[ -n "$1" ] && base=$(realpath "$1")

mkdir -p "$base/.config"

ln -s "$dotfiles/.bashrc"     "$base/.bashrc"
ln -s "$dotfiles/.gitconfig"  "$base/.gitconfig"
ln -s "$dotfiles/nvim" 	      "$base/.config/nvim"
