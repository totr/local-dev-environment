# Mise
eval "$(mise activate zsh)"

# Zsh-defer
source ~/.zsh-plugins/zsh-defer.zsh

zsh-defer source $HOMEBREW_PREFIX/share/forgit/forgit.plugin.zsh
zsh-defer source ~/.zsh-plugins/kubectl.zsh
zsh-defer eval "$(switcher init zsh)"

# Krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Aliases
alias c=cd
alias sed=gsed
alias l='nnn -de'
alias kubectl="kubecolor"
alias watch='watch '
alias kube='k3d cluster'
alias kn='switch namespace'
alias kc='switch --config-path $PROJECT_NAME/env/kubeconfig/switch-config.yaml'
alias kch='switch history --config-path $PROJECT_NAME/env/kubeconfig/switch-config.yaml'
alias mr='mise run'
alias kkp='k klock pod'
alias kkpa='k klock pod -A'

# Common functions
kcal() {
  switch alias --config-path $PROJECT_NAME/env/kubeconfig/switch-config.yaml $1=.
}

tpl() {
  export FZF_DEFAULT_COMMAND="kubecolor get pods --all-namespaces --force-colors=256"
  fzf --info=inline --layout=reverse --header-lines=1 \
   --prompt "$(print -P -- "%K{green}%B $(tc) %b%k") > " \
   --header $'>> ENTER (open log) || CTRL-r (refresh) || CTRL-/ (change view) <<\n' \
   --ansi \
   --bind 'ctrl-/:change-preview-window(50%|80%)' \
   --bind 'enter:execute: (kubecolor logs --all-containers --follow --namespace {1} {2})' \
   --bind 'ctrl-r:reload:kubecolor get pods --all-namespaces --force-colors=256' \
   --preview-window up:follow,80%,wrap \
   --preview 'kubecolor logs --follow --all-containers --tail=200 --namespace {1} {2} --force-colors=256' "$@" 
}

teg() {
  export FZF_DEFAULT_COMMAND="kubecolor get event --all-namespaces --force-colors=256"
  fzf --info=inline --header-lines=1 --layout=reverse \
    --prompt "$(print -P -- "%K{green}%B $(tc) %b%k") > " \
    --header $'>> CTRL+r (refresh) || Sort by .. CTRL+k (first time) || CTRL+l (last time)  <<\n' \
    --ansi \
    --bind 'enter:accept' \
    --bind 'ctrl-r:reload:kubecolor get event --all-namespaces --force-colors=256' \
    --bind 'ctrl-l:reload:kubecolor get event --all-namespaces --sort-by=".lastTimestamp" --force-colors=256' \
    --bind 'ctrl-k:reload:kubecolor get event --all-namespaces --sort-by=".firstTimestamp" --force-colors=256'
}

tnd() {
  export FZF_DEFAULT_COMMAND='kubecolor get nodes --force-colors=256'
  fzf --layout=reverse --header-lines=1 --info=inline \
    --prompt "$(print -P -- "%K{green}%B $(tc) %b%k") > " \
    --header $'>> CTRL-r (refresh) || CTRL-/ (change view) <<\n' \
    --preview-window=right:50% \
    --ansi \
    --bind 'ctrl-/:change-preview-window(70%|40%|50%)' \
    --bind 'enter:execute: (kubecolor describe node {1} --force-colors=256) | less -RF' \
    --bind 'ctrl-r:reload:kubecolor get nodes --force-colors=256' \
    --preview 'kubecolor describe node {1} --force-colors=256'
}

tpd() {
  export FZF_DEFAULT_COMMAND='kubecolor get pods --all-namespaces -o custom-columns="NAMESPACE:metadata.namespace,NAME:metadata.name,STATUS:status.phase" --force-colors=256'
  fzf --layout=reverse --header-lines=1 --info=inline \
    --prompt "$(print -P -- "%K{green}%B $(tc) %b%k") > " \
    --header $'>> CTRL-r (refresh) || CTRL-/ (change view) <<\n' \
    --preview-window=right:50% \
    --ansi \
    --bind 'ctrl-/:change-preview-window(70%|40%|50%)' \
    --bind 'enter:execute: (kubecolor describe pod --namespace {1} {2} --force-colors=256) | less -RF' \
    --bind 'ctrl-r:reload:kubecolor get pods --all-namespaces -o custom-columns="NAMESPACE:metadata.namespace,NAME:metadata.name,STATUS:status.phase" --force-colors=256' \
    --preview 'kubecolor describe pod --namespace {1} {2} --force-colors=256'
}

tpg() {
  export FZF_DEFAULT_COMMAND='kubecolor get pods --all-namespaces -o custom-columns="NAMESPACE:metadata.namespace,NAME:metadata.name,STATUS:status.phase" --force-colors=256'
  fzf --layout=reverse --header-lines=1 --info=inline \
    --prompt "$(print -P -- "%K{green}%B $(tc) %b%k") > " \
    --header $'>> CTRL-r (refresh) || CTRL-/ (change view) <<\n' \
    --preview-window=right:50% \
    --ansi \
    --bind 'ctrl-/:change-preview-window(70%|40%|50%)' \
    --bind 'enter:execute: (kubecolor get pod --namespace {1} {2} -o yaml --force-colors=256) | less -RF' \
    --bind 'ctrl-r:reload:kubecolor get pods --all-namespaces -o custom-columns="NAMESPACE:metadata.namespace,NAME:metadata.name,STATUS:status.phase" --force-colors=256' \
    --preview 'kubecolor get pod --namespace {1} {2} -o yaml --force-colors=256'
}

tpe() {
   local containers
   local container
   kubecolor get pods --all-namespaces --force-colors=256 | fzf --layout=reverse --ansi --prompt "$(print -P -- "%K{green}%B $(tc) %b%k") > " | read -r namespace pod ready state restart age
   if [ ! -z "$pod" ]; then
   containers=$(kubectl get pod -n $namespace $pod -o jsonpath='{.spec.containers[*].name}')
   container=$(echo ${containers/ /\\n} | fzf)
   kubectl exec -n $namespace --stdin --tty $pod --container $container -- /bin/sh
   fi
}

tsf() {
   local ports
   local targetPort
   kubecolor get svc --all-namespaces --force-colors=256 | fzf --layout=reverse --ansi --prompt "$(print -P -- "%K{green}%B $(tc) %b%k") > " | read -r namespace svc type clusterIp externalIP ports age
   if [ ! -z "$svc" ]; then
   ports=$(kubectl get svc -n $namespace $svc -o jsonpath='{.spec.ports[*]}' | jq -r '(. |[.name, .port, .protocol]) | @tsv')
   targetPort=$(echo ${ports} | fzf | awk '{print $2}')
   if [[ "$targetPort" == 443 ]]; then
   print -P %F{magenta}https://localhost:7777
   else
   print -P %F{magenta}http://localhost:7777
   fi
   kubectl port-forward -n $namespace svc/$svc 7777:$targetPort
   fi
}

tsd() {
  export FZF_DEFAULT_COMMAND='kubecolor get svc --all-namespaces -o custom-columns="NAMESPACE:metadata.namespace,NAME:metadata.name,TYPE:spec.type" --force-colors=256'
  fzf --layout=reverse --header-lines=1 --info=inline \
    --prompt "$(print -P -- "%K{green}%B $(tc) %b%k") > " \
    --header $'>> CTRL-r (refresh) || CTRL-/ (change view) <<\n' \
    --preview-window=right:50% \
    --ansi \
    --bind 'ctrl-/:change-preview-window(70%|40%|50%)' \
    --bind 'enter:execute: (kubecolor describe svc --namespace {1} {2} --force-colors=256) | less -RF' \
    --bind 'ctrl-r:reload:kubecolor get svc --all-namespaces -o custom-columns="NAMESPACE:metadata.namespace,NAME:metadata.name,TYPE:spec.type" --force-colors=256' \
    --preview 'kubecolor describe svc --namespace {1} {2} --force-colors=256'
}

tsg() {
  export FZF_DEFAULT_COMMAND='kubecolor get svc --all-namespaces -o custom-columns="NAMESPACE:metadata.namespace,NAME:metadata.name,TYPE:spec.type" --force-colors=256'
  fzf --layout=reverse --header-lines=1 --info=inline \
    --prompt "$(print -P -- "%K{green}%B $(tc) %b%k") > " \
    --header $'>> CTRL-r (refresh) || CTRL-/ (change view) <<\n' \
    --preview-window=right:50% \
    --ansi \
    --bind 'ctrl-/:change-preview-window(70%|40%|50%)' \
    --bind 'enter:execute: (kubecolor get pod --namespace {1} {2} -o yaml --force-colors=256) | less -RF' \
    --bind 'ctrl-r:reload:kubecolor get svc --all-namespaces -o custom-columns="NAMESPACE:metadata.namespace,NAME:metadata.name,TYPE:spec.type" --force-colors=256' \
    --preview 'kubecolor get svc --namespace {1} {2} -o yaml --force-colors=256'
}

tc() {
  k8s_cluster=$(cat $KUBECONFIG | yq .kubeswitch-context)
  k8s_ns=$(kubectl config view --minify -o jsonpath='{..namespace}')
  print -P %F{green}${k8s_cluster} - ${k8s_ns:=default}
}

gaf() {
  git commit --amend --no-edit && git push -f
}

p() {
  proj=$(ls ~/projects | grep -v archived| fzf)
  cd ~/projects/$proj
  mr init 2> /dev/null
}
