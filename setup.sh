#!/bin/sh

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing Kitty..."
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

echo "Run brew bundle"
brew bundle

echo "Symlink stuffs"
