# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.bin:/usr/local/bin:$PATH

# Configure the oh-my-zsh ssh-agent plugin
zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent lifetime 4h

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.local/share/oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="rockerboo"

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

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
ZSH_CUSTOM=~/.local/share/zsh

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(asdf git gh node fd docker fzf tmux rust fancy-ctrl-z mix extract archlinux yarn systemd themes ssh-agent zsh-aliases-exa ripgrep kubectl)

source $ZSH/oh-my-zsh.sh

# User configuration
#
# https://docs.docker.com/engine/security/rootless/
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Starship https://starship.rs/
eval "$(starship init zsh)"

# Add API keys
source $HOME/.config/private/keys
source $HOME/.config/keys/reddit

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
alias eg="cd ~/code/ecogarden/create"
alias ecogarden="~/code/ecogarden/create/src-tauri/target/release/ecogarden"
# alias docker=podman
alias spot=ncspot
alias rust-analyzer="rustup run nightly rust-analyzer"
alias open="xdg-open"

# NVM node version manager
source /usr/share/nvm/init-nvm.sh

# Python environment manager
eval "$(pyenv init -)"

# Zoxide
eval "$(zoxide init zsh)"

# Add luarocks paths
# eval "$(luarocks path --bin)"

# Setup nvidia shader cache 
export __GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1
export __GL_SHADER_DISK_CACHE_SIZE=1000000000

# Bat
export BAT_THEME=ansi


alias luamake=/home/rockerboo/build/lua-language-server/3rd/luamake/luamake
alias gitlab-run="gitlab-runner exec docker --cache-dir /cache --docker-volumes `pwd`/build-output:/cache"
# alias nvim=/home/rockerboo/build/lua_autocmds/build/bin/nvim
alias bun="sde -- bun"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/vault vault
[[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)
source <(podman completion zsh)

# source /mnt/900/builds/miniconda3/etc/profile.d/conda.sh
# export PATH="/mnt/900/builds/miniconda3/bin:$PATH"

export PATH="/home/rockerboo/.config/local/share/gem/ruby/3.0.0/bin:$PATH"


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
