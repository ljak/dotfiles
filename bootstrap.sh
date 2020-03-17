#!/usr/bin/env bash
# Author: ljak
# Creation Date: 2020_03_16

# Description: Script that I'm using to bootstrap any new Debian-based Linux system. Its applies last updates, sets keyboard layouts to BÉPO (dvorak similar layout optimized for French language) and US, install git and chezmoi. Finaly, chezmoi will take care to execute the next scripts to ensure the bootstrapping procedure.

# Run: Execute command `./bootstrap.sh`

sudo apt update -y
sudo apt upgrade -y

source set_kb_layouts.sh

sudo apt install -y git

sudo snap install chezmoi --classic