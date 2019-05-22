# Sample .profile for SuSE Linux
# rewritten by Christian Steinruecken <cstein@suse.de>
#
# This file is read each time a login shell is started.
# All other interactive shells will only read .bashrc; this is particularly
# important for language settings, see below.

test -z "$PROFILEREAD" && . /etc/profile || true

# Most applications support several languages for their output.
# To make use of this feature, simply uncomment one of the lines below or
# add your own one (see /usr/share/locale/locale.alias for more codes)
# This overwrites the system default set in /etc/sysconfig/language
# in the variable RC_LANG.
#
#export LANG=de_DE.UTF-8	# uncomment this line for German output
#export LANG=fr_FR.UTF-8	# uncomment this line for French output
#export LANG=es_ES.UTF-8	# uncomment this line for Spanish output

# Some people don't like fortune. If you uncomment the following lines,
# you will have a fortune each time you log in ;-)

#if [ -x /usr/bin/fortune ] ; then
#    echo
#    /usr/bin/fortune
#    echo
#fi

###############################################################################
# User variables
###############################################################################

reset='\[\e[0m\]'

black='\[\e[0;30m\]'
red='\[\e[0;31m\]'
green='\[\e[0;32m\]'
brown='\[\e[0;33m\]'
blue='\[\e[0;34m\]'
purple='\[\e[0;35m\]'
cyan='\[\e[0;36m\]'

dark_grey='\[\e[1;30m\]'
light_red='\[\e[1;31m\]'
light_green='\[\e[1;32m\]'
yellow='\[\e[1;33m\]'
light_blue='\[\e[1;34m\]'
light_purple='\[\e[1;35m\]'
light_cyan='\[\e[1;36m\]'

# check if th gpg-agent is running
gpg-connect-agent -q updatestartuptty /bye &> /dev/null

# System variables
# ----------------
PS1="${cyan}\u${reset}@\h ${light_green}\w${reset}\n${cyan}\$ ${reset}"
LESS="-M -R"
PATH="$PATH:$HOME/.local/bin"
SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
LESS="-M -R"
# The following variable is needed when using rxvt-unicode as
# home and end key need to be remapped
# INPUTRC="$HOME/.inputrc"

# Applications variables
# ----------------------
ANSIBLE_CONFIG="$HOME/.config/ansible"

# Custom variables
# ----------------
LDAP_USERNAME="giuliani_sanches"
VENV_HOME="/home/giuliani/dev/python/venv"

export PS1
export LESS
export PATH
export ANSIBLE_CONFIG
export SSH_AUTH_SOCK
export LDAP_USERNAME
export VENV_HOME