# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

shopt -s autocd

[[ -f $HOME/.aliases ]] && source "$HOME/.aliases"
[[ -f $HOME/perl5/perlbrew/etc/bashrc ]] && source "$HOME/perl5/perlbrew/etc/bashrc"

COLOR_USER='\[\e[1;32m\]'
COLOR_CWD='\[\e[m\]'
COLOR_HOST='\[\e[1;34m\]'
COLOR_SUCCESS='\[\e[1;32m\]'
COLOR_FAILURE='\[\e[1;31m\]'
COLOR_GIT='\[\e[0;36m\]'

# check if th gpg-agent is running
# for debian 10 (and newer) based distributions https://github.com/microsoft/vscode/issues/87027
gpg-connect-agent -q updatestartuptty /bye &> /dev/null
SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

export SSH_AUTH_SOCK
source "$HOME/.bash/bash_powerline.sh"
