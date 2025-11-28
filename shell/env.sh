# Setup shell and env vars

set +e

# locale
export LANG=en_US.UTF-8

# paths
export PATH="$DOTFILES/bin:$HOME/.local/bin:$PATH"
if [ -z "$MANPATH" ]; then
  export MANPATH="$HOME/.local/man:$HOME/.local/share/man:$(manpath)"
fi

# command history
HISTSIZE=5000
HISTFILESIZE=10000
HISTCONTROL=ignoredups:erasedups
HISTIGNORE='ls:cd:pwd:exit:clear'
shopt -s histappend

# setup gnupg
export GPG_TTY=$(tty)
export GNUPGHOME="$HOME/.gnupg"

# editor and pager
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

# git editor and pager
export GIT_EDITOR=nvim
export GIT_PAGER=less

# other opts
export LESS='-R'  # show colors in `less`
eval "$(dircolors -b)"
