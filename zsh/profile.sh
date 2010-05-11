for config_file ($ZSH/lib/*.zsh) source $config_file

setopt CORRECT
setopt CORRECTALL

setopt hist_ignore_dups
setopt share_history
setopt HIST_IGNORE_SPACE
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY

HISTFILE=~/.zsh_history
SAVEHIST=10000
HISTSIZE=10000

REPORTTIME=10
LISTMAX=0

autoload url-quote-magic
zle -N self-insert url-quote-magic

autoload compinit
compinit

bindkey -e
