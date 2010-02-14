for config_file ($ZSH/lib/*.zsh) source $config_file

export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export EDITOR=mvim

setopt autocd

stty erase ˆH

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
alias mysqld='sudo /opt/local/share/mysql5/mysql/mysql.server'
alias rmswp='find . -name "*.swp" -type f | xargs rm -f'

function lmv { 
  [ -e $1 -a -e $2 ] && mv $1 $2 && ln -s $2/$(basename $1) $(dirname $1);
}

ips () {
  ifconfig | grep "inet " | awk '{ print $2 }'
}
