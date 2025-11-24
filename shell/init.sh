if [ -n "$DOTFILES" ]; then
  . "$DOTFILES/shell/env.sh"
  . "$DOTFILES/shell/prompt.sh"
  . "$DOTFILES/shell/alias.sh"
fi
