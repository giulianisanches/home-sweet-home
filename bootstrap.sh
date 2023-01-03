#!/bin/bash

sudo dnf install python3-pip git zsh util-linux-user

mkdir "$HOME/.zinit"
git clone https://github.com/zdharma-continuum/zinit.git  "$HOME/.zinit/bin"

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -r ./aws
rm -f awscliv2.zip

pip3 install --user ansible

mkdir -p "$HOME/dev/src/github.com/giulianisanches"

(
    cd "$HOME/dev/src/github.com/giulianisanches"
    # if you're planning to clone my repository, change the clone URL to use https
    git clone git@github.com:giulianisanches/home-sweet-home.git
    cd home-sweet-home
    ansible-playbook -K './home_sweet_home.yml'
)

mkdir -p "$HOME/dev/src/github.com/Gogh-Co"
(
    cd "$HOME/dev/src/github.com/Gogh-Co"
    git clone https://github.com/Gogh-Co/Gogh.git
    cd Gogh/themes

    export TERMINAL=gnome-terminal
    ./dracula.sh
)

chsh -s $( which zsh )