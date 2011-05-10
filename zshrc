export ZSH=$HOME/.zsh
export ZSH_THEME="simple"

export PATH=~/.bin:/usr/local/bin:/usr/local/sbin:$PATH
export EDITOR=mvim
alias m=mvim

stty erase ˆH

source $ZSH/zshrc

. `brew --prefix`/etc/profile.d/z.sh
function precmd () {
  z --add "$(pwd -P)"
}
