#!/usr/bin/env bash

excluded=("install.sh" "uninstall.sh" "README.markdown")

function isExcluded() {
	if [ -z "$1" ]
	then
		return
	fi

	for i in ${excluded[@]}
	do
		if [ $i == $1 ]
		then
			return 1
		fi
	done

	return 0
}

for name in *
do

target="$HOME/.$name"

if [ -e $target ]
then
	if isExcluded $name
    then
        if [ -L $target ]
        then
			echo "Removing $target"
            rm "$target" 
        else
            echo "$target is not a symlink"
        fi
    fi
fi

done

