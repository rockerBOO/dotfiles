# https://zsh.sourceforge.io/Guide/zshguide02.html#l24
typeset -U path
path=(~/.games $path)
path=(~/.config/local/share/gem/ruby/3.0.0/bin $path)
path=(~/.rvm/bin ~/.fly/bin $path)

HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export HF_HUB_CACHE=/mnt/2t870/cache/hf-hub/
export LLAMA_CACHE=/mnt/2t870/cache/llama.cpp-cache/

source ~/.profile
