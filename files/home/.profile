# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# System variables
# ----------------
LESS="-M -R"

###############################################################################
# User variables
###############################################################################

# Custom variables
# ----------------
LDAP_USERNAME="giuliani_sanches"
VENV_HOME="$HOME/dev/venv"
GITLAB="$HOME/dev/src/gitlab.sicredi.net"

export LDAP_USERNAME
export VENV_HOME
export GITLAB

# Applications/tools variables
# ----------------------
ANSIBLE_CONFIG="$HOME/.config/ansible"
GOROOT="$HOME/.local/opt/go"
GOPATH="$HOME/dev"

export ANSIBLE_CONFIG
export GOROOT
export GOPATH

PATH="$HOME/.local/bin:$HOME/.local/sbin:$HOME/bin:$PATH:$GOROOT/bin:$GOPATH/bin"

# The following variable is needed when using rxvt-unicode as
# home and end key need to be remapped
# INPUTRC="$HOME/.inputrc"

export LESS
export PATH
