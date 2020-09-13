augroup Prettier
	autocmd!	
	" Run Prettier on save
	autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.md,*.json,*.graphql,*.vue,*.yaml,*.html Prettier
augroup end


