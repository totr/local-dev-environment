eval "$(sheldon source)"

# ASDF path
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Direnv
export DIRENV_LOG_FORMAT=""
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

# Krew
export PATH="${PATH}:${HOME}/.krew/bin"

# Aliases
alias sed=gsed
alias kn='kubens'
alias kc='kubectx'
alias watch='watch '
alias kube='k3d cluster'

# Common functions
gaf() {
  git commit --amend --no-edit && git push -f
}

p() {
  cd /projects/$1
}

kcname() {
  kubectl config view -o json | jq -r '."current-context"'
}