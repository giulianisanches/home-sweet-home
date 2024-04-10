#!/usr/bin/env bash

PATH="$PATH:$HOME/.local/bin"
export PATH

sudo apt install -y sudo python3-pip pipx git zsh curl gconf2

# install ansible
pipx install --include-deps --force ansible

home_sweet_home="$HOME/dev/src/github.com/giulianisanches/home-sweet-home"
gitcmd="git -C $home_sweet_home"

if [[ -d "$home_sweet_home/.git" ]]
then
    $gitcmd pull
else
    git clone \
        https://github.com/giulianisanches/home-sweet-home.git "$home_sweet_home"
fi

$gitcmd fetch -a
if $gitcmd branch -a | grep -q "$1"
then
    $gitcmd switch "$1"
else
    echo "[WARNING] Branch $1 not found. Using main branch."
fi

ansible-playbook -K "$home_sweet_home/home_sweet_home.yml"

sudo chsh -s "$( which zsh )" "$USER"