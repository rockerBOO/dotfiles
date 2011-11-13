export ZSH=$HOME/.zsh
export ZSH_THEME="minimal"
export PATH=~/.bin:/usr/local/bin:/usr/local/sbin:/usr/local/Cellar/php/5.3.6/bin:/usr/local/share/python:$PATH
export EDITOR=mvim

for file ($ZSH/lib/**/*.zsh) source $file
for file ($ZSH/plugins/**/*.zsh) source $file

stty erase ˆH

alias reload!='. ~/.zprofile && echo "Dotfiles reloaded!"'

NODE_PATH=/usr/local/lib/node
