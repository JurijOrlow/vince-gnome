#!/bin/bash

echo "Theme color (default|purple|pink|red|orange|yellow|green|grey):"
read themeColor
echo "Theme variant (dark|light):"
read themeVariant
echo "Resolution (1080p|2k|4k):"
read resolution

mkdir -p /home/$USER/.gits
mkdir -p /home/$USER/.gits/vince

git clone https://github.com/vinceliuice/Colloid-gtk-theme.git /home/$USER/.gits/vince/theme
git clone https://github.com/vinceliuice/Tela-circle-icon-theme /home/$USER/.gits/vince/icons
git clone https://github.com/vinceliuice/WhiteSur-wallpapers.git /home/$USER/.gits/vince/wallpapers

chmod +x /home/$USER/.gits/vince/theme/install.sh
/home/$USER/.gits/vince/theme/install.sh -d /home/$USER/.themes -c $themeVariant -t $themeColor --tweaks rimless

chmod +x /home/$USER/.gits/vince/icons/install.sh
/home/$USER/.gits/vince/icons/install.sh -d /home/$USER/.icons $themeColor

chmod +x /home/$USER/.gits/vince/wallpapers/install-gnome-backgrounds.sh
chmod +x /home/$USER/.gits/vince/wallpapers/install-wallpapers.sh

sudo /home/$USER/.gits/vince/wallpapers/install-gnome-backgrounds.sh -s $resolution
sudo /home/$USER/.gits/vince/wallpapers/install-wallpapers.sh -s $resolution

echo "Do you want to set this up for Flatpak? (y/N)"
read decision
if [ $decision == "y" ] || [ $decision == "Y" ]; then
    sudo flatpak override --filesystem=/home/$USER/.themes
    sudo flatpak override --filesystem=/home/$USER/.icons
    sudo flatpak override --filesystem=xdg-config/gtk-4.0
    sudo flatpak override --filesystem=/usr/share/themes
    sudo flatpak override --filesystem=/usr/share/icons
    echo "Done, now use GNOME Tweak Tool to set your theme"
else
    echo "Done, now use GNOME Tweak Tool to set your theme"
fi
echo "Recommended cursors: https://store.kde.org/p/1405210"