#!/bin/bash

sudo apt install curl wget python3-pip git zsh

mkdir "$HOME/.zinit"
git clone https://github.com/zdharma/zinit.git  "$HOME/.zinit/bin"

pip3 install --user awscli
pip3 install --user ansible

mkdir -p "$HOME/dev/src/github.com/giulianisanches"

(
    cd "$HOME/dev/src/github.com/giulianisanches"
    git clone git@gitlab.com:giulianideon/home-sweet-home.git
)

gsettings set org.gnome.shell.app-switcher current-workspace-only true
# Set flameshot as the default screenshot tool
# https://askubuntu.com/questions/1036473/ubuntu-18-how-to-change-screenshot-application-to-flameshot
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot '[]'
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'flameshot'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command '/usr/bin/flameshot gui'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding 'Print'
# disable gnome keyring for ssh
cp /etc/xdg/autostart/gnome-keyring-ssh.desktop .config/autostart/
echo "Hidden=true" >> ~/.config/autostart/gnome-keyring-ssh.desktop

chsh -s $( which zsh )