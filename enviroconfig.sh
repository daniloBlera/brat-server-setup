#!/bin/sh
# Script for setting up basic terminal functionalities
sudo apt install neovim trash-cli wget

# Installing Fuzzyfind
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Downloading and installing nnn's release -- Uncomment the right one for your instance
## Ubuntu 20.04 -- for local ubuntu 20.04 instances
# DEB_URL='https://github.com/jarun/nnn/releases/download/v3.3/nnn_3.3-1_ubuntu20.04.amd64.deb'
## Debian 10 -- for gcp debian 10 instances
DEB_URL='https://github.com/jarun/nnn/releases/download/v3.3/nnn_3.3-1_debian10.amd64.deb'

wget "$DEB_URL" -O nnn.deb
sudo apt install -f ./nnn.deb

# Creating XDG_CONFIG_HOME if missing
[ -d "$HOME/.config" ] || mkdir "$HOME/.config"

# Configuring neovim
[ -d "$HOME/.config/nvim" ] || mkdir "$HOME/.config/nvim"
cp 'init.vim' "$HOME/.config/nvim/"

# Helper function to source files
cat << 'EOM' >> "$HOME/.bashrc"

source_if_exists() {
    [ -f "$1" ] && . "$1"
}

EOM

# Configuring nnn's cd on quit
NNN_MISC="$HOME/.config/nnn/misc"
[ -d "$NNN_MISC" ] || mkdir -p "$NNN_MISC"
cp 'quitcd.sh' "$NNN_MISC/"
echo 'source_if_exists "$HOME/.config/nnn/misc/quitcd.sh"' >> "$HOME/.bashrc"

# Setting basic aliases and environment variables
cp 'environment' "$HOME/.environment"
cp 'aliases' "$HOME/.aliases"
echo 'source_if_exists "$HOME/.environment"' >> "$HOME/.bashrc"
echo 'source_if_exists "$HOME/.aliases"' >> "$HOME/.bashrc"
