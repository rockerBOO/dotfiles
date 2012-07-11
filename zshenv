export ZSH=$HOME/.zsh
export PATH=~/.bin:/usr/local/sbin:/usr/local/Cellar/php/5.3.6/bin:/usr/local/share/python:$PATH
export EDITOR=vim

if [ -f $HOME/.sshkeys ]; then
    (ssh-add -l 2>&1) > /dev/null

    if [ $? = "1" ]; then
        cat $HOME/.sshkeys | xargs ssh-add 2> /dev/null
    fi
fi
