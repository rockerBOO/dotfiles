# zmodload zsh/zprof

DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(asdf git gh node docker fzf tmux rust fancy-ctrl-z mix extract archlinux yarn systemd themes ssh-agent zsh-aliases-eza zoxide)

zstyle ':omz:plugins:nvm' lazy yes
zstyle ':omz:plugins:nvm' lazy-cmd eslint prettier typescript
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# Bat
export BAT_THEME=ansi

# Systemd
export SYSTEMD_EDITOR=nvim

alias luamake=/home/rockerboo/build/lua-language-server/3rd/luamake/luamake
alias gitlab-run="gitlab-runner exec docker --cache-dir /cache --docker-volumes `pwd`/build-output:/cache"
# alias nvim=/home/rockerboo/build/lua_autocmds/build/bin/nvim
# alias bun="sde -- bun"

# complete -o nospace -C /usr/bin/vault vault
# [[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)
if type kubectl &>/dev/null; then
	kubectl() {
		unset -f "$0"
		source <(kubectl completion zsh)
		$0 "$@"
	}
fi
source <(podman completion zsh)


eval "$(starship init zsh)"

# source /mnt/900/builds/miniconda3/etc/profile.d/conda.sh
# export PATH="/mnt/900/builds/miniconda3/bin:$PATH"


# export LD_LIBRARY_PATH=/usr/local/lib

# Libtorch
# export LIBTORCH=/mnt/900/builds/libtorch-cxx11-abi-shared-with-deps-1.13.0+cu117/libtorch
# export LIBTORCH=~/code/others/libtorch
# export LD_LIBRARY_PATH=~/code/others/libtorch:$LD_LIBRARY_PATH
# export LIBTORCH_LIB=~/code/others/libtorch

# CUDA
# export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda/lib64:/usr/local/cudnn/lib:$LD_LIBRARY_PATH
# export LD_LIBRARY_PATH=/usr/local/cuda-11.8/lib64:$LD_LIBRARY_PATH
# export LD_LIBRARY_PATH="/opt/cuda/lib64:$LD_LIBRARY_PATH"
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-11.8/include
# export PATH="/usr/local/cuda-11.8/bin:$PATH"
#
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/900/lib/cuda-118/lib64

alias cr="cargo run && audio-player --volume 0.05 \"$HOME/code/audio-player/ff-victory-fanfare.ogg\" || audio-player --volume 0.05 \"$HOME/code/audio-player/losing-horn.ogg\""
alias cb="cargo build && audio-player --volume 0.05 \"$HOME/code/audio-player/ff-victory-fanfare.ogg\" || audio-player --volume 0.05 \"$HOME/code/audio-player/losing-horn.ogg\""
alias ct="cargo test && audio-player --volume 0.05 \"$HOME/code/audio-player/ff-victory-fanfare.ogg\" || audio-player --volume 0.05 \"$HOME/code/audio-player/losing-horn.ogg\""

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# source /usr/share/nvm/init-nvm.sh

# [ -s "$HOME/.bin" ] && export PATH="$HOME/.bin:$PATH"
#
# # bun completions
# [ -s "$HOME/.bun/_bun" ] && source "/home/rockerboo/.bun/_bun"
#
# # bun
# export BUN_INSTALL="$HOME/.bun"
# export PATH="$BUN_INSTALL/bin:$PATH"



export GPG_TTY=$(tty)
# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

# Add zfunc path
fpath+=~/.zfunc

export ASDF_DATA_DIR=$HOME/.asdf
export PATH="$ASDF_DATA_DIR/shims:$PATH"
# . /opt/asdf-vm/asdf.sh

# Source .profile if it exists and hasn't been sourced
if [ -f "$HOME/.profile" ] && [ -z "$PROFILE_SOURCED" ]; then
    . "$HOME/.profile"
    export PROFILE_SOURCED=1
fi

# https://github.com/astral-sh/uv/issues/8432#issuecomment-2965692994
# Fix completions for uv run to autocomplete .py files
_uv_run_mod() {
    if [[ "$words[2]" == "run" && "$words[CURRENT]" != -* ]]; then
        _arguments '*:filename:_files -g "*.py"'
    else
        _uv "$@"
    fi
}
compdef _uv_run_mod uv

# https://gist.github.com/ctechols/ca1035271ad134841284
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

# Autosuggest settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#663399,standout"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Lazy load SSH agent
function _load_ssh_agent() {
    if [ -z "$SSH_AUTH_SOCK" ]; then
        eval "$(ssh-agent -s)" > /dev/null
        ssh-add ~/.ssh/id_github_sign_and_auth 2>/dev/null
    fi
}
autoload -U add-zsh-hook
add-zsh-hook precmd _load_ssh_agent

alias pob="env -u WAYLAND_DISPLAY -u GDK_BACKEND QT_QPA_PLATFORM=\"xcb\" PathOfBuildingCommunity"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 

# zprof
