# Setting up a local development environment


## Software installation
*  XCode

    ```sh
    xcode-select --install
    ```

*  Rosetta

    ```sh
    softwareupdate --install-rosetta
    ```

* Homebrew

     ```sh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
* Homebrew Applications
     ```sh
    brew bundle --file homebrew/Brewfile
    ```

* App Store Applications

    At first sign into the Mac App Store app manually.

    ```sh
    cut -d' ' -f1 appstore/Masfile | xargs mas install
    ```

* Other Applications

  * 1pass

    ```sh
    mkdir -p ~/bin
    curl https://raw.githubusercontent.com/dcreemer/1pass/master/1pass > ~/bin/1pass
    chmod a+x ~/bin/1pass
    ```

## Home directory setup
```sh
mkdir -p ~/.ssh
mkdir -p ~/projects

sudo vi /etc/synthetic.conf
```
write the following to the file:
```sh
projects        ~/projects
```

## iTerm2 setup

```sh
rm ~/Library/Preferences/com.googlecode.iterm2.plist
ln -h iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

touch ~/.hushlogin
```

## VSCode setup

```sh
mkdir -p ~/Library/Application\ Support/Code/User/
ln -h vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

cat vscode/VSCodefile | xargs -n1 code --install-extension
```

## ASDF setup
```sh
cat asdf/.tool-plugins | xargs -n2 asdf plugin add
cut -d' ' -f1 asdf/.tool-plugins | xargs -I{} asdf install {} latest
ln -h asdf/.tool-versions ~/.tool-versions
```

## Direnv setup
```sh
mkdir -p ~/.config/direnv 
ln -h direnv/direnvrc ~/.config/direnv/direnvrc
```

## ZSH setup
```sh
ln -h zsh/.zshrc ~/.zshrc
```

## MacOS setup
```sh
source macos/setup.sh
```
