#!/bin/bash

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
  function usage() {
    echo "Usage: "
    echo "    v (puc|cas) (dev|tst|uat|prd) <default vault command line arguments - read, write (...)> "
  }

  ## TODO: Implement a token helper
  [[ -d $HOME/.config/vault ]] || mkdir -p "$HOME/.config/vault" && touch "$HOME/.config/vault/tokens"  
  
  local site="${1,,}"; shift
  local stage="${1,,}"; shift
  local parameters="$*"
  ## TODO: Implement a token helper
  local token=$( grep "${stage}" "$HOME/.config/vault/tokens" | grep "${site}" | cut -d ';' -f 3 )
  
  case "${site}" in
	puc)
		export VAULT_ADDR="https://vault.${stage}-sicredi.in:8200"
		;;
  cas)
    export VAULT_ADDR="https://vault.digital.${stage}.sicredi.net:8200"
    ;;
	*)
    usage && return
		;;
  esac

  [[ -z stage ]] && usage && return
  [[ -z parameters ]] && usage && return

  ## TODO: Implement a token helper
  if [[ -z ${token} ]] 
  then
    token=$( vault login -method=ldap username="${LDAP_USERNAME}" -format=json | jq .auth.client_token )
    echo "${site};${stage};${token};$( date +'%s')" >> "$HOME/.config/vault/tokens"
  else
    vault login ${token}
  fi

  vault ${parameters}
}

function __pyenv() {
  [[ -z ${VENV_HOME}  ]] && echo "Set VENV_HOME environment variable" && return 1

  local op="${1,,}"
  local venv="${2,,}"

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