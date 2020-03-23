#!/usr/bin/env bash
# Author: ljak
# Creation Date: 2020_03_22

# Description:

# Run: Execute command `./setup_gnome.sh`


# GNOME Shell Extensions
sudo add-apt-repository universe
sudo apt update -y
sudo apt install -y gnome-tweak-tool gnome-shell-extensions chrome-gnome-shell
xdg-open https://addons.mozilla.org/en-US/firefox/addon/gnome-shell-integration/  # open link in default browser
# gnome-shell --version
xdg-open https://extensions.gnome.org/extension/1486/extensions-sync/  # setup with GIST ?
# More http://www.bernaerts-nicolas.fr/linux/76-gnome/345-gnome-shell-install-remove-extension-command-line-script

# + dconf ? copy .local/share/gnome-shell/extensions ?

# https://extensions.gnome.org/extension/1160/dash-to-panel/
# https://extensions.gnome.org/extension/517/caffeine/
# https://extensions.gnome.org/extension/53/pomodoro/
# https://extensions.gnome.org/extension/750/openweather/
# https://extensions.gnome.org/extension/19/user-themes/
# https://extensions.gnome.org/extension/906/sound-output-device-chooser/
# Configure Dash to Panel as follows: ... These settings can also be imported from the file configs/dash-to-panel


# ### GNOME Theme
# GTK Theme
sudo apt install -y materia-gtk-theme
# Next, into Tweak Tool, change to the wanted theme.

# Icons Theme: https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
# Recommanded Theme: Materia, Arc, Adapta
sudo add-apt-repository ppa:papirus/papirus
sudo apt update -y
sudo apt install -y papirus-icon-theme
echo "Need to install the hardcode-fixer: https://github.com/Foggalong/hardcode-fixer"
	# TODO call the hardcoded_icon_fixer.sh
	# chmod +x hardcoded_icon_fixer.sh
	# sudo ./hardcoded_icon_fixer.sh 
	# TODO try the hardcoded TRAY fix ?


# GNOME/Ubuntu Pomodoro
sudo apt install -y gnome-shell-pomodoro
# OR ?
# curl -L https://download.opensuse.org/repositories/home:/kamilprusko/xUbuntu_18.04/Release.key | sudo apt-key add -
# sudo sh -c "echo 'deb https://download.opensuse.org/repositories/home:/kamilprusko/xUbuntu_18.04/ /' >> /etc/apt/sources.list.d/gnome-pomodoro.list"
# sudo apt-get update
# sudo apt-get install gnome-pomodoro


# Add to Favourites
add_to_favourites () {
	application="'${1}.desktop'"
	favourites="/org/gnome/shell/favorite-apps"
	dconf write ${favourites} \
  	  "$(dconf read ${favourites} \
      | sed "s/, ${application}//g" \
      | sed "s/${application}//g" \
      | sed -e "s/]$/, ${application}]/")"
}
add_to_favourites tilix
# System Monitor
# Files Manager
# Terminal
# Firefox
# Sublime Text
# Sublime Merge
# Code (Visual Studio)
# Spotify
# Gnome Screenshot
# Gnome Clocks
