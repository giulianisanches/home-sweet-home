typeset -U path
typeset -U fpath

fpath=("$HOME/.zsh" $fpath)

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

GOROOT="$HOME/.local/opt/go"
GOPATH="$HOME/dev"
LESS="-M -R"
SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
GPG_AGENT_INFO="$SSH_AUTH_SOCK:$(pgrep gpg-agent)"
VENV_HOME="$HOME/dev/venv"

LDAP_USERNAME="giuliani_sanches"
ANSIBLE_CONFIG="$HOME/.config/ansible"

path=($path[@] $HOME/.local/bin $GOROOT/bin $GOPATH/bin)

export ANSIBLE_CONFIG
export LDAP_USERNAME
export VENV_HOME
export GOROOT
export GOPATH
export LESS
export PATH
export SSH_AUTH_SOCK
export GPG_AGENT_INFO