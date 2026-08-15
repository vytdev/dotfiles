# For login.
#

# locale
# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8

# static GPG home
export GNUPGHOME="$HOME/.gnupg"

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

# xdg stuff
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIRS="/etc/xdg"

export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

# export XDG_SESSION_TYPE=wayland
# export XDG_SESSION_DESKTOP=Hyprland
# export XDG_CURRENT_DESKTOP=Hyprland

# add a path to PATH, prevent duplicates
caddpath() {
  case ":$PATH:" in
    *:"$1":*) ;;          # skip if already there
    '::') PATH="$1" ;;    # don't add a colon if it's empty
    *) PATH="$1:$PATH" ;; # prepend to PATH
  esac
}

caddpath "$HOME/.local/bin"

# additional user-defined binary paths
test -d "$HOME/bin" && caddpath "$HOME/bin"
