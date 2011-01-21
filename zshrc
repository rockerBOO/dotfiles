if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then 
  source "$HOME/.rvm/scripts/rvm"
fi

export ZSH=$HOME/.zsh
export ZSH_THEME="simple"

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export EDITOR=mvim
alias m=mvim

stty erase ˆH

source $ZSH/zshrc
