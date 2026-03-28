# Login environment vars.
#

# locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# static GPG home
export GNUPGHOME="$HOME/.gnupg"

# additional user-defined binary paths
test -d "$HOME/bin" && caddpath "$HOME/bin"
#... xdg bin path is also set (see pref/xdg.sh)

# editor
export EDITOR=nvim
export VISUAL=$EDITOR

# pager
export PAGER=less
export LESS='-R'

# git stuff
export GIT_PAGER=$PAGER
export GIT_EDITOR=$EDITOR

# man stuff
export MANPAGER=$PAGER
export MANPATH
test -z "$MANPATH" && MANPATH=$(manpath)
