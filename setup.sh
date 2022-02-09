#!/bin/sh

echo "Install oh-my-zsh & plugins"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/jimeh/zsh-peco-history.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-peco-history
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Run brew bundle"
brew bundle

echo "Install vim plugs"
nvim +PlugInstall +qa

echo "Install nvm"
NVM_DIR=$HOME/.nvm
[ ! -d "$NVM_DIR" ] && git clone https://github.com/nvm-sh/nvm.git ~/.nvm
\. "$NVM_DIR/nvm.sh"
nvm install --lts
npm install -g yarn

