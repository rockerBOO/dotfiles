set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name="boo"

" Baseline
hi Normal           ctermfg=37 ctermbg=NONE cterm=NONE

" Syntax -=-=-=-= 
hi Comment          ctermfg=8 ctermbg=NONE cterm=NONE

hi String           ctermfg=15 ctermbg=NONE cterm=NONE
hi Character        ctermfg=11 ctermbg=NONE cterm=NONE
hi Number           ctermfg=11 ctermbg=NONE cterm=NONE
hi Float            ctermfg=11 ctermbg=NONE cterm=NONE
hi Boolean          ctermfg=11 ctermbg=NONE cterm=NONE

hi Identifier       ctermfg=14 ctermbg=NONE cterm=NONE
hi Function         ctermfg=41 ctermbg=NONE cterm=BOLD

hi Repeat           ctermfg=11 ctermbg=NONE cterm=bold
hi Operator         ctermfg=23 ctermbg=NONE cterm=bold
hi Exception        ctermfg=11 ctermbg=NONE cterm=bold
hi Conditional      ctermfg=11 ctermbg=NONE cterm=bold

hi Include          ctermfg=3 ctermbg=NONE cterm=bold
hi Define           ctermfg=125 ctermbg=NONE cterm=NONE
hi Type             ctermfg=11 ctermbg=NONE cterm=bold
hi StorageClass     ctermfg=11 ctermbg=NONE cterm=bold


" PHP -=-=-=-= 
hi phpStringSingle  ctermfg=15 ctermbg=NONE cterm=NONE
hi phpStringDouble  ctermfg=15 ctermbg=NONE cterm=NONE
