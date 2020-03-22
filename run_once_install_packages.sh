#!/usr/bin/env bash
# Author: ljak
# Creation Date: 2020_03_13

# Description: 

# Run: 

# set -o errexit  # make script exits when a command fails
set -o pipefail # exit status of the last command that threw a non-zero exit code is returned
# set -o xtrace  # for debugging


# Set up git profil
# ssh keys, github, gitlab, ...
# 


# Install packages that does not require additional commands
packages_wo_addcomms="
curl
htop
wget
xclip
firefox
ca-certificates
apt-transport-https
software-properties-common
"
sudo apt install -y ${packages_wo_addcomms}


# Install packages that require additional commands

# zsh
sudo apt install -y zsh
chsh -s /bin/zsh  # set default shell

# tilix
sudo apt install -y tilix dconf-editor
# set up personnal settings with dconf
# sudo update-alternatives --config x-terminal-emulator

# pet  # choose where download file and delete
wget https://github.com/knqyf263/pet/releases/download/v0.3.0/pet_0.3.0_linux_amd64.deb
sudo dpkg -i pet_0.3.0_linux_amd64.deb
# gist ?

# Sublime Text and Sublime Merge
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update -y
sudo apt install -y sublime-text sublime-merge
 # Next commands are necessary to set up my personnal settings
subl  # start sublime to create .config/ inside home
sudo wget -P "/home/ljak/.config/sublime-text-3/Installed Packages" https://packagecontrol.io/Package%20Control.sublime-package
cd ~/.config/sublime-text-3/Packages/User/
git init .
git remote add origin https://github.com/ljak/STBackup
git pull origin master
cd
 # Make sublime default editor in terminal and as app (visual)
EDITOR=subl; export EDITOR
VISUAL="$EDITOR"; export VISUAL

# Micro
# Choose where to download and place the .micro
curl https://getmic.ro | bash  # run with ./micro

# Python
sudo add-apt-repository ppa:deadsnakes/ppa
sudo add-apt-repository universe
sudo apt update -y
sudo apt install -y python3 python3-pip 
pip3 install bpython

# Docker ???
# Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.40/containers/json?limit=1: dial unix /var/run/docker.sock: connect: permission denied
# voir autre fichier aussi
# sudo apt install -y docker
# sudo systemctl start docker
# sudo systemctl enable docker


# Install packages that does not use apt
# sudo snap install pycharm-community --classic
# personnal settings from repo with gist