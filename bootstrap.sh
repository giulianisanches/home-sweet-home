#!/usr/bin/env bash

distribution="$(lsb_release -is 2> /dev/null | tr '[:upper:]' '[:lower:]')"

PATH="$PATH:$HOME/.local/bin"
export PATH

if [[ "$distribution" == 'fedora' ]]
then
    sudo dnf upgrade -y
    sudo dnf install -y python3-pip git zsh util-linux-user
fi

if [[ "$distribution" == 'debian' ]]
then
    sudo apt-get -y upgrade
    sudo apt-get -y install sudo python3-pip pipx git zsh curl gconf2
fi

# install ansible
pipx install --include-deps --force ansible

zini_home="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[[ ! -d "$zini_home" ]] && mkdir -p "$(dirname "$zini_home")"
[[ ! -d "$zini_home"/.git ]] \
    && git clone https://github.com/zdharma-continuum/zinit.git "$zini_home"


home_sweet_home="$HOME/dev/src/github.com/giulianisanches/home-sweet-home"
[[ ! -d "$home_sweet_home" ]] \
    && mkdir -p "$home_sweet_home"

[[ ! -d "$home_sweet_home/.git" ]] \
    && git clone \
        https://github.com/giulianisanches/home-sweet-home.git "$home_sweet_home"

(
    cd "$HOME/dev/src/github.com/giulianisanches" || exit
    # if you're planning to clone my repository
    # change the clone URL to use https
    git clone git@github.com:giulianisanches/home-sweet-home.git
    cd home-sweet-home || exit
    ansible-playbook -K './home_sweet_home.yml'
)

sudo chsh -s "$( which zsh )"