# Login shells
#

# locale
export LANG=en_US.UTF-8

# static GPG home
export GNUPGHOME="$HOME/.gnupg"

# additional user-defined binary paths
[ -d "$HOME/bin" ]        && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

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
[ -f ~/.custom/pref/motd.sh ] && . ~/.custom/pref/motd.sh
