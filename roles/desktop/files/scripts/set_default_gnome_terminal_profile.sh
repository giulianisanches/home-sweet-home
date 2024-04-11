#!/usr/bin/env bash

set -euo pipefail

read -r -a profile_list <<< "$(gsettings get org.gnome.Terminal.ProfilesList list | tr -d "',[]")"
for profile_id in "${profile_list[@]}"
do
    profile_name=$(gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$profile_id"/ visible-name | tr -d "'")
    if [[ "$profile_name" == "$GNOME_TERMINAL_PROFILE" ]]
    then
        gsettings set org.gnome.Terminal.ProfilesList default "$profile_id"
        break
    fi
done