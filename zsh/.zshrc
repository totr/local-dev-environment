# Load starship theme
zinit ice as"command" from"gh-r" \ # `starship` binary as command, from github release
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \ # starship setup at clone(create init.zsh, completion)
          atpull"%atclone" src"init.zsh" # pull behavior same as clone, source init.zsh
zinit light starship/starship

# Direnv - https://zdharma.github.io/zinit/wiki/Direnv-explanation/
zinit as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' \
    atpull'%atclone' pick"direnv" src"zhook.zsh" for \
        direnv/direnv

# sharkdp/fd
zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

# sharkdp/bat
zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

# wfxr/forgit
zinit ice wait lucid
zinit load 'wfxr/forgit'

# Autosuggestions & fast-syntax-highlighting
zinit ice wait lucid atinit"ZPLGM[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

# zsh-autosuggestions
zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit load zsh-users/zsh-autosuggestions

# ASDF Java plugin
. ~/.asdf/plugins/java/set-java-home.zsh

p () {
  cd /work/projects/$1
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