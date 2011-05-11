export ZSH=$HOME/.zsh
export ZSH_THEME="simple"
export PATH=~/.bin:/usr/local/bin:/usr/local/sbin:$PATH

for file ($ZSH/lib/**/*.zsh) source $file

stty erase ˆH

alias reload!='. ~/.zshrc && echo "Dotfiles reloaded!"'
