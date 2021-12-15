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

$keychain=$(which keychain)
if (( ${+keychain} )); then
  eval `$keychain -q --nogui $HOME/.ssh/id_rsa`
  eval `$keychain -q --nogui $HOME/.ssh/id_rsa_abi`
  eval `$keychain -q --nogui $HOME/.ssh/id_ed25519`
  eval `$keychain -q --nogui $HOME/.ssh/id_ed25519_abinbev`
  eval `$keychain -q --nogui $HOME/.ssh/google_compute_engine`
else
  gpg-connect-agent -q updatestartuptty /bye &> /dev/null
fi