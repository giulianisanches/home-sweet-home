if [[ -f ~/.bashrc ]] ; then
    source ~/.bashrc
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

PS1="${cyan}\u${reset}@\h ${green}\w${reset}\n${cyan}\$ ${reset}"


if [[ -d "$HOME/apps/miniconda3" ]] ; then
    export PATH="$HOME/apps/miniconda3/bin:$PATH"
fi

PATH=$PATH:$HOME/.local/bin:$HOME/bin
LESS="-M -R"
INPUTRC="$HOME/.inputrc"
#http_proxy=http://localhost:3128
#https_proxy=http://localhost:3128

export PATH
export PS1
export LESS
export INPUTRC
#export http_proxy
#export https_proxy

eval "$(ssh-agent)" &> /dev/null
