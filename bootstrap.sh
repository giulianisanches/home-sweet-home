#!/usr/bin/env bash

distribution="$(lsb_release -is 2>& /dev/null | tr '[:upper:]' '[:lower:]')"

if [[ "$distribution" == 'fedora' ]]
then
    sudo dnf upgrade -y
    sudo dnf install -y python3-pip git zsh util-linux-user
fi

if [[ "distribution" == 'debian' ]]
then
    sudo apt-get -y upgrade
    sudo apt-get -y install sudo python3-pip git zsh curl gconf2
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[[ ! -d "$ZINIT_HOME" ]] && mkdir -p "$(dirname "$ZINIT_HOME")"
[[ ! -d "$ZINIT_HOME"/.git ]] \
    && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

[[ -d "$HOME/dev/src/github.com/giulianisanches" ]] \
    && rm -rf "$HOME/dev/src/github.com/giulianisanches"

mkdir -p "$HOME/dev/src/github.com/giulianisanches"
(
    cd "$HOME/dev/src/github.com/giulianisanches" || exit
    # if you're planning to clone my repository
    # change the clone URL to use https
    git clone git@github.com:giulianisanches/home-sweet-home.git
    cd home-sweet-home || exit
    #ansible-playbook -K './home_sweet_home.yml'
)

sudo chsh -s "$( which zsh )"