DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(asdf git gh node docker fzf tmux rust fancy-ctrl-z mix extract archlinux yarn systemd themes ssh-agent zsh-aliases-eza zoxide)

zstyle ':omz:plugins:nvm' lazy yes
zstyle ':omz:plugins:nvm' lazy-cmd eslint prettier typescript
source $ZSH/oh-my-zsh.sh

export BAT_THEME=ansi
export SYSTEMD_EDITOR=nvim

alias luamake=/home/rockerboo/build/lua-language-server/3rd/luamake/luamake
alias gitlab-run="gitlab-runner exec docker --cache-dir /cache --docker-volumes `pwd`/build-output:/cache"
alias spot=ncspot
alias rust-analyzer="rustup run nightly rust-analyzer"
alias open="xdg-open"

if type kubectl &>/dev/null; then
	kubectl() {
		unset -f "$0"
		source <(kubectl completion zsh)
		$0 "$@"
	}
fi
source <(podman completion zsh)

eval "$(starship init zsh)"

alias cr="cargo run && audio-player --volume 0.05 \"$HOME/code/audio-player/ff-victory-fanfare.ogg\" || audio-player --volume 0.05 \"$HOME/code/audio-player/losing-horn.ogg\""
alias cb="cargo build && audio-player --volume 0.05 \"$HOME/code/audio-player/ff-victory-fanfare.ogg\" || audio-player --volume 0.05 \"$HOME/code/audio-player/losing-horn.ogg\""
alias ct="cargo test && audio-player --volume 0.05 \"$HOME/code/audio-player/ff-victory-fanfare.ogg\" || audio-player --volume 0.05 \"$HOME/code/audio-player/losing-horn.ogg\""

export GPG_TTY=$(tty)

# Add zfunc path
fpath+=~/.zfunc

export ASDF_DATA_DIR=$HOME/.asdf
export PATH="$ASDF_DATA_DIR/shims:$PATH"

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

# Switch the active CUDA toolkit for this shell: cuda-use 12.4 | 11.8 | system
cuda-use() {
    setopt local_options nullglob
    local version="$1"

    if [ -z "$version" ]; then
        echo "Usage: cuda-use <version>"
        echo "Available:"
        for d in /usr/local/cuda-* /usr/local/cuda_* /opt/cuda; do
            [ -d "$d" ] || continue
            case "$d" in
                /opt/cuda) echo "  system" ;;
                *) echo "  ${${d#/usr/local/cuda[-_]}//_/.}" ;;
            esac
        done
        return 1
    fi

    local target
    case "$version" in
        system|opt) target=/opt/cuda ;;
        *)
            if [ -d "/usr/local/cuda-$version" ]; then
                target="/usr/local/cuda-$version"
            else
                target="/usr/local/cuda_${version//./_}"
            fi
            ;;
    esac

    if [ ! -d "$target" ]; then
        echo "cuda-use: $target not found" >&2
        return 1
    fi

    # Capture the pre-cuda-use PATH/LD_LIBRARY_PATH once so repeated
    # switches don't stack duplicate entries from previous versions.
    export _CUDA_USE_BASE_PATH="${_CUDA_USE_BASE_PATH:-$PATH}"
    export _CUDA_USE_BASE_LD="${_CUDA_USE_BASE_LD:-$LD_LIBRARY_PATH}"

    export CUDA_HOME="$target"
    export CUDA_PATH="$target"
    export PATH="$target/bin:$_CUDA_USE_BASE_PATH"
    export LD_LIBRARY_PATH="$target/lib64:$_CUDA_USE_BASE_LD"

    echo "cuda-use: now using $target"
    "$target/bin/nvcc" --version 2>/dev/null | tail -1
}
