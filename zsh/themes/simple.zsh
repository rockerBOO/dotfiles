function machine_name {
  [ -f ~/.machine_name ] && cat ~/.machine_name || hostname -s
}

PROMPT='%{$fg[yellow]%}$(machine_name)%{$reset_color%} in %{$fg[green]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info)
$ '

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
