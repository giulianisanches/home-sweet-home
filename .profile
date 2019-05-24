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

# check if th gpg-agent is running
gpg-connect-agent -q updatestartuptty /bye &> /dev/null

# System variables
# ----------------
LESS="-M -R"
PATH="$PATH:$HOME/.local/bin:$HOME/.local/opt/go/bin:$(go env GOPATH)/bin"
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
VENV_HOME="+/home/giuliani/dev/venv"

export LESS
export PATH
export ANSIBLE_CONFIG
export SSH_AUTH_SOCK
export LDAP_USERNAME
export VENV_HOME