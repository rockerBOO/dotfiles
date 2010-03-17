# Dotfiles

## Get the files

    git clone git://github.com/brettbuddin/dotfiles.git ~/.dotfiles

## Setup configuration

**Use Vim settings:**

    ln -s ~/.dotfiles/vim ~/.vim
    ln -s ~/.dotfiles/vim/vimrc ~/.vimrc

**Use Git settings:**

    ln -s ~/.dotfiles/git/gitignore ~/.gitignore
    ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig

**Use ZSH settings for a local machine (desktop or laptop):**

    ln -s ~/.dotfiles/zsh/templates/local.zsh-template ~/.zshrc

**Use ZSH settings for a remote server:**

    ln -s ~/.dotfiles/zsh/templates/server.zsh-template ~/.zshrc

**Use Rubygems settings:**

    ln -s ~/.dotfiles/gemrc ~/.gemrc
