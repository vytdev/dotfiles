# Node Version Manager
#

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] &&
  printf %s "${HOME}/.nvm" ||
  printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

nvm-manager-update() {
  (
    cd "$NVM_DIR" || exit 1
    git fetch --tags origin
    commit=$(git rev-list --tags --max-count=1)
    tag=$(git describe --abbrev=0 --tags --match 'v[0-9]*' "$commit")
    git checkout "$tag"
  ) && . "$NVM_DIR/nvm.sh"
}

nvm-manager-install() {
  (
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    commit=$(git rev-list --tags --max-count=1)
    tag=$(git describe --abbrev=0 --tags --match 'v[0-9]*' "$commit")
    git checkout "$tag"
  ) && . "$NVM_DIR/nvm.sh"
}
