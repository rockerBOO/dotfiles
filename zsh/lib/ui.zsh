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

stty erase ˆH

REPORTTIME=10
LISTMAX=0

PS1="%n@%m:%~%# "

function machine_name {
  [ -f ~/.machine_name ] && cat ~/.machine_name || hostname -s
}

function battery_charge {
  echo `$HOME/.bin/batterycharge` 2>/dev/null
}

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_UNTRACKED=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

function git_prompt_info {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  rev=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/} ➥ ${rev}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function parse_git_dirty {
  gitstat=$(git status 2>/dev/null | grep '\(# Untracked\|# Changes\|# Changed but not updated:\)')

  if [[ $(echo ${gitstat} | grep -c '^\(# Changes not staged for commit:\|# Changes to be committed:\)$') > 0 ]]; then
	echo -n "$ZSH_THEME_GIT_PROMPT_DIRTY"
  fi

  if [[ $(echo ${gitstat} | grep -c "^# Untracked files:$") > 0 ]]; then
	echo -n "$ZSH_THEME_GIT_PROMPT_UNTRACKED"
  fi 

  if [[ $(echo ${gitstat} | grep -v '^$' | wc -l | tr -d ' ') == 0 ]]; then
	echo -n "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

source "$ZSH/themes/$ZSH_THEME.zsh"
