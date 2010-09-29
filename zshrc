# Allow the user to provide some stuff 
# before everything else is loaded
source $HOME/.profile 2&> /dev/null

export ZSH=$HOME/.zsh

if [ "$ZSH_ENV" = "server" ]
then
  export ZSH_THEME="simple-with-hostname"
  export EDITOR=vim
else
  export ZSH_THEME="simple"
  export PATH=/usr/local/bin:$PATH
  export EDITOR=mvim
  stty erase ˆH
  alias m=mvim
fi

source $ZSH/zshrc
