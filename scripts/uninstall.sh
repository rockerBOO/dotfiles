#!/usr/bin/env bash

dotfiles_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )"
excluded=("scripts" "README.markdown" "Makefile" ".github")

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

for path in $dotfiles_dir/*
do
    name=`basename $path`
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

