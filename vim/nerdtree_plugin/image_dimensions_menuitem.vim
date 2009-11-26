" ============================================================================
" File:        image_dimensions_menuitem.vim
" Description: Menu item plugin for NERD Tree that returns image dimensions
" Maintainer:  Brett Buddin <brett at intraspirit dot net>
" Last Change: 13 October, 2009
" ============================================================================

if exists("g:loaded_nerdtree_image_dimensions_menuitem")
  finish
endif
let g:loaded_nerdtree_image_dimensions_menuitem = 1

call NERDTreeAddMenuItem({
            \ 'text': '(i)dimensions of current node',
            \ 'shortcut': 'i',
            \ 'callback': 'NERDTreeImageDimensions',
            \ 'isActiveCallback': 'NERDTreeImageDimensionsActive' })

function! NERDTreeImageDimensionsActive()
  let node = g:NERDTreeFileNode.GetSelected()
  return !node.path.isDirectory && (node.path._str() =~ '\v.*(\.jpg|\.jpeg|\.png|\.gif|\.bmp)$')
endfunction

function! NERDTreeImageDimensions()
  let treenode = g:NERDTreeFileNode.GetSelected()
  redraw
  echo "Dimensions: " . system('identify -format "%ww x %hh" ' . treenode.path.str({'escape': 1}))
endfunction
