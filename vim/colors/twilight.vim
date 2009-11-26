set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "twilight"

if version >= 700
  hi CursorLine guibg=#182028
  hi CursorColumn guibg=#182028
  hi MatchParen guifg=white guibg=#80a090 gui=bold ctermfg=white cterm=bold

  "Tabpages
  hi TabLine guifg=black guibg=#b0b8c0 ctermfg=black
  hi TabLineFill guifg=#9098a0 ctermfg=246
  hi TabLineSel guifg=black guibg=#f0f0f0 gui=bold ctermfg=black cterm=bold

  "P-Menu (auto-completion)
  hi Pmenu guifg=white guibg=#808080 ctermfg=white
  "PmenuSel
  "PmenuSbar
  "PmenuThumb
endif

hi Cursor guifg=NONE guibg=#586068 ctermfg=none cterm=none
hi CursorColumn	cterm=none			ctermbg=238
hi CursorLine	cterm=none			ctermbg=235
hi lCursor	cterm=none	ctermfg=0	ctermbg=40

hi Normal guifg=#f8f8f8 guibg=#141414 ctermfg=255 ctermbg=NONE
"hi LineNr guifg=#808080 guibg=#e0e0e0
hi LineNr guifg=#808080 guibg=#141414 ctermfg=244

hi StatusLine guifg=#f0f0f0 guibg=#4f4a50 ctermfg=254
hi StatusLineNC guifg=#c0c0c0 guibg=#5f5a60 ctermfg=251
hi VertSplit guifg=#5f5a60 guibg=#5f5a60 ctermfg=60
hi Folded guibg=#384048 guifg=#a0a8b0 ctermfg=247
hi Comment gui=italic guifg=#5f5a60 ctermfg=241
hi Todo guifg=#808080 guibg=NONE gui=bold ctermfg=244 ctermbg=NONE cterm=bold
hi Constant guifg=#cf6a4c ctermfg=209
hi String guifg=#8f9d6a ctermfg=229
hi Type guifg=#F9EE98 ctermfg=83

" CSS Stuff
hi cssTagName guifg=#cda869
hi cssClassName guifg=#9b703f
hi cssIdentifier guifg=#8b98ab
hi cssTagName guifg=#cda869
hi cssBraces guifg=#ffffff


" JavaScript Stuff
hi javaScriptBraces guifg=#ffffff


hi Identifier guifg=#7587a6 ctermfg=68
hi Structure guifg=#9B859D ctermfg=139
hi Function guifg=#dad085 ctermfg=228
" dylan: method, library, ...
hi Statement guifg=#dad085 gui=NONE ctermfg=228 cterm=NONE
" Keywords
hi PreProc guifg=#cda869 ctermfg=221
hi NonText guifg=#808080 guibg=#303030 ctermfg=244 ctermbg=NONE
hi Special ctermfg=172

"hi Macro guifg=#a0b0c0 gui=underline

"Tabs, trailing spaces, etc (lcs)
hi SpecialKey guifg=#808080 guibg=#343434 ctermfg=244

"hi TooLong guibg=#ff0000 guifg=#f8f8f8
