
" fzf file fuzzy search that respects .gitignore
" If in git directory, show only files that are committed, staged, or unstaged
" else use regular :Files
nnoremap <expr> <Leader>p (len(system('git rev-parse')) > 0 ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"


