export ZSH=$HOME/.zsh
export ZSH_THEME="minimal"
export PATH=~/.bin:/usr/local/bin:/usr/local/sbin:/usr/local/Cellar/python/2.7/bin:$PATH

for file ($ZSH/lib/**/*.zsh) source $file

stty erase ˆH

alias reload!='. ~/.zprofile && echo "Dotfiles reloaded!"'

NODE_PATH=/usr/local/lib/node
