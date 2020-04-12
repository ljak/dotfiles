#!/usr/bin/env bash
# Author: ljak
# Creation Date: 2020_03_13

# Description:

# Run: Should be started by chezmoi when chezmoi init repo


set -o pipefail  # script failed when one command of a pipe failed


# Install packages that does not require additional commands
packages_wo_addcomms="
jq
vlc
zsh
curl
htop
tree
wget
xclip
firefox
net-tools
dconf-editor
ca-certificates
apt-transport-https
software-properties-common
"
sudo apt install -y ${packages_wo_addcomms}


# Install packages that require additional commands

# tilix
sudo apt install -y tilix
sudo update-alternatives --set x-terminal-emulator /usr/bin/tilix.wrapper  # set tilix as default terminal
# set up personnal settings with dconf
# dconf dump /com/gexperts/Tilix/ > tilix.dconf
# dconf load /com/gexperts/Tilix/ < tilix.dconf

# pet
wget https://github.com/knqyf263/pet/releases/download/v0.3.0/pet_0.3.0_linux_amd64.deb && sudo dpkg -i pet_0.3.0_linux_amd64.deb && sudo rm pet_0.3.0_linux_amd64.deb

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
# curl https://getmic.ro | bash  # run with ./micro

# Python
# sudo add-apt-repository -y ppa:deadsnakes/ppa  # to get the latest python possible
sudo add-apt-repository -y universe
sudo apt update -y
sudo apt install -y python3 python3-pip 
pip3 install bpython
pip3 install virtualenvwrapper

# Docker
sudo apt install -y docker.io  # docker.io simplier than docker-ce
sudo systemctl start docker
sudo systemctl enable docker
if ! grep -q docker /etc/group
then
  sudo groupadd docker
fi
sudo usermod -aG docker $USER  # `id -nG` to check if ${user} is present in docker group

# Docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# uGet
sudo add-apt-repository -y ppa:plushuang-tw/uget-stable
sudo apt update -y
sudo apt install -y uget

# neofetch
sudo add-apt-repository -y ppa:dawidd0811/neofetch
sudo apt update -y
sudo apt install -y neofetch

# cleaning apt
sudo apt autoremove


# Install packages that does not use apt
# sudo snap install pycharm-community --classic
# personnal settings from repo with gist
# sudo snap install skype --classic
# sudo snap install spotify