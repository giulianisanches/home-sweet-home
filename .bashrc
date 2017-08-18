if [[ -f ~/.bash_aliases ]] ; then
    source ~/.bash_aliases
fi

if [[ -f ~/perl5/perlbrew/etc/bashrc ]] ; then
    source ~/perl5/perlbrew/etc/bashrc
fi

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

PS1="${green}\u${reset}@\h ${brown}\w${reset}\n${green}\$ ${reset}"
export PS1

export LESS="-M -R"

eval "$(ssh-agent)" &> /dev/null

# added by Miniconda3 4.3.21 installer
export PATH="/home/giuliani/apps/miniconda3/bin:$PATH"
