autoload -U colors
colors

setopt PROMPT_SUBST
setopt AUTO_CD
setopt CORRECT
setopt CORRECTALL
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt INTERACTIVE_COMMENTS

unsetopt MENU_COMPLETE
setopt AUTO_MENU

autoload url-quote-magic
zle -N self-insert url-quote-magic
bindkey -v

REPORTTIME=10
LISTMAX=0

PS1="%n@%m:%~%# "

function machine_name {
  [ -f ~/.machine_name ] && cat ~/.machine_name || hostname -s
}

source "$ZSH/themes/$ZSH_THEME.zsh"
