setopt autocd nomatch
bindkey -e

source ~/.zinit/bin/zinit.zsh

autoload -Uz compinit
compinit

[[ -f $HOME/.aliases ]] && source "$HOME/.aliases"

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
# Load the pure theme, with zsh-async library that's bundled with it.
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

autoload -Uz ~/.zsh/**/*

gpg-connect-agent -q updatestartuptty /bye &> /dev/null