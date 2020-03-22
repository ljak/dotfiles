#!/usr/bin/env bash
# Author: ljak
# Creation Date: 2020_03_16

# Description: Script that I'm using to bootstrap any new Debian-based Linux system. Its applies last updates, sets keyboard layouts to BÉPO (dvorak similar layout optimized for French language) and US, install git and chezmoi. Next, chezmoi take care of the bootstrapping procedure to the end.

# Run: Execute command `./bootstrap.sh`


source set_kb_layouts.sh

sudo apt update -y
sudo apt upgrade -y

sudo apt install -y git snapd
sudo snap install chezmoi --classic

chezmoi init https://github.com/ljak/dotfiles.git
# chezmoi apply
