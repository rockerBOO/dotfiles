" =============================================================================
"
" File:        newspaper.vim
" Description: Vim color scheme file
" Maintainer:  Clayton Parker (cterm colors)
"
" =============================================================================

"  Initialization and Setup {{{1
" =============================================================================
set background=light
highlight clear
if exists("syntax_on")
  syntax reset
endif
let colors_name = "newspaper"
" }}}

" =============================================================================
hi Normal gui=NONE guifg=#000000 guibg=#dbdbd2
hi ColorColumn  guifg=NONE              guibg=#EEEEDD
hi Cursor       guifg=bg                guibg=fg                gui=NONE

hi CursorColumn guifg=NONE              guibg=#FFFDD0       gui=NONE
hi CursorLine   guifg=NONE              guibg=#d6d4b9       gui=NONE

hi CursorIM     guifg=bg                guibg=fg                gui=NONE
hi lCursor      guifg=bg                guibg=fg                gui=NONE
hi DiffAdd      guifg=NONE              guibg=SeaGreen1         gui=NONE
hi DiffChange   guifg=NONE              guibg=LightSkyBlue1     gui=NONE
hi DiffDelete   guifg=NONE              guibg=LightCoral        gui=NONE
hi DiffText     guifg=black             guibg=LightCyan1        gui=NONE
hi Directory    guifg=#1600FF           guibg=bg                gui=NONE
hi ErrorMsg     guifg=Red2              guibg=NONE              gui=NONE
hi FoldColumn   guifg=SteelBlue4        guibg=LightYellow2      gui=bold
hi Folded       guifg=SteelBlue4        guibg=Gainsboro         gui=italic

hi IncSearch    guifg=black             guibg=khaki             gui=NONE
hi Search       guifg=black             guibg=khaki             gui=NONE
hi LineNr       guifg=#666677           guibg=#cccfbf           gui=NONE
hi MatchParen   guifg=black             guibg=LemonChiffon3     gui=bold
hi ModeMsg      guifg=White             guibg=tomato1           gui=bold
hi MoreMsg      guifg=SeaGreen4         guibg=bg                gui=bold
hi NonText      guifg=#497b8b        guibg=bg                gui=bold

hi Pmenu        guifg=Orange4           guibg=LightYellow3      gui=NONE
hi PmenuSel     guifg=ivory2            guibg=NavajoWhite4      gui=bold
hi PmenuSbar    guifg=White             guibg=#999666        gui=NONE
hi PmenuThumb   guifg=White             guibg=#7B7939        gui=NONE

hi Question     guifg=Chartreuse4       guibg=bg                gui=bold
hi SignColumn   guifg=white             guibg=LightYellow3      gui=NONE

hi SpecialKey   guifg=white         guibg=ivory3            gui=NONE

hi SpellBad     guisp=Firebrick2                                gui=undercurl
hi SpellCap     guisp=Blue                                      gui=undercurl
hi SpellLocal   guisp=DarkCyan                                  gui=undercurl
hi SpellRare    guisp=Magenta                                   gui=undercurl
hi StatusLine   guifg=#FFFEEE           guibg=#557788     gui=NONE
hi StatusLineNC guifg=#F4F4EE           guibg=#99aabb    gui=italic
hi TabLine      guifg=fg                guibg=LightGrey         gui=underline
hi TabLineFill  guifg=fg                guibg=bg                gui=reverse
hi TabLineSel   guifg=fg                guibg=bg                gui=bold
hi Title        guifg=#395f6c      guibg=bg                gui=bold
hi VertSplit    guifg=#99aabb     guibg=#99aabb
hi Visual       guifg=white             guibg=#0a7383      gui=NONE
hi WarningMsg   guifg=Firebrick2        guibg=bg                gui=NONE
hi WildMenu     guifg=Black             guibg=SkyBlue           gui=NONE
" }}}

" 256-Color Terminal Colors, by Clayton Parker {{{1
" =============================================================================
hi Normal cterm=NONE ctermfg=16  ctermbg=255
hi Comment      ctermfg=110
hi Constant     ctermfg=214
    hi String   ctermfg=30
    hi Boolean  ctermfg=88
hi Identifier   ctermfg=160/
hi Function     ctermfg=132
hi Statement    ctermfg=21
hi Keyword      ctermfg=45
hi PreProc      ctermfg=27
hi Type         ctermfg=147
hi Special      ctermfg=64
hi Ignore       ctermfg=255
hi Error        ctermfg=196             ctermbg=255     term=none
hi Todo         ctermfg=136             ctermbg=255     cterm=NONE
hi VimError         ctermfg=160          ctermbg=16
hi VimCommentTitle  ctermfg=110
hi qfLineNr         ctermfg=16           ctermbg=46        cterm=NONE
hi pythonDecorator ctermfg=208   ctermbg=255 cterm=NONE
hi Cursor       ctermfg=255             ctermbg=16              cterm=NONE
hi CursorColumn ctermfg=NONE            ctermbg=255             cterm=NONE
hi CursorIM     ctermfg=255             ctermbg=16              cterm=NONE
hi CursorLine   ctermfg=NONE            ctermbg=254             cterm=NONE
hi lCursor      ctermfg=255             ctermbg=16              cterm=NONE
hi DiffAdd      ctermfg=16              ctermbg=48              cterm=NONE
hi DiffChange   ctermfg=16              ctermbg=153             cterm=NONE
hi DiffDelete   ctermfg=16              ctermbg=203             cterm=NONE
hi DiffText     ctermfg=16              ctermbg=226             cterm=NONE
hi Directory    ctermfg=21              ctermbg=255             cterm=NONE
hi ErrorMsg     ctermfg=160             ctermbg=NONE            cterm=NONE
hi FoldColumn   ctermfg=24              ctermbg=252             cterm=NONE
hi Folded       ctermfg=24              ctermbg=252             cterm=NONE
hi IncSearch    ctermfg=255             ctermbg=160             cterm=NONE
hi LineNr       ctermfg=253             ctermbg=110             cterm=NONE
hi NonText      ctermfg=110             ctermbg=255             cterm=NONE
hi Pmenu        ctermfg=fg              ctermbg=195             cterm=NONE
hi PmenuSbar    ctermfg=255             ctermbg=153             cterm=NONE
hi PmenuSel     ctermfg=255             ctermbg=21              cterm=NONE
hi PmenuThumb   ctermfg=111             ctermbg=255             cterm=NONE
hi SignColumn   ctermfg=110             ctermbg=254             cterm=NONE
hi Search       ctermfg=255             ctermbg=160             cterm=NONE
hi SpecialKey   ctermfg=255             ctermbg=144             cterm=NONE
hi SpellBad     ctermfg=16              ctermbg=229             cterm=NONE
hi SpellCap     ctermfg=16              ctermbg=231             cterm=NONE
hi SpellLocal   ctermfg=16              ctermbg=231             cterm=NONE
hi SpellRare    ctermfg=16              ctermbg=226             cterm=NONE
hi StatusLine   ctermfg=255             ctermbg=24              cterm=NONE
hi StatusLineNC ctermfg=253             ctermbg=110             cterm=NONE
hi Title        ctermfg=75              ctermbg=255             cterm=NONE
hi VertSplit    ctermfg=255             ctermbg=24              cterm=NONE
hi Visual       ctermfg=255             ctermbg=153             cterm=NONE
hi WildMenu     ctermfg=16              ctermbg=117             cterm=NONE
hi Comment      guifg=#4e5968         guibg=NONE     gui=italic
hi Constant     guifg=#881a1a        guibg=NONE      gui=NONE
hi String   guifg=#1e5432       guibg=NONE      gui=NONE
hi Boolean  guifg=IndianRed4        guibg=NONE      gui=NONE
hi Identifier   guifg=brown3            guibg=NONE      gui=NONE
hi Function     guifg=#714442          guibg=NONE      gui=bold
hi Statement    guifg=#1f5595           guibg=NONE      gui=NONE
hi Keyword      guifg=#2c4869	        guibg=NONE      gui=NONE
hi PreProc      guifg=blue1             guibg=NONE      gui=NONE
hi Type         guifg=#421b4d     guibg=NONE      gui=NONE
hi Conditional  guifg=#401c57          guibg=NONE      gui=NONE
hi Special      guifg=#2c694a           guibg=NONE      gui=NONE
hi Ignore       guifg=bg                guibg=NONE      gui=NONE
hi Error        guifg=Red               guibg=NONE      gui=underline
hi Todo         guifg=tan4              guibg=NONE      gui=bold
" -----------------------------------------------------------------------------
hi VimError         guifg=red            guibg=Black   gui=bold
hi VimCommentTitle  guifg=DarkSlateGray4 guibg=bg      gui=bold,italic
hi qfFileName  guifg=LightSkyBlue4     guibg=NONE      gui=italic
hi qfLineNr    guifg=coral             guibg=NONE      gui=bold
hi qfError     guifg=red               guibg=NONE      gui=bold

" -----------------------------------------------------------------------------
hi pythonDecorator  guifg=#6c1111 guibg=NONE gui=bold
hi link pythonDecoratorFunction pythonDecorator
" -----------------------------------------------------------------------------
hi diffOldFile          guifg=#006666           guibg=NONE      gui=NONE
hi diffNewFile          guifg=#0088FF           guibg=NONE      gui=bold
hi diffFile             guifg=#0000FF           guibg=NONE      gui=NONE
hi link diffOnly        Constant
hi link diffIdentical   Constant
hi link diffDiffer      Constant
hi link diffBDiffer     Constant
hi link diffIsA         Constant
hi link diffNoEOL       Constant
hi link diffCommon      Constant
hi diffRemoved          guifg=#BB0000           guibg=NONE      gui=NONE
hi diffChanged          guifg=DarkSeaGreen      guibg=NONE      gui=NONE
hi diffAdded            guifg=#00AA00           guibg=NONE      gui=NONE
hi diffLine             guifg=thistle4          guibg=NONE      gui=italic
hi link diffSubname     diffLine
hi link diffComment     Comment
hi htmlLink             guifg=#666666          guibg=NONE      gui=underline,italic
hi htmlTagName          guifg=NONE             guibg=NONE      gui=NONE
hi link htmlScriptTag htmlTagName
hi link htmlTagN htmlTagName
hi link htmlEndTag htmlTagName
hi link htmlSpecialTagName htmlTagName

hi link cssRenderAttr Constant 
hi link cssTextAttr Constant
hi link cssUIAttr Constant
hi link cssTableAttr Constant
hi link cssColorAttr Constant
hi link cssBoxAttr Constant
hi link cssCommonAttr Constant
hi link cssFunctionName Constant
hi link cssRenderProp Type
hi link cssBoxProp cssRenderProp

hi link cssTagName Statement
hi link cssClassName cssTagName
hi link cssIdentifier cssTagName
hi link cssPseudoClass cssTagName
hi link cssPseudoClassId cssTagName

hi cssBraces            guifg=fg            guibg=bg              gui=NONE
hi javaScript           guifg=fg            guibg=NONE
hi link javaScriptFunction Statement
hi link javaScriptMember Statement
hi link javaScriptValue Constant

hi link objcClass Type
hi link cocoaClass objcClass
hi link objcSubclass objcClass
hi link objcSuperclass objcClass
hi link cocoaFunction Function
hi link objcMethodName Identifier
hi link objcMethodArg Normal
hi link objcMessageName Identifier

hi link javaType Statement

hi link cppStatement  Statement
