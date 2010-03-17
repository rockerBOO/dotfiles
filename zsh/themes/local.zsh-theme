typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

export __CURRENT_GIT_BRANCH=

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

COLOR_TAN=$'\e[0;33m'
COLOR_GREEN=$'\e[0;32m'
COLOR_GRAY=$'\e[0;90m'
COLOR_DEFAULT=$'\e[0;0m'

setopt prompt_subst
PROMPT='${COLOR_GREEN}%~ ${COLOR_TAN}($(parse_git_branch))
${COLOR_GRAY}>${COLOR_DEFAULT} '
