# Tell zsh to execute function found in some magic arrays.
# Each of these is an array of function names.
# Each function name is executed when zsh performs some action.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# used to cache git info
export __CURRENT_GIT_INFO=

parse_git_branch() {
  git branch --no-color 2> /dev/null \
  | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

preexec_functions+='zsh_preexec_update_git_vars'
zsh_preexec_update_git_vars() {
  case "$(history $HISTCMD)" in 
    *git*)
    export __CURRENT_GIT_INFO="$(update_git_prompt_info)"
    ;;
  esac
}

chpwd_functions+='zsh_chpwd_update_git_vars'
zsh_chpwd_update_git_vars() {
  export __CURRENT_GIT_INFO="$(update_git_prompt_info)"
}
function git_prompt_info {
  echo "$__CURRENT_GIT_INFO"
}

function update_git_prompt_info {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function parse_git_dirty {
  gitstat=$(git status 2>/dev/null | grep '\(# Untracked\|# Changes\|# Changed but not updated:\)')

  if [[ $(echo ${gitstat} | grep -c "^# Changes to be committed:$") > 0 ]]; then
	echo -n "$ZSH_THEME_GIT_PROMPT_DIRTY"
  fi

  if [[ $(echo ${gitstat} | grep -c "^\(# Untracked files:\|# Changed but not updated:\)$") > 0 ]]; then
	echo -n "$ZSH_THEME_GIT_PROMPT_UNTRACKED"
  fi 

  if [[ $(echo ${gitstat} | grep -v '^$' | wc -l | tr -d ' ') == 0 ]]; then
	echo -n "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}
