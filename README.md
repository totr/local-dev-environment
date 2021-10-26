# Setting up a local development environment


## Software installation
*  XCode

    ```zsh
    xcode-select --install
    ```
* Homebrew

     ```zsh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
* Homebrew Applications
     ```zsh
    brew bundle --file homebrew/Brewfile
    ```

* App Store Applications

    At first sign into the Mac App Store app manually.

    ```zsh
    cut -d' ' -f1 appstore/Masfile | xargs mas install
    ```

* Other Applications

  * 1pass

    ```zsh
    curl https://raw.githubusercontent.com/dcreemer/1pass/master/1pass > /usr/local/bin/1pass
    chmod a+x /usr/local/bin/1pass
    ```



## iTerm2 setup

```zsh
mkdir -p ~/.iterm && cp iterm2/com.googlecode.iterm2.plist ~/.iterm
```

## ZSH setup
```zsh
cp zsh/.zshrc ~/.zshrc
```

## ASDF setup
```zsh
cat asdf/.tool-plugins | xargs -n2 asdf plugin add
cut -d' ' -f1 asdf/.tool-plugins | xargs I{} asdf install {} latest
cp asdf/.tool-versions ~/.tool-versions
```

## MacOS setup
```sh
source macos/setup.sh
```