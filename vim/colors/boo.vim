" boo vim colors
" Colors: http://images.wikia.com/vim/images/1/16/Xterm-color-table.png

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name="boo"

" Baseline
hi Normal           ctermfg=7 ctermbg=NONE cterm=NONE

" Syntax -=-=-=-= 
hi Comment          ctermfg=8 ctermbg=NONE cterm=NONE

hi String           ctermfg=WHITE ctermbg=NONE cterm=NONE
hi Character        ctermfg=11 ctermbg=NONE cterm=NONE
hi Number           ctermfg=11 ctermbg=NONE cterm=NONE
hi Float            ctermfg=11 ctermbg=NONE cterm=NONE
hi Boolean          ctermfg=11 ctermbg=NONE cterm=NONE

hi Identifier       ctermfg=31 ctermbg=NONE cterm=NONE
hi Function         ctermfg=46 ctermbg=NONE cterm=NONE
hi Statement        ctermfg=39 ctermbg=NONE cterm=NONE

hi Repeat           ctermfg=11 ctermbg=NONE cterm=bold
hi Operator         ctermfg=31 ctermbg=NONE cterm=bold
hi Exception        ctermfg=11 ctermbg=NONE cterm=bold
hi Conditional      ctermfg=WHITE ctermbg=NONE cterm=bold
hi Special          ctermfg=8 ctermbg=NONE cterm=bold

hi Constant         ctermfg=11 ctermbg=NONE cterm=NONE

hi Include          ctermfg=3 ctermbg=NONE cterm=bold
hi Define           ctermfg=125 ctermbg=NONE cterm=NONE
hi Type             ctermfg=32 ctermbg=NONE cterm=bold
hi StorageClass     ctermfg=11 ctermbg=NONE cterm=bold

hi PreProc          ctermfg=57 ctermbg=NONE cterm=bold

hi LineNr           ctermfg=8 ctermbg=NONE cterm=bold

" PHP -=-=-=-= 
hi def link phpFunctions    Function
hi phpClasses       ctermfg=9 ctermbg=NONE cterm=bold
hi phpMethods       ctermfg=9 ctermbg=NONE cterm=NONE

