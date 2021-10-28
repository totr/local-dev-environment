# System Preferences > Trackpad > Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# View Hidden Files in Terminal
defaults write com.apple.Finder AppleShowAllFiles -bool true

#Hide the MacOS Dock instantly
defaults write com.apple.dock autohide-delay -float 0 && defaults write com.apple.dock autohide-time-modifier -float 0.4 && killall Dock