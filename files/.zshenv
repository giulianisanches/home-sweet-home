typeset -U path
typeset -U fpath

fpath=($HOME/.zsh $fpath)

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

GOROOT="$HOME/.local/opt/go"
GOPATH="$HOME/dev"
LESS="-F -M -R"
# TODO: This could only be run under linux (currently using macOS)
# SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
# GPG_AGENT_INFO="$SSH_AUTH_SOCK:$(pgrep gpg-agent)"
VENV_HOME="$HOME/dev/venv"
ANSIBLE_CONFIG="$HOME/.config/ansible"

# employer data
LDAP_USERNAME="${SECRETS_LDAP_USER_NAME}"
VPN_CONFIG_FILE="${SECRETS_VPN_CONFIG_FILE}"

GOOGLE_APPLICATION_CREDENTIALS="${SECRETS_GOOGLE_APPLICATION_CREDENTIALS}"

DOTNET_CLI_TELEMETRY_OPTOUT=1

path=($path[@]
      $HOME/.local/bin
      $GOROOT/bin
      $GOPATH/bin
      $HOME/.dotnet/tools
      /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'
PURE_CMD_MAX_EXEC_TIME=86400

export ANSIBLE_CONFIG
export LDAP_USERNAME
export VENV_HOME
export GOROOT
export GOPATH
export LESS
export PATH
export SSH_AUTH_SOCK
export GPG_AGENT_INFO

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE
export PURE_CMD_MAX_EXEC_TIME

export GOOGLE_APPLICATION_CREDENTIALS
export DOTNET_CLI_TELEMETRY_OPTOUT
