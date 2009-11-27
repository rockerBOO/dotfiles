
# Moves the file specified in argument 1 to the directory specified in argument 2 and
# creates a symlink from the old file's location to the new one. Useful when you want to move
# something, but not break the path completely if something is dependant on it.
function lmv { 
  [ -e $1 -a -e $2 ] && mv $1 $2 && ln -s $2/$(basename $1) $(dirname $1);
}

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

ips () {
  ifconfig | grep "inet " | awk '{ print $2 }'
}


if [ -f /opt/local/etc/profile.d/cdargs-bash.sh ]; then
   source /opt/local/etc/profile.d/cdargs-bash.sh
fi

export CLICOLOR=1
COLOR_TAN="\[\033[0;33m\]"
COLOR_GREEN="\[\033[0;32m\]"
COLOR_GRAY="\[\033[0;90m\]"
COLOR_DEFAULT="\[\033[0;0m\]"
export PS1="$COLOR_GREEN\w $COLOR_TAN\$(parse_git_branch)\n$COLOR_GRAY>$COLOR_DEFAULT "

export EDITOR=mate

alias ..='cd ..'
alias ...='cd ../..'
alias l='ls -lah'
alias la='ls -AF'
alias ll='ls -lFh'
alias status='git status'
alias add='git add'
alias commit='git commit'
alias rebase='git rebase'
alias checkout='git checkout'
alias m='mvim'
alias ss='script/server'
alias sc='script/console'
alias dcommit='git svn dcommit'
alias to='cdb'
stty erase ˆH

source /opt/local/etc/bash_completion.d/git-completion

export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# Google Go Lang Vars
export GOROOT=$HOME/go
export GOOS=darwin
export GOARCH=386
export GOBIN=$HOME/bin
export PATH=$GOBIN:$PATH
