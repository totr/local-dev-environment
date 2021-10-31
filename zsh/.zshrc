# Zinit activation
source $(brew --prefix)/opt/zinit/zinit.zsh

# ASDF + Direnv activation
zinit ice wait lucid
zinit load redxtech/zsh-asdf-direnv

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

# wfxr/forgit
zinit ice wait lucid
zinit load 'wfxr/forgit'

# fast-syntax-highlighting
zinit ice wait"5" atinit"zpcompinit; zpcdreplay" lucid
zinit light zdharma-continuum/fast-syntax-highlighting

# zsh-autosuggestions
zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit load zsh-users/zsh-autosuggestions

# ASDF Java plugin
. ~/.asdf/plugins/java/set-java-home.zsh

# dandavision/delta
zinit ice as"command" from"gh-r" mv"delta* -> delta" pick"delta/delta" atclone'curl -Lo _delta https://raw.githubusercontent.com/dandavison/delta/master/etc/completion/completion.zsh' atpull'%atclone'
zinit light dandavison/delta
# Configure as default git diff renderer
git config --global core.pager "delta --dark"

zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh

alias watch='watch '
alias kn='kubens'
alias kc='kubectx'

gaf () {
  git commit --amend --no-edit && git push -f
}

p () {
  cd /projects/$1
}

pass () {    
  local item
  item=$(1pass | fzf --exact --layout reverse --prompt="Password for > ");
  if [ -n "$1" ] && [ $1 = "OUTPUT" ]; then
    [[ -n "$item" ]] && 1pass -p "$item" "password"
  else
    [[ -n "$item" ]] && 1pass "$item" "password"
  fi
}