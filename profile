#!/usr/bin/env bash

# export GTK_THEME=Nordic
export MANPATH="/usr/local/man:$MANPATH"
# export WLR_NO_HARDWARE_CURSORS=1

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

#
# setup ssh-agent
#

shopt -s extglob
# set environment variables if user's agent already exists
[ -z "$SSH_AUTH_SOCK" ] && SSH_AUTH_SOCK=$(ls -l /tmp/ssh-*/agent.* 2>/dev/null | grep $(whoami) | awk '{print $9}')
[ -z "$SSH_AGENT_PID" ] && [ -z $(echo "$SSH_AUTH_SOCK" | cut -d. -f2) ] && SSH_AGENT_PID=$(($(echo "$SSH_AUTH_SOCK" | cut -d. -f2) + 1))
[ -n "$SSH_AUTH_SOCK" ] && export SSH_AUTH_SOCK
[ -n "$SSH_AGENT_PID" ] && export SSH_AGENT_PID

# start agent if necessary
if [ -z "$SSH_AGENT_PID" ] && [ -z "$SSH_TTY" ]; then # if no agent & not in ssh
	eval $(ssh-agent -s) >/dev/null
fi

# setup addition of keys when needed
if [ -z "$SSH_TTY" ]; then # if not using ssh
	ssh-add -l >/dev/null     # check for keys
	if [ $? -ne 0 ]; then
		alias ssh='ssh-add -l > /dev/null || ssh-add && unalias ssh ; ssh'
		if [ -f "/usr/lib/ssh/x11-ssh-askpass" ]; then
			SSH_ASKPASS="/usr/lib/ssh/x11-ssh-askpass"
			export SSH_ASKPASS
		fi
	fi
fi

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
	echo "Initialising new SSH agent..."
	/usr/bin/ssh-agent | sed 's/^echo/#echo/' >"${SSH_ENV}"
	echo succeeded
	chmod 600 "${SSH_ENV}"
	. "${SSH_ENV}" >/dev/null
	/usr/bin/ssh-add
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
	. "${SSH_ENV}" >/dev/null
	#ps ${SSH_AGENT_PID} doesn't work under cywgin
	pgrep ssh-agent >/dev/null || {
		start_agent
	}
else
	start_agent
fi

export NVM_DIR="$HOME/.config/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"

# complete -C /usr/bin/vault vault

# hardware acceleration in firefox
# export LIBVA_DRIVER_NAME=nvidia
# export MOZ_DISABLE_RDD_SANDBOX=1

# export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

alias spot=ncspot
alias rust-analyzer="rustup run nightly rust-analyzer"
alias open="xdg-open"

# Setup nvidia shader cache 
export __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1
export __GL_SHADER_DISK_CACHE_SIZE=1000000000
# . "$HOME/.cargo/env"
