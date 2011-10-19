alias ..='cd ..'
alias ...='cd ../..'

alias back='cd -'
alias 1='cd -'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'

alias l='ls -lah'
alias ll='ls -lFh'
alias ld='ls -ld *(/)'

function extract() {
    unset REMOVE_ARCHIVE
    
    if test "$1" = "-r"; then
        REMOVE=1
        shift
    fi
    if [[ -f $1 ]]; then
        case $1 in
          *.tar.bz2) tar xvjf $1;;
          *.tar.gz) tar xvzf $1;;
          *.tar.xz) tar xvJf $1;;
          *.tar.lzma) tar --lzma -xvf $1;;
          *.bz2) bunzip $1;;
          *.rar) unrar $1;;
          *.gz) gunzip $1;;
          *.tar) tar xvf $1;;
          *.tbz2) tar xvjf $1;;
          *.tgz) tar xvzf $1;;
          *.zip) unzip $1;;
          *.Z) uncompress $1;;
          *.7z) 7z x $1;;
          *) echo "'$1' cannot be extracted via >extract<";;
        esac

        if [[ $REMOVE_ARCHIVE -eq 1 ]]; then
            echo removing "$1";
            /bin/rm "$1";
        fi

    else
        echo "'$1' is not a valid file"
    fi
}
