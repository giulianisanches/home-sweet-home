setopt autocd nomatch
bindkey -e

source ~/.zinit/bin/zinit.zsh

autoload -Uz compinit; compinit
autoload -U promptinit; promptinit

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
# Load the pure theme, with zsh-async library that's bundled with it.
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

autoload -Uz ~/.zsh/**/*
[[ -f $HOME/.aliases ]] && source "$HOME/.aliases"
[[ -f $HOME/.local_secrets ]] && source "$HOME/.local_secrets"

gpg-connect-agent -q updatestartuptty /bye &> /dev/null