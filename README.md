# Setting up a local development environment

Provisioning of a local MacOS environment using the [Comtrya](https://comtrya.dev) tool.

## Bootstrap

### XCode
```sh
xcode-select --install
/usr/sbin/softwareupdate --install-rosetta --agree-to-license
```

### Homebrew
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Comtrya
```sh
curl -fsSL https://get.comtrya.dev | sh
sudo mkdir -p /usr/local/bin
sudo cp comtrya-aarch64-apple-darwin /usr/local/bin/comtrya
```

## Provisioning of all packages
```sh
git clone https://github.com/totr/local-dev-environment.git
cd local-dev-environment
comtrya apply
```
