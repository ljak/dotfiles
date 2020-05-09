#!/usr/bin/env bash
# Author: ljak
# Creation Date: 2019_11_26

# Description: Script that I'm using to bootstrap any new Debian-based Linux system. Its sets keyboard layouts to BÉPO (dvorak similar layout optimized for French language) and US, applies last updates and install git, chezmoi and bitwarden. After what, chezmoi takes care of the rest of the bootstrapping procedure.

# Run: Execute command `./bootstrap.sh`


set -o errexit  # make script exits when a command fails
set -o pipefail  # script failed when one command of a pipe failed


get_current_desktop_env () {
	local desktop=${XDG_CURRENT_DESKTOP}
	if [ "${desktop}" = "" ]; then
		desktop=$(echo ${XDG_DATA_DIRS} | sed -rn 's/.*(xfce|kde|gnome).*/\1/')
	fi
	echo ${desktop,,}  #  convert to lowercase
}

# Hint: There is a terminal configuration tool if needed: `sudo dpkg-reconfigure keyboard-configuration`
set_keyboard_layouts () {
	local layouts='fr,us'
	local variant='bepo,'
	local options='grp:rctrl_toggle,terminate:ctrl_alt_bksp,grp_led:scroll'

	# set xkb config file
	local debian_kb_settings_filepath=/etc/default/keyboard
	if [ ! -f "${debian_kb_settings_filepath}" ]; then
		echo 'ERROR from boostrap.sh: file '${debian_kb_settings_filepath}' does not exist'
		exit 1
	fi
	sudo sed -i 's/XKBLAYOUT=.*$/XKBLAYOUT="'${layouts}'"/g' ${debian_kb_settings_filepath}
	sudo sed -i 's/XKBVARIANT=.*$/XKBVARIANT="'${variant}'"/g' ${debian_kb_settings_filepath}
	sudo sed -i 's/XKBOPTIONS=.*$/XKBOPTIONS="'${options}'"/g' ${debian_kb_settings_filepath}
	echo 'XKB config file '${debian_kb_settings_filepath}' SETTED.'

	# set GNOME GSetting variables if needed
	local current_desktop_env=$(get_current_desktop_env)
	if [[ ${current_desktop_env} = *"gnome"* ]]; then
		gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'fr+bepo'), ('xkb', 'us')]"
		gsettings set org.gnome.desktop.input-sources xkb-options "['${options}']"
		echo 'GNOME Gsetting org.gnome.desktop.input-sources SETTED.'
	fi
}


set_keyboard_layouts

sudo apt update -y
sudo apt upgrade -y

sudo apt install -y git snapd
export PATH="$PATH:/snap/bin"
sudo snap install chezmoi --classic
sudo snap install bw  # bitwarden

bw login

chezmoi init https://github.com/ljak/dotfiles.git
# git remote set-url origin git@github.com:ljak/dotfiles.git to set repo with ssh later
chezmoi apply

echo 'Set your default shell with command : `chsh -s /bin/zsh`'
