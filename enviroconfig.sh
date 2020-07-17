#!/bin/sh
# Script for setting up basic terminal functionalities
sudo apt install neovim trash-cli

# Installing Fuzzyfind
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Downloading and installing nnn's release
wget https://github.com/jarun/nnn/releases/download/v3.3/nnn_3.3-1_ubuntu20.04.amd64.deb
sudo apt install -f ./nnn_3.3-1_ubuntu20.04.amd64.deb

# Creating XDG_CONFIG_HOME if missing
[ -d $HOME/.config ] || mkdir $HOME/.config

# Configuring neovim
[ -d $HOME/.config/nvim ] || mkdir $HOME/.config/nvim
cp init.vim $HOME/.config/nvim/

# Helper func
echo 'source_if_exists() {' >> $HOME/.bashrc
echo '    [ -f "$1" ] && . "$1"' >> $HOME/.bashrc
echo '}' >> $HOME/.bashrc

[ -d $HOME/.config/nnn ] || mkdir -p $HOME/.config/nnn/misc/
cp quitcd.sh $HOME/.config/nnn/misc/
echo 'source_if_exists "$HOME/.config/nnn/misc/quitcd.sh"' >> $HOME/.bashrc

# Setting basic aliases and environment variables
cp .{environment,aliases} $HOME/
echo 'source_if_exists "$HOME/.environment"' >> $HOME/.bashrc
echo 'source_if_exists "$HOME/.aliases"' >> $HOME/.bashrc
source $HOME/.bashrc
