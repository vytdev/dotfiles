# Login environment vars.
#

# locale
export LANG=en_US.UTF-8

# static GPG home
export GNUPGHOME="$HOME/.gnupg"

# additional user-defined binary paths
[ -d "$HOME/bin" ] && caddpath "$HOME/bin"
#... xdg bin path is also set (see pref/xdg.sh)

# editor and pager
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

# git editor and pager
export GIT_EDITOR="$EDITOR"
export GIT_PAGER="$PAGER"

# less options
export LESS='-R'
