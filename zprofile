# https://zsh.sourceforge.io/Guide/zshguide02.html#l24
typeset -U path
path=(~/.games $path)
path=(~/.config/local/share/gem/ruby/3.0.0/bin $path)
path=(~/.rvm/bin ~/.fly/bin $path)
# path=($path /usr/local/cuda/bin)
# path=($path /mnt/900/lib/cuda-118/bin)

HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

autoload -U add-zsh-hook

if type kubectl &>/dev/null; then
	kubectl() {
		unset -f "$0"
		source <(kubectl completion zsh)
		$0 "$@"
	}
fi

if type podman &>/dev/null; then
	podman() {
		unset -f "$0"
		source <(podman completion zsh)
		$0 "$@"
	}
fi
eval "$(starship init zsh)"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export HF_HUB_CACHE=/mnt/2t870/cache/hf-hub/
export LLAMA_CACHE=/mnt/2t870/cache/llama.cpp-cache/

source ~/.profile

# Fly
# emulate sh -c '. ~/.profile'

