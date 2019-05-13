function __ldap_search () {
    local op="$1"
    local filter="$2"
    local ldap_host="${LDAP_HOST:-ldap.hom.sicredi.net}"
    local search_base="${LDAP_SEARCH_BASE:-dc=sicredi,dc=com,dc=br}"

    local ldapbin="$(which ldapsearch)"
  case "${op}" in
	search)
		${ldapbin} -x -b "${search_base}" -h "${ldap_host}" "${filter}"
		;;
	*)
        echo "Only the search operation is implemented for now!"
		;;
  esac
}

function __vault() {
    export VAULT_ADDR="https://vault.$1-sicredi.in:8200"
    vault login -method=ldap username=giuliani_sanches
    vault token renew
}


function __function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

for al in `__git_aliases`; do
    alias g$al="git $al"
    
    complete_func=_git_$(__git_aliased_command $al)
    __function_exists $complete_fnc && __git_complete g$al $complete_func
done

alias grep='grep -E' 
alias ldp=__ldap_search
alias v=__vault
#alias v-dev-tmp=”vault dev read aws/creds/aws_devops”
#alias v-tst-tmp=”vault tst read aws/creds/aws_devops”
#alias v-uat-tmp=”vault uat read aws/creds/aws_devops”
#alias v-prd-tmp=”vault prd read aws/creds/aws_devops”