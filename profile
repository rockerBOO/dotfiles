#!/usr/bin/env bash

export PATH="$HOME/.cargo/bin:$PATH"
export GTK_THEME=Nordic

#
# setup ssh-agent
#

# set environment variables if user's agent already exists
[ -z "$SSH_AUTH_SOCK" ] && SSH_AUTH_SOCK=$(ls -l /tmp/ssh-*/agent.* 2>/dev/null | grep $(whoami) | awk '{print $9}')
[ -z "$SSH_AGENT_PID" -a -z $(echo $SSH_AUTH_SOCK | cut -d. -f2) ] && SSH_AGENT_PID=$(($(echo $SSH_AUTH_SOCK | cut -d. -f2) + 1))
[ -n "$SSH_AUTH_SOCK" ] && export SSH_AUTH_SOCK
[ -n "$SSH_AGENT_PID" ] && export SSH_AGENT_PID

# start agent if necessary
if [ -z $SSH_AGENT_PID ] && [ -z $SSH_TTY ]; then # if no agent & not in ssh
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
	ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ >/dev/null || {
		start_agent
	}
else
	start_agent
fi

source "$HOME/.config/keys/reddit"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

complete -C /usr/bin/vault vault

LIBVA_DRIVER_NAME=nvidia
MOZ_DISABLE_RDD_SANDBOX=1
