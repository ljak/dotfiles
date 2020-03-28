#!/usr/bin/env bash
# Author: ljak
# Creation Date: 2019_11_26

# Description: Sets keyboard layouts to BÉPO (dvorak similar layout optimized for French language) and US through Debian xkb config file and GNOME GSetting variables.

# Run: Execute command `./set_kb_layouts.sh`

# Hint: There is a terminal configuration tool if needed: `sudo dpkg-reconfigure keyboard-configuration`


set -o pipefail  # script failed when one command of a pipe failed


get_current_desktop_env () {
	local desktop=${XDG_CURRENT_DESKTOP}
	if [ "${desktop}" = "" ]; then
		desktop=$(echo ${XDG_DATA_DIRS} | sed -rn 's/.*(xfce|kde|gnome).*/\1/')
	fi
	echo ${desktop,,}  #  convert to lowercase
}


set_keyboard_layouts () {
	local layouts='fr,us'
	local variant='bepo,'
	local options='grp:rctrl_toggle,terminate:ctrl_alt_bksp,grp_led:scroll'

	# set xkb config file
	local debian_kb_settings_filepath=/etc/default/keyboard
	if [ ! -f "${debian_kb_settings_filepath}" ]; then
		echo 'ERROR from set_kb_layouts.sh: file '${debian_kb_settings_filepath}' does not exist'
		exit 1
	fi
	sudo sed -i 's/XKBLAYOUT=.*$/XKBLAYOUT="'${layouts}'"/g' ${debian_kb_settings_filepath}
	sudo sed -i 's/XKBVARIANT=.*$/XKBVARIANT="'${variant}'"/g' ${debian_kb_settings_filepath}
	sudo sed -i 's/XKBOPTIONS=.*$/XKBOPTIONS="'${options}'"/g' ${debian_kb_settings_filepath}
	echo 'XKB config file '${debian_kb_settings_filepath}' SETTED.'

	# set GNOME GSetting variables if needed
	local current_desktop_env=$(get_current_desktop_env)
	if [[ ${current_desktop_env} = *"gnome"* ]]; then
		sudo gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'fr+bepo'), ('xkb', 'us')]"
		sudo gsettings set org.gnome.desktop.input-sources xkb-options "['${options}']"
		echo 'GNOME Gsetting org.gnome.desktop.input-sources SETTED.'
	fi
}


set_keyboard_layouts