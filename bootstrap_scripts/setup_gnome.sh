#!/usr/bin/env bash
# Author: ljak
# Creation Date: 2020_03_22

# Description:

# Run: Execute command `./setup_gnome.sh`


# GNOME Shell Extensions
sudo add-apt-repository universe
sudo apt update -y
sudo apt install -y gnome-tweak-tool chrome-gnome-shell
curl https://raw.githubusercontent.com/oae/gnome-shell-extensions-sync/master/installer.sh | bash  # Sync extension auto-install

# See Gist ID and Gist Token to auto sync
SYNC_USERNAME=$(bw get item 0926b5a4-3eba-4326-bd1a-ab8c0029ce36 | jq .login.username | sed -r "s/\\\"/\\'/g" | sed 's/^/\"/g' | sed 's/$/\"/g')
dconf write /org/gnome/shell/extensions/sync/gist-id $SYNC_USERNAME
SYNC_PASSWORD=$(bw get item 0926b5a4-3eba-4326-bd1a-ab8c0029ce36 | jq .login.password| sed -r "s/\\\"/\\'/g" | sed 's/^/\"/g' | sed 's/$/\"/g')
dconf write /org/gnome/shell/extensions/sync/gist-token $SYNC_PASSWORD

xdg-open https://addons.mozilla.org/en-US/firefox/addon/gnome-shell-integration/  # open link in default browser

# if needed
# gnome-shell --version
# sudo rm -r /usr/share/gnome-shell/extensions/ubuntu-* / pomodoro
# More http://www.bernaerts-nicolas.fr/linux/76-gnome/345-gnome-shell-install-remove-extension-command-line-script


# TODO get the settings for the extensions ?

# ### GNOME Theme
# GTK Theme
sudo apt install -y materia-gtk-theme
# Next, into Tweak Tool, change to the wanted theme.

# Icons Theme: https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
# Recommanded Theme: Materia, Arc, Adapta
sudo add-apt-repository ppa:papirus/papirus
sudo apt update -y
sudo apt install -y papirus-icon-theme
# fix application icons with https://github.com/Foggalong/hardcode-fixer
sudo ./hardcoded_icon_fixer.sh
# TODO try the hardcoded TRAY fix ?


# GNOME/Ubuntu Pomodoro
sudo apt install -y gnome-shell-pomodoro
# OR ?
# curl -L https://download.opensuse.org/repositories/home:/kamilprusko/xUbuntu_18.04/Release.key | sudo apt-key add -
# sudo sh -c "echo 'deb https://download.opensuse.org/repositories/home:/kamilprusko/xUbuntu_18.04/ /' >> /etc/apt/sources.list.d/gnome-pomodoro.list"
# sudo apt-get update
# sudo apt-get install gnome-pomodoro


# Add to Favourites
dconf write /org/gnome/shell/favorite-apps "['']"  # Clear favorites
add_to_favourites () {
	application="'${1}.desktop'"
	favourites="/org/gnome/shell/favorite-apps"
	dconf write ${favourites} \
  	  "$(dconf read ${favourites} \
      | sed "s/, ${application}//g" \
      | sed "s/${application}//g" \
      | sed -e "s/]$/, ${application}]/")"
}
add_to_favourites com.gexperts.Tilix  # Terminal
add_to_favourites org.gnome.Nautilus  # Files Manager
add_to_favourites firefox
add_to_favourites sublime_text
add_to_favourites sublime_merge
add_to_favourites org.gnome.Screenshot
