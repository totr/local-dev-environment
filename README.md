# Setting up a local development environment

Provisioning of a local MacOS environment using the [Comtrya](https://github.com/comtrya/comtrya) tool.

## Bootstrap

Comtrya currently does not provide a distribution for _aarch64_, therefore a build with this architecture is available in this repository. For the current status of the provided Comtrya packages, see the [project pages](https://www.comtrya.dev/getting-started/installation).


```sh
# XCode
xcode-select --install
/usr/sbin/softwareupdate --install-rosetta --agree-to-license

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install openssl@3

# Comtrya
git clone https://github.com/totr/local-dev-environment.git
sudo mkdir -p /usr/local/bin
sudo cp local-dev-environment/bootstrap/comtrya_0.8.5 /usr/local/bin/comtrya
sudo chmod 755  /usr/local/bin/comtrya

```

## Provisioning of all packages

```sh
comtrya apply
```