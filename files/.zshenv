typeset -U path
typeset -U fpath

fpath=($HOME/.zsh $fpath)

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

[[ $(uname) != 'Darwin' ]] && GOROOT="$HOME/.local/opt/go"

LESS="-F -M -R"
# TODO: This could only be run under linux (currently using macOS)
[[ $(uname) != 'Darwin' ]] && SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
[[ $(uname) != 'Darwin' ]] && GPG_AGENT_INFO="$SSH_AUTH_SOCK:$(pgrep gpg-agent)"

VENV_HOME="$HOME/dev/venv"
ANSIBLE_CONFIG="$HOME/.config/ansible"

# employer data
LDAP_USERNAME="${SECRETS_LDAP_USER_NAME}"
VPN_CONFIG_FILE="${SECRETS_VPN_CONFIG_FILE}"

GOOGLE_APPLICATION_CREDENTIALS="${SECRETS_GOOGLE_APPLICATION_CREDENTIALS}"

DOTNET_CLI_TELEMETRY_OPTOUT=1

path=($path[@]
      $HOME/.local/bin
      $HOME/.dotnet/tools)

if [[ $(uname) == 'Darwin' ]]
then
    path=($path[@]
          /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/
          ~/Library/Python/3.8/bin)
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'
PURE_CMD_MAX_EXEC_TIME=86400

# Disable the use of the buildkit api
# Reference: https://github.com/containers/podman/issues/13889
DOCKER_BUILDKIT=0
export DOCKER_BUILDKIT

export ANSIBLE_CONFIG
export LDAP_USERNAME
export VENV_HOME

export LESS
export PATH

[[ (( ${+SSH_AUTH_SOCK} )) ]] && export SSH_AUTH_SOCK
[[ (( ${+GPG_AGENT_INFO} )) ]] && export GPG_AGENT_INFO

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE
export PURE_CMD_MAX_EXEC_TIME

export GOOGLE_APPLICATION_CREDENTIALS
export DOTNET_CLI_TELEMETRY_OPTOUT
