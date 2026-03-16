# login setup
[ -f ~/.custom/login.sh ] && . ~/.custom/login.sh

# if running bash
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi
