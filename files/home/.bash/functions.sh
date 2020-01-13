#!/bin/bash

function __function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

function ldap_search () {
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

[[ -f $HOME/.bash/extras.sh ]] && . $HOME/.bash/extras.sh
# function v() {  
#   function usage() {
#     echo "Usage: "
#     echo "    v (puc|cas) (dev|tst|uat|prd) <default vault command line arguments - read, write (...)> "
#   }

#   ## TODO: Implement a token helper  
#   local site="${1,,}"; shift
#   local stage="${1,,}"; shift
#   local parameters="$*"

#   case "${site}" in
# 	puc)
# 		export VAULT_ADDR="https://vault.${stage}-sicredi.in:8200"
# 		;;
#   cas)
#     export VAULT_ADDR="https://vault.digital.${stage}.sicredi.net:8200"
#     ;;
# 	*)
#     usage && return
# 		;;
#   esac

#   [[ -z stage ]] && usage && return
#   [[ -z parameters ]] && usage && return

#   ## TODO: Implement a token helper
#   if [[ -z ${token} ]] 
#   then
#     token=$( vault login -method=ldap username="${LDAP_USERNAME}" -format=json | jq .auth.client_token )
#     echo "${site};${stage};${token};$( date +'%s')" >> "$HOME/.config/vault/tokens"
#   else
#     vault login ${token}
#   fi

#   vault ${parameters}
# }

function pyenv() {
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

function c8s() {
    if [[ -z $1 ]]; then
        echo "Ambiente não especificado."
    else
        KUBECONFIG_DIR="$GITLAB/devops_st/st-cas-k8s-kubespray/inventory"
        if [[ "$1" == "dev" ]]; then
            export KUBECONFIG_FILE="$KUBECONFIG_DIR/cluster_dev/artifacts/admin.conf"
        elif [[ "$1" == "tst" ]]; then
            export KUBECONFIG_FILE="$KUBECONFIG_DIR/cluster_tst/artifacts/admin.conf"
        elif [[ "$1" == "uat" ]]; then
            export KUBECONFIG_FILE="$KUBECONFIG_DIR/cluster_uat/artifacts/admin.conf"
        elif [[ "$1" == "prd" ]]; then
            export KUBECONFIG_FILE="$KUBECONFIG_DIR/cluster_prd/artifacts/admin.conf"
        else
            echo "Ambiente inválido."
        fi
        kubectl --kubeconfig $KUBECONFIG_FILE ${@:2}
    fi
}

function find_elb_endpoint() {
    local elb_arn
    
    mapfile -t elb_arn < <(aws elbv2 describe-load-balancers --query 'LoadBalancers[?starts_with(LoadBalancerName, `DEV-ECS-CLUSTER-SVC`)].{Arn:LoadBalancerArn}' --output text)
}