#!/usr/bin/env bash

sudo apt-get -y upgrade
sudo apt-get -y install sudo python3-pip git zsh curl gconf2

[[ -d "$HOME/.zinit" ]] && rm -rf "$HOME/.zinit"

mkdir "$HOME/.zinit"
git clone https://github.com/zdharma-continuum/zinit.git  "$HOME/.zinit/bin"

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