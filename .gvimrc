"""" Display
set bg=dark
colors slate2     " set color scheme
set gfn=Inconsolata\ for\ Powerline\ 10 " set font
set guioptions+=b " add bottom scrollbar
set guioptions-=T " don't display toolbar
set mouse=a
set scrolloff=5 " scroll at 5 lines away from top or bottom of viewport

" starting window size
set lines=65
" 80 character lines
" + line numbering (4)
" + fold columns (4)
set columns=88
" + nerdtree pane (32)
"set columns=120

"""" Indent Guides -- https://github.com/Yggdroot/indentLine
let g:indentLine_color_gui = '#2a2a2a'
let g:indentLine_char = '│'

" disable commands that could be used maliciously from being executed
" from the vimrc file located in the current working directory
set secure

noremap - $
noremap _ ^
noremap ; :
