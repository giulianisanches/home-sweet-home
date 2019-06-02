typeset -U path

GOROOT="$HOME/.local/opt/go"
GOPATH="$HOME/dev"
LESS="-M -R"
SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
# INPUTRC="$HOME/.inputrc"
VENV_HOME="$HOME/dev/venv"

path=($path[@] $HOME/.local/bin $GOROOT/bin $GOPATH/bin)

export VENV_HOME
export GOROOT
export GOPATH
export LESS
export PATH
export SSH_AUTH_SOCK