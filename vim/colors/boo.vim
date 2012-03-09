" boo vim colors
" Colors: http://images.wikia.com/vim/images/1/16/Xterm-color-table.png

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name="boo"

" Baseline
hi Normal           ctermfg=7

" Syntax -=-=-=-= 
hi Comment          ctermfg=8


hi String           ctermfg=white
hi Character        ctermfg=11
hi Number           ctermfg=11
hi Float            ctermfg=11
hi Boolean          ctermfg=11

hi Identifier       ctermfg=69
hi Function         ctermfg=46 cterm=bold
hi Statement        ctermfg=39

hi Repeat           ctermfg=11 cterm=bold
hi Operator         ctermfg=69 cterm=bold
hi Exception        ctermfg=11 cterm=bold
hi Conditional      ctermfg=white cterm=bold
hi Special          ctermfg=127 cterm=bold

hi Constant         ctermfg=11 

hi Include          ctermfg=3 cterm=bold
hi Define           ctermfg=125 
hi Type             ctermfg=32 cterm=bold
hi StorageClass     ctermfg=11 cterm=bold

hi PreProc          ctermfg=57 cterm=bold

hi LineNr           ctermfg=8 cterm=bold

" PHP -=-=-=-= 
hi def link phpFunctions    Function
hi phpClasses       ctermfg=9 cterm=bold
hi phpMethods       ctermfg=9
hi phpMethodsVar    ctermfg=14
hi phpIdentifierSimply ctermfg=125
hi phpSCKeyword ctermfg=125
hi phpFCKeyword ctermfg=125
