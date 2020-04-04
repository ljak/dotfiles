#!/usr/bin/env bash
# Author: ljak
# Creation Date: 2020_03_16

# Description: Script that I'm using to bootstrap any new Debian-based Linux system. Its sets keyboard layouts to BÉPO (dvorak similar layout optimized for French language) and US, applies last updates and install git, chezmoi and bitwarden. After what, chezmoi takes care of the rest of the bootstrapping procedure.

# Run: Execute command `./bootstrap.sh`


source set_kb_layouts.sh

sudo apt update -y
sudo apt upgrade -y

sudo apt install -y git snapd
sudo snap install chezmoi --classic
sudo snap install bw  # bitwarden

bw login

chezmoi init https://github.com/ljak/dotfiles.git
# chezmoi apply

# git remote set-url origin git@github.com:ljak/dotfiles.git could be needed later
