shopt -s autocd

[[ -f $HOME/.aliases ]] && source "$HOME/.aliases"
[[ -f $HOME/perl5/perlbrew/etc/bashrc ]] && source "$HOME/perl5/perlbrew/etc/bashrc"

reset='\[\e[0m\]'

black='\[\e[0;30m\]'
red='\[\e[0;31m\]'
green='\[\e[0;32m\]'
brown='\[\e[0;33m\]'
blue='\[\e[0;34m\]'
purple='\[\e[0;35m\]'
cyan='\[\e[0;36m\]'

dark_grey='\[\e[1;30m\]'
light_red='\[\e[1;31m\]'
light_green='\[\e[1;32m\]'
yellow='\[\e[1;33m\]'
light_blue='\[\e[1;34m\]'
light_purple='\[\e[1;35m\]'
light_cyan='\[\e[1;36m\]'

PS1="${cyan}\u${reset}@\h ${light_green}\w${reset}\n${cyan}\$ ${reset}"

export PS1