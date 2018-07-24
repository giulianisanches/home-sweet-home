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

PS1="${green}\u${reset}@\h ${brown}\w${reset}\n${green}\$ ${reset}"

export PS1
export LESS="-M -R"
export INPUTRC="$HOME/.inputrc"
export NVM_DIR="$HOME/.nvm"

if [[ -d "$HOME/apps/miniconda3" ]] ; then
    export PATH="$HOME/apps/miniconda3/bin:$PATH"
fi

PATH=$PATH:$HOME/.local/bin:$HOME/bin
#http_proxy=http://localhost:3128
#https_proxy=http://localhost:3128

export PATH
export http_proxy
export https_proxy

eval "$(ssh-agent)" &> /dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion