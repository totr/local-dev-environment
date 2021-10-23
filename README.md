# Setting up a local development environment


## Software installation
* XCode
```
xcode-select --install
```
* Homebrew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
* Applications
```
brew bundle --file Brewfile
```

## ZSH setup
```
cp .zshrc ~/.zshrc
```

## ASDF setup
```
cut -d' ' -f1 .tool-plugins|xargs -i asdf plugin add  {}
cp .tool-versions ~/.tool-versions
```