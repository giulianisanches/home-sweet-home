#!/usr/bin/env bash

distribution="$(lsb_release -is 2>& /dev/null | tr '[:upper:]' '[:lower:]')"

if [[ "$distribution" == 'fedora' ]]
then
    sudo dnf upgrade -y
    sudo dnf install -y python3-pip git zsh util-linux-user
fi

if [[ "$distribution" == 'debian' ]]
then
    sudo apt-get -y upgrade
    sudo apt-get -y install sudo python3-pip git zsh curl gconf2
fi

zini_home="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[[ ! -d "$zini_home" ]] && mkdir -p "$(dirname "$zini_home")"
[[ ! -d "$zini_home"/.git ]] \
    && git clone https://github.com/zdharma-continuum/zinit.git "$zini_home"


home_sweet_home="$HOME/dev/src/github.com/giulianisanches"
[[ ! -d "$home_sweet_home" ]] \
    && mkdir -p "$HOME/dev/src/github.com/giulianisanches"

[[ ! -d "$home_sweet_home/.git" ]] \
    && git clone -C "$home_sweet_home" \
        https://github.com/giulianisanches/home-sweet-home.git

(
    cd "$HOME/dev/src/github.com/giulianisanches" || exit
    # if you're planning to clone my repository
    # change the clone URL to use https
    git clone git@github.com:giulianisanches/home-sweet-home.git
    cd home-sweet-home || exit
    #ansible-playbook -K './home_sweet_home.yml'
)

sudo chsh -s "$( which zsh )"