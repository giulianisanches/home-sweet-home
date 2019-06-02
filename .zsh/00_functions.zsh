# port bash_aliases as is.. port to zsh "style" is a WIP
function __lowercase() {
  echo "$( tr '[:upper:]' '[:lower:]' <<<${1} )"
}

function __function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

function __ldap_search () {
  local op="$1"
  local field="$2"
  local filter="$3"
  local ldap_host="${LDAP_HOST:-ldap.hom.sicredi.net}"
  local search_base="${LDAP_SEARCH_BASE:-dc=sicredi,dc=com,dc=br}"
  local ldapbin="$( which ldapsearch )"

  case "${op}" in
	search)
		"${ldapbin}" -x -b "${search_base}" -h "${ldap_host}" "${filter}" "${field}"
		;;
	*)
        echo "Only the search operation is implemented for now!"
		;;
  esac
}

function __vault() {
  echo "..."
  # local op="$1"; [[ $op eq "setenv"]] && shift
  # local stage="$( __lowercase ${1} )"; shift
  # local parameters="$*"

  # [[ -d $HOME/.config/vault ]] || mkdir -p "$HOME/.config/vault" && touch "$HOME/.config/vault/tokens"

  # export VAULT_ADDR="https://vault.${stage}-sicredi.in:8200"
  #   vault login -method=ldap username="${LDAP_USERNAME}"
  #   vault token renew
}

function __pyenv() {
  [[ -z ${VENV_HOME}  ]] && echo "Set VENV_HOME environment variable" && return 1

  local op="$( __lowercase ${1} )"
  local venv="$( __lowercase ${2} )"

  case "${op}" in
	create)
    python3 -m venv "${VENV_HOME}/${venv}"
    . "${VENV_HOME}/${venv}/bin/activate"
		;;
  list)
    ls "${VENV_HOME}"
    ;;
  activate)
    if [[ ! -d "${VENV_HOME}/${venv}" ]]; then
      echo "virtualenv ${venv} does not exists!"
      return 1
    fi

    . "${VENV_HOME}/${venv}/bin/activate"
    ;;
  remove)
    [[ -d "${VENV_HOME}/${venv}" ]] && rm -rf "${VENV_HOME}/${venv}"
    ;;
	*)
    echo "Usage:
            pyenv (create|list|activate|remove) <nome_virtualevn>"
		;;
  esac
}