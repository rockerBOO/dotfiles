# Allow the user to provide some stuff 
# before everything else is loaded
source $HOME/.profile 2&> /dev/null

export ZSH=$HOME/.zsh
export ZSH_THEME="simple"

if [ "$ZSH_ENV" = "server" ]
then
  export EDITOR=vim
else
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH
  export EDITOR=mvim
  stty erase ˆH
  alias m=mvim
fi

source $ZSH/zshrc
