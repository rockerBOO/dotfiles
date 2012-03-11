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


hi String           ctermfg=white ctermbg=232
hi Character        ctermfg=11
hi Number           ctermfg=11
hi Float            ctermfg=11
hi Boolean          ctermfg=11

hi Identifier       ctermfg=69
hi Function         ctermfg=47
hi Statement        ctermfg=46 cterm=bold

hi Repeat           ctermfg=11 cterm=bold
hi Operator         ctermfg=69 cterm=bold
hi Exception        ctermfg=11 cterm=bold
hi Conditional      ctermfg=white cterm=bold
hi Special          ctermfg=63 cterm=bold

hi Constant         ctermfg=11 

hi Include          ctermfg=3 cterm=bold
hi Define           ctermfg=125 
hi Type             ctermfg=32 cterm=bold
hi StorageClass     ctermfg=11 cterm=bold

hi PreProc          ctermfg=57 cterm=bold

hi LineNr           ctermfg=8 cterm=bold

hi ColorColumn      ctermbg=232

" PHP -=-=-=-=
hi def link phpComment          Comment
hi def link phpSuperglobals     Constant
hi def link phpMagicConstants   Constant
hi def link phpServerVars       Constant
hi def link phpConstants        Constant
hi def link phpBoolean          Constant
hi def link phpNumber           Constant
hi def link phpStringSingle     String
hi def link phpStringDouble     String
hi def link phpBacktick         String
hi def link phpHereDoc          String
hi def link phpNowDoc           String
hi def link phpFunctions        Identifier
hi def link phpClasses          Identifier
hi def link phpMethods          Identifier
hi def link phpIdentifier       Identifier
hi def link phpIdentifierSimply Identifier
hi def link phpStatement        Statement
hi def link phpStructure        Statement
hi def link phpException        Statement
hi def link phpOperator         Operator
hi def link phpVarSelector      Operator
hi def link phpInclude          PreProc
hi def link phpDefine           PreProc
hi def link phpSpecial          PreProc
hi def link phpFCKeyword        PreProc
hi def link phpType             Type
hi def link phpSCKeyword        Type
hi def link phpMemberSelector   Type
hi def link phpSpecialChar      Special
hi def link phpStrEsc           Special
hi def link phpParent           Special
hi def link phpParentError      Error
hi def link phpOctalError       Error
hi def link phpTodo             Todo



" phpStatement
" if else elseif while do for foreach break switch case default continue 
"  __construct __destruct __call __callStatic __get __set __isset __unset 
" try catch throw
"  die exit eval empty isset unset list instanceof 
" phpClasses
" All internal PHP Classes, as well as certain extensions
hi phpClasses       ctermfg=9 cterm=bold

" phpFunctions
" Same as phpClasses
hi phpMethods       ctermfg=82 ctermbg=233

" ->
hi phpMethodsVar    ctermfg=14

" ??
hi phpIdentifierSimply ctermfg=125

" abstract final private protected public static
hi phpSCKeyword ctermfg=125

" function 
hi phpFCKeyword ctermfg=125

" public private that begins with a space (public function x())
hi phpDefine ctermfg=125

" interface final class
hi phpStructure ctermfg=125

" final
hi phpFoldFunction ctermbg=233

"
hi phpFoldClass ctermbg=233

hi phpFoldInterface ctermbg=233

hi phpFoldCatch ctermbg=233

hi phpFoldTry ctermbg=233
