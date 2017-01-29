" 2. Add the following to your ~/.vimrc file to cause vim to use doxygen.vim
" syntax highlighting whenever editing pure Doxygen files.
"
" au BufNewFile,BufRead *.doxygen setfiletype doxygen
"
" Now vim will use the doxygen.vim syntax highlighting whenever editing files
" named *.doxygen.  If you use a different name for your pure Doxygen files,
" replace "*.doxygen" in the above line with the file name you use, such
" as "*.dox".

" Setup {{{
if version >= 600
  " Quit when a syntax file was already loaded
  if exists("b:current_syntax") && b:current_syntax =~ 'tidl'
    finish
  endif
else
  " Croak when an old Vim is sourcing us.
  echo "Sorry, but this syntax file relies on Vim 6 features.  Either upgrade Vim or use a version of " . expand("<sfile>:t:r") . " syntax file appropriate for Vim " . version/100 . "." . version %100 . "."
  finish
endif

syn clear
syn case match
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
" Comments {{{
syn match tidlComment "\/\/.*$" contains=tidlTodo
syn keyword tidlTodo TODO FIXME XXX contained
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
" Base constructs {{{
syn match tidlAssign "="
syn match tidlBlockBegin "{"
syn match tidlBlockEnd "}"
syn match tidlNow "now"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
" key highlight {{{

syn keyword tidlKey namespace
syn keyword tidlKey class
syn keyword tidlKey enum
syn keyword tidlKey interface
syn keyword tidlKey compare
syn keyword tidlKey abstract

syn keyword tidlName bool char uchar int8 uint8
syn keyword tidlName short ushort int16 uint16
syn keyword tidlName int uint int32 uint32
syn keyword tidlName int64
syn keyword tidlName float double
syn keyword tidlName time32 time64 timeval32 timeval64
syn keyword tidlName string vector set list queue cmap

syn keyword tidlConstraint min max local optional componentId typeId typeIdRef
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
" Define the default highlighting {{{
" For version 5.7 and earlier: Only when not done already
" For version 5.8 and later: Only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_config_syntax_inits")
  if version < 508
    let did_config_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink tidlComment           Comment
  HiLink tidlTodo              Todo
  HiLink tidlKey               Statement
  HiLink tidlAssign            Special
  HiLink tidlBlockBegin        Special
  HiLink tidlBlockEnd          Special
  HiLink tidlNow               Constant
  HiLink tidlName              Type
  HiLink tidlConstraint        Special
  delcommand HiLink
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
let b:current_syntax = "tidl"
