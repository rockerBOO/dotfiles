PROMPT='%{$fg[cyan]%}[ %{$fg_bold[cyan]%}%c %{$fg_no_bold[cyan]%}]%{$reset_color%} '
RPROMPT='$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[magenta]%}%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[yellow]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$fg_bold[yellow]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
