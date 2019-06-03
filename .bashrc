shopt -s autocd

[[ -f $HOME/.aliases ]] && source "$HOME/.aliases"
[[ -f $HOME/perl5/perlbrew/etc/bashrc ]] && source "$HOME/perl5/perlbrew/etc/bashrc"

COLOR_USER='\[\e[0;36m\]'
COLOR_HOST='\[\e[0;36m\]'
COLOR_CWD='\[\e[1;32m\]'
COLOR_SUCCESS='\[\e[0;32m\]'
COLOR_FAILURE='\[\e[0;31m\]'
COLOR_GIT='\[\e[0;35m\]'

source "$HOME/.bash/bash_powerline.sh"