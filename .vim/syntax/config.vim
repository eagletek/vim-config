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
  if exists("b:current_syntax")
    finish
  endif
else
  " Croak when an old Vim is sourcing us.
  echo "Sorry, but this syntax file relies on Vim 6 features.  Either upgrade Vim or use a version of " . expand("<sfile>:t:r") . " syntax file appropriate for Vim " . version/100 . "." . version %100 . "."
  finish
endif

syn case match
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
" Comments {{{
syn match configComment "^\s*#.*$" contains=configTodo
syn keyword configTodo TODO FIXME XXX contained
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
" Base constructs {{{
syn match configColon ":"
syn match configDepends "=>"
syn match configSlash "/"
syn match configExtern "@"
syn match configExternTree "!"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
" key highlight {{{

syn keyword configKey asset_spec_begin asset_spec_end
syn keyword configKey component_path_begin component_path_end
syn keyword configKey include_component
syn keyword configKey extract_component
syn keyword configKey checkout_component

syn keyword configKey component_begin component_end
syn keyword configKey module_begin module_end
syn keyword configKey private_module_begin private_module_end
syn keyword configKey arch_list_begin arch_list_end
syn keyword configKey archive_type_begin archive_type_end
syn keyword configKey target_type_begin target_type_end
syn keyword configKey target_rules_begin target_rules_end
syn keyword configKey target_spec_begin target_spec_end
syn keyword configKey private_target_spec_begin private_target_spec_end
syn keyword configKey interface_libs_begin interface_libs_end
syn keyword configKey target_sources
syn keyword configKey target_source_excludes
syn keyword configKey target_source_dir
syn keyword configKey target_shared_libs_arches
syn keyword configKey target_includes
syn keyword configKey target_xcpp_flags
syn keyword configKey target_dependencies
syn keyword configKey target_linked_arches
syn keyword configKey target_external_libs
syn keyword configKey target_main_class

syn keyword configName indep native doxygen ccxx vxworks rtp java autoconf lib test_lib bin test_bin include
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

  HiLink configComment           Comment
  HiLink configTodo              Todo
  HiLink configKey               Statement
  HiLink configColon             Special
  HiLink configDepends           Keyword
  HiLink configSlash             Special
  HiLink configExtern            Constant
  HiLink configExternTree        Constant
  HiLink configName              Type
  delcommand HiLink
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
let b:current_syntax = "config"
