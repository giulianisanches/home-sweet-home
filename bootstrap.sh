#!/bin/bash

sudo apt install curl wget python3-pip git zsh

mkdir "$HOME/.zinit"
git clone https://github.com/zdharma-continuum/zinit.git  "$HOME/.zinit/bin"

pip3 install --user awscli
pip3 install --user ansible

mkdir -p "$HOME/dev/src/github.com/giulianisanches"

(
    cd "$HOME/dev/src/github.com/giulianisanches"
    git clone git@gitlab.com:giulianideon/home-sweet-home.git
    cd home-sweet-home
    "$HOME/.local/bin/ansible-playbook" -K ./home_sweet_home.yml
)

chsh -s $( which zsh )