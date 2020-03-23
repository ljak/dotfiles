# Utils
# Author: ljak
# Creation Date: 2020_03_22


# The Logitech K380 Keyboard works very well in Linux. Bluetooth pairing is easy using blueman, just typing the 6 digits code on the keyboard when prompted is enough to complete the handshake. However, there is one issue with the keyboard: fn is always on, so to access the F1-F12 keys you have to press fn. To change this beavior, we can use a small utility called k380-function-keys-conf, which basically just revert the fn behavior to a classic one.
sudo apt install -y build-essential
cd /opt
sudo git clone https://github.com/jergusg/k380-function-keys-conf.git
cd k380-function-keys-conf/
sudo ./build.sh
sudo cp 80-k380.rules /etc/udev/rules.d/ && sudo udevadm control -R
sudo ./fn_on.sh

# Solaar - protocole Logitech Unifying Receiver
sudo apt install -y solaar solaar-gnome3