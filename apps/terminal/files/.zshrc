eval "$(sheldon source)"

# Direnv
export DIRENV_LOG_FORMAT=""
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

# Krew
export PATH="${PATH}:${HOME}/.krew/bin"

# Aliases
alias sed=gsed
alias kubectl="kubecolor"
alias watch='watch '
alias kube='k3d cluster'
alias kn='switch namespace'
alias kc='switch --config-path $CONTEXT_DIR/env/kubeconfig/switch-config.yaml'
alias kch='switch history --config-path $CONTEXT_DIR/env/kubeconfig/switch-config.yaml'
alias kcv='switch -c'

# Common functions
kcal() {
  switch alias --config-path $CONTEXT_DIR/env/kubeconfig/switch-config.yaml $1=.
}

gaf() {
  git commit --amend --no-edit && git push -f
}

p() {
  cd /projects/$1
}

