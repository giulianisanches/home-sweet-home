setopt autocd nomatch
bindkey -e

zinit_home="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[[ ! -d $zinit_home ]] && mkdir -p "$(dirname $zinit_home)"
[[ ! -d $zinit_home/.git ]] && git clone https://github.com/zdharma-continuum/zinit.git "$zinit_home"
source "${zinit_home}/zinit.zsh"

autoload -Uz compinit; compinit
autoload -U promptinit; promptinit

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
# Load the pure theme, with zsh-async library that's bundled with it.
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

# the setopt below is to mimic the bourne-shell like behavior otherwise
# zsh will always thrown an error if the globbing fails
setopt no_nomatch
for f in $(ls .zsh/local/*.zsh 2>/dev/null) ; do source $f ; done
setopt nomatch

autoload -Uz ~/.zsh/**/*
[[ -f $HOME/.aliases ]] && source "$HOME/.aliases"

if [[ $(uname) != 'Darwin' ]]
then
    if type -p keychain > /dev/null
    then
        eval "$(keychain -q --nogui $HOME/.ssh/id_rsa)"
        eval "$(keychain -q --nogui $HOME/.ssh/id_rsa_abi)"
        eval "$(keychain -q --nogui $HOME/.ssh/id_ed25519)"
        eval "$(keychain -q --nogui $HOME/.ssh/id_ed25519_abinbev)"
        eval "$(keychain -q --nogui $HOME/.ssh/google_compute_engine)"
    else
        gpg-connect-agent -q updatestartuptty /bye &> /dev/null
    fi
fi

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if type "rbenv" &> /dev/null ; then eval "$(rbenv init - zsh)" ; fi

# pnpm
export PNPM_HOME="/Users/I572994/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm endexport

# setup pyenv
PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
