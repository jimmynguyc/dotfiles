#!/bin/sh

underline=`tput smul`
nounderline=`tput rmul`
bold=`tput bold`
normal=`tput sgr0`

function title {
  echo "\n\n${bold}${underline}$1${nounderline}${normal}"
}

title "Install oh-my-zsh & plugins"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-peco-history ]; then
	git clone https://github.com/jimeh/zsh-peco-history.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-peco-history
else
	pushd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-peco-history && git pull && popd
fi

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
	pushd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && git pull && popd
fi

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z ]; then
	git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
else
	pushd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z && git pull && popd
fi

title "Install Homebrew"
if [ ! $(which brew) &> /dev/null ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Already installed"
fi

title "Run brew bundle"
brew bundle

title "Install nvm & yarn"
NVM_DIR=$HOME/.nvm
[ ! -d "$NVM_DIR" ] && git clone https://github.com/nvm-sh/nvm.git ~/.nvm
\. "$NVM_DIR/nvm.sh"
nvm install --lts
npm install -g yarn

title "Run dotbot"
\. ./install
