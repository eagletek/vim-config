"""" Compatibility {{{
" Vim needs a more POSIX compatible shell than fish
if &shell =~# 'fish$'
    set shell=bash
endif

"""" Most things require vim >= 7
if version < 700
    finish
endif

set nocompatible        " use vim defaults
""""}}}
"""" Pathogen {{{
"runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
"""" }}}

" Enable filetype specific plugins
filetype plugin on

" Syntax highlighting on
syntax on

"""" Display {{{
if exists('+colorcolumn')
    set colorcolumn=81
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>81v.\+', -1)
endif

set novisualbell
set wildmenu
set laststatus=2  " always show status line
set showmatch     " briefly jump to bracket match for 3/10 of a second
set ruler         " show cursor position
set showcmd       " Show (partial) command in status line.
set number        " line numbering
set scrolloff=5   " always try to show lines above or below cursor while scrolling
set wildignore+=*.o,*.ko,*.a,*.so,*.dep,abuild-linux.*,*.gcda,*.gcno
"""" }}}
"""" Searching {{{
set hlsearch      " highlight search terms in document
set incsearch     " incremental searching
set ignorecase    " case-insensitive
set smartcase
set gdefault      " global replace by default
"""" }}}
"""" Miscellaneous {{{
set complete=.,w,b,u,t,i " completion search order
set nowrap               " disable long line wrapping
set hls                  " highlight search match while typing

" backspace through indents, end of lines, and start
set backspace=indent,eol,start
set nojs  " no join spaces


set ttimeoutlen=50
"""" }}}
"""" Indentation {{{

" Indents are often more readable if they consist of four spaces
" rather than a tab character; this affects the >/< keys in normal
" mode, and <Ctrl>+T/<Ctrl>+D  in insert mode:
set shiftwidth=4        " A four space indent shift
set softtabstop=4
set tabstop=4           " A four space tab stop
set shiftround
set expandtab
set smarttab
"set textwidth=80  " Causes automatic wrapping after 80 chars
retab

" Code indentation
" indentation 'copied down' lines as you type, so that once the first
" line of something has been indented, the indent will apply to all subsequent
" lines typed, until cancelled (EG with <Ctrl>+U just after <Enter>).
set autoindent
set cindent             " Attempt to use a configurable indenting scheme
set cino=:2,=2,g2,h2,u0,+1s
" 2 <- sets case indent under switch to 2 spaces
" =2 <- sets code indent under case to 2 spaces
" g2 <- sets c++ scope declaration indent to 2 spaces
" h2 <- sets method / variables under scope declarations to 2 spaces
" u0 <- sets indentation for extra unclosed parens to 0 spaces
" +1s <- sets continuation lines to indent 1 'tabs'

" default vim cinoptions=> s,e0,n0,f0,{0,}0,^0,:s,=s,l0,b0,gs,hs,ps,ts,
" is,+s,c3,C0,/0,(2s,us,U0,w0,W0,m0,j0,)20,*30,#0

"""" }}}
"""" Command history {{{
set history=50
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100
set wildmode=list:longest,full
set showmode
"""" }}}
"""" Auto chdir (disabled) {{{
" Automatically change current directory to the dir containing the file in
" buffer
" if (exists("+autochdir"))
"     set acd
" else
"     autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
" endif
"""" }}}
"""" Spelling {{{
set spell spelllang=en_us
"""" }}}
"""" Code folding {{{

set fdm=syntax      " sets the folding method to syntax
set foldminlines=2  " sets the minimum lines before folding to 2
set foldcolumn=4    " sets the number of folding columns to show
autocmd FileType c,cc,cpp,cxx,java set foldtext=FoldDoxyDifferent()
autocmd FileType vim set fdm=marker
autocmd FileType html,php set fdm=marker
"""" }}}
"""" File type specific {{{
autocmd FileType c set formatoptions+=ro
autocmd FileType java set smartindent
autocmd FileType perl set smartindent
autocmd FileType make set noexpandtab shiftwidth=4
autocmd FileType ruby,html,css,php set shiftwidth=2
autocmd FileType ruby,html,css,php set softtabstop=2
autocmd FileType ruby,html,css,php set tabstop=2
autocmd FileType ruby,html,css,php retab

" sets the highlighting to doxygen
au BufNewFile,BufRead *.doxygen setfiletype doxygen

if version >= 700
    autocmd Filetype java set omnifunc=javacomplete#Complete
endif

" For some inexplicable reason, the default java syntax highlighting
" marks C++ keywords as errors in java (e.g. a method called delete()).
" That seems dubious.  Let's not flag C++ keywords as errors in a java file.
let java_allow_cpp_keywords = "true"
"""" }}}
"""" Mappings {{{

" Keep visual selection when changing indentation
vnoremap < <gv
vnoremap > >gv

" Arrow keys move the current line
noremap <up> ddkP
noremap <down> ddp
noremap <left> v<
noremap <right> v>

let mapleader=","     " I don't like the default of '\'

" Save / Quit
noremap <leader>w :w<cr>
noremap <leader>q :q<cr>
noremap <leader>z :wq<cr>
noremap <leader>bw :w<cr>:bn<cr>

" Build
set makeprg=make
noremap <leader>m :w<cr>:make -j6 install<cr>
imap m   <esc>:w<cr>:make<cr>

" Copy/Paste with system clipboard
noremap <leader>p "+gP
noremap <leader>y "+y

" quote/paren/bracket/brace visual selection
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>
vnoremap <leader>( <esc>`>a)<esc>`<i(<esc>
vnoremap <leader>[ <esc>`>a]<esc>`<i[<esc>
vnoremap <leader>{ <esc>`>a}<esc>`<i{<esc>
vnoremap <leader>{{ <esc>`<O{<esc>`>a<cr>}<esc>gv>

" toggle NERD Tree
noremap <leader>n :NERDTreeToggle<CR>

" Bind nohl
" (removes highlight of last search)
noremap  <C-n> :nohl<CR>

" Map sort function
vnoremap <leader>s :sort<CR>

" Type lang<C-Y> for shebang line
inoremap <C-y> <esc>I#!/bin/env <esc>:filetype detect<cr>o

"""" Function keys
" Next/Previus buffer
map <F2> :bp<CR>
map <F3> :bn<CR>
map <F4> :FSHere<CR>
map <leader>vss :FSLeft<CR>

" Quickfix
map <F5> :cp<CR>
map <F6> :cc<CR>
map <F7> :cn<CR>

" Quickfix w/ task list
map <C-F5> :lp<CR>
map <C-F6> :lc<CR>
map <C-F7> :lne<CR>

map <F8> :make<CR>
map <silent> <F12> :BufExplorer<CR>

" CTRL+movement keys switch windows
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l

" Maximize current window
map <leader>- <C-W>_

" unmap  to be able to use  for its original purpose
" (incrementing number under cursor)
" unmap <C-A>

"""" }}}
"""" Variable definitions {{{
let g:DoxygenToolkit_authorName="Josh O'Connell"
let g:CppToolkit_authorName="Josh O'Connell"
"""" }}}
"""" Plugin Configuration {{{
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#checks = [ 'indent' ]
"""" }}}

" Custom function to display first line of text from doxygen / javadoc style
" comment.
function! FoldDoxyDifferent()
  let line = getline(v:foldstart)
  if line =~ '\/\*\*\s*$'
    let line1 = substitute(getline(v:foldstart+1), '\s*\*\s*@\w*\s*\|\s*\*\s*', '', 'g')
    let num = v:foldend - v:foldstart + 1
    return "+" . v:folddashes . num . " lines: " . substitute(line, '/\*\*\|\*/\|{{{\d\=', line1, 'g')
  endif

  return foldtext()
endfunction

