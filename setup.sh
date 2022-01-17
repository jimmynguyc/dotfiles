#!/bin/sh

echo "Symlink stuffs"
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
mkdir -p ~/.config
ln -s ~/dotfiles/.config/nvim ~/.config/nvim

echo "Install oh-my-zsh & plugins"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/jimeh/zsh-peco-history.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-peco-history
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Run brew bundle"
brew bundle

echo "Install vim plugs"
nvim +PlugInstall +qa

echo "Install nvm"
[ ! -d "${HOME}/.nvm" ] && git clone https://github.com/nvm-sh/nvm.git ~/.nvm
nvm install --lts
npm install -g yarn

