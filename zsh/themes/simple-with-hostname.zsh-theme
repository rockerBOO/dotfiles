typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

export __CURRENT_GIT_BRANCH=

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
  dirty=$(parse_git_dirty)
  color=$fg_bold[green]
  if [ -n "$dirty" ]
  then
    color=$fg_bold[yellow]
  fi
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/$color(\1$(parse_git_dirty))/"
}

setopt prompt_subst
PROMPT='%{$fg_bold[cyan]%}%m[%~] $(parse_git_branch)
%{$fg_bold[cyan]%}→ %{$reset_color%}'
