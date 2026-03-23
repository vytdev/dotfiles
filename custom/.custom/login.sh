# Stuff ran on login. Not necessarily limited to shells. Preferrably
# source from ~/.profile . Do not assume an interactive shell.
#

test -r ~/.custom/mgr.sh && . ~/.custom/mgr.sh || return

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

# other login stuff
crun xdg

# Auto-start Hyprland?
#start-hyprland
