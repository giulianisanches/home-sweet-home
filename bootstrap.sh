#!/usr/bin/env bash

distribution="$(lsb_release -is 2> /dev/null | tr '[:upper:]' '[:lower:]')"

PATH="$PATH:$HOME/.local/bin"
export PATH

[[ "$distribution" == 'fedora' ]] && \
    sudo dnf install -y python3-pip pipx git zsh util-linux-user

[[ "$distribution" == 'debian' ]] && \
    sudo apt-get -y install sudo python3-pip pipx git zsh curl gconf2

# install ansible
pipx install --include-deps --force ansible

home_sweet_home="$HOME/dev/src/github.com/giulianisanches/home-sweet-home"

if [[ -d "$home_sweet_home/.git" ]]
then
    git -C "$home_sweet_home" pull
else
    git clone \
        https://github.com/giulianisanches/home-sweet-home.git "$home_sweet_home"
fi

ansible-playbook -K "$home_sweet_home/home_sweet_home.yml"

sudo chsh -s "$( which zsh )" "$USER"