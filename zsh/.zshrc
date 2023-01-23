# Zinit activation
source $(brew --prefix)/opt/zinit/zinit.zsh

# ASDF + Direnv activation
zinit ice wait lucid
zinit load redxtech/zsh-asdf-direnv
export DIRENV_LOG_FORMAT=""

# Load starship theme
 zinit ice lucid from"gh-r" \
   as"command" pick"starship" \
   atload"!eval \$(starship init zsh)"
 zinit light starship/starship

# sharkdp/fd
zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

# sharkdp/bat
zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

# ogham/exa, replacement for ls
zinit ice as"program" from"gh-r" mv"exa* -> exa" pick"exa/exa" lucid atload"alias ls='exa --icons'"
zinit light ogham/exa

# fast-syntax-highlighting
zinit ice wait"5" atinit"zpcompinit; zpcdreplay" lucid
zinit light zdharma-continuum/fast-syntax-highlighting

# zsh-autosuggestions
zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit load zsh-users/zsh-autosuggestions

# ASDF Java plugin
#. ~/.asdf/plugins/java/set-java-home.zsh

# dandavision/delta
zinit ice as"command" from"gh-r" mv"delta* -> delta" pick"delta/delta" atclone'curl -Lo _delta https://raw.githubusercontent.com/dandavison/delta/master/etc/completion/completion.zsh' atpull'%atclone'
zinit light dandavison/delta
# Configure as default git diff renderer
git config --global core.pager "delta --dark"

zinit ice silent wait"0"
zinit snippet ~/.asdf/plugins/java/set-java-home.zsh

zinit ice silent wait"0"
zinit snippet OMZ::plugins/git/git.plugin.zsh

zinit ice silent wait"0"
zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh

zinit ice silent wait"0"
zinit light pabloariasal/zfm

# wfxr/forgit
zinit ice wait lucid
zinit load 'wfxr/forgit'

alias watch='watch '
alias kn='kubens'
alias kc='kubectx'
alias ls='exa -la'
alias oc='code $(zfm select --multi) -n'
alias kubeusage_report="/projects/tt/k8s-day2-ops/resource_calcuation/k8s-resource-reporter/usage.sh"
alias kubeusage="python3 /projects/tt/k8s-day2-ops/resource_calcuation/k8s-toppur/k8s-toppur.py"
alias kubeallocation="/projects/tt/kubectl-view-allocations -g namespace"
alias kuberesources='echo "" && k8s_context && echo "\n\n=============================== RESOURCE ALLOCATION =============================== \n" && kubeallocation && echo "\n\n\n================================= RESOURCE USAGE ================================= \n" && kubeusage'
alias wireshark="/Applications/Wireshark.app/Contents/MacOS/Wireshark"
alias pass="1p choose"

export PATH=$PATH:~/bin
export PATH="${PATH}:${HOME}/.krew/bin"

gaf() {
  git commit --amend --no-edit && git push -f
}

p() {
  cd /projects/$1
}

k8s_context() {
 kubectl config view -o json | jq -r '."current-context"'
}

fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac --layout reverse | sed -r 's/ *[0-9]*\*? *//' | sed -r 's/\\/\\\\/g')
}

gbf() {                                 
  result=$(git branch -a --color=always | grep -v '/HEAD\s' | sort |
    fzf --layout reverse --height 60%  --ansi --tac --preview-window right:70% \
      --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %cn %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
    sed 's/^..//' | cut -d' ' -f1)

  if [[ $result != "" ]]; then
    if [[ $result == remotes/* ]]; then
      git checkout --track $(echo $result | sed 's#remotes/##')
    else
      git checkout "$result"
    fi
  fi
}
