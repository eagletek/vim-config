" CppToolkit.vim
" Brief: Usefull tools for C++ code template generation
" Version: 0.1
" Date: 12/06/12
" Author: Josh O'Connell
"
" Purposes defined :
"
" Generate copyright/licensing text.
"
" Generate a header include guard.
"
" Generate a class definition skeleton. 
"
" Generate an interface definition skeleton (Abstract base class).
"
" To customize the output of the script, see the g:CppToolkit_*
" variables in the script's source.  These variables can be set in your
" .vimrc. 
"
" For example, my .vimrc contains:
" let g:CppToolkit_authorName="Josh O'Connell"
" let g:CppToolkit_companyName="Argon ST, Inc."
" let g:CppToolkit_licenseTag = "Copyright (C) \<enter>"
" let g:CppToolkit_licenseTag = g:CppToolkit_licenseTag . "This data is the property of Argon ST, Inc.  It shall not be disclosed,\<enter>"
" let g:CppToolkit_licenseTag = g:CppToolkit_licenseTag . "reproduced, copied, distributed or used (either partially or wholly) in\<enter>"
" let g:CppToolkit_licenseTag = g:CppToolkit_licenseTag . "any manner without the prior written authorization of Argon ST, Inc.\<enter>"
"

if v:version < 700
    finish
endif 

" Verify if already loaded
"if exists("loaded_CppToolkit")
"	echo 'CppToolkit Already Loaded.'
"	finish
"endif
let loaded_CppToolkit = 1
"echo 'Loading CppToolkit...'

" Default GPL license
let s:licenseTag = "Copyright (C) \<enter>"
let s:licenseTag = s:licenseTag . "This program is free software; you can redistribute it and/or\<enter>"
let s:licenseTag = s:licenseTag . "modify it under the terms of the GNU General Public License\<enter>"
let s:licenseTag = s:licenseTag . "as published by the Free Software Foundation; either version 2\<enter>"
let s:licenseTag = s:licenseTag . "of the License, or (at your option) any later version.\<enter>\<enter>"
let s:licenseTag = s:licenseTag . "This program is distributed in the hope that it will be useful,\<enter>"
let s:licenseTag = s:licenseTag . "but WITHOUT ANY WARRANTY; without even the implied warranty of\<enter>"
let s:licenseTag = s:licenseTag . "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\<enter>"
let s:licenseTag = s:licenseTag . "GNU General Public License for more details.\<enter>\<enter>"
let s:licenseTag = s:licenseTag . "You should have received a copy of the GNU General Public License\<enter>"
let s:licenseTag = s:licenseTag . "along with this program; if not, write to the Free Software\<enter>"
let s:licenseTag = s:licenseTag . "Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.\<enter>"

" Common standard constants
if !exists("g:CppToolkit_licenseTag")
	let g:CppToolkit_licenseTag = s:licenseTag
endif

""""""""""""""""""""""""""
" License comment
""""""""""""""""""""""""""
function! <SID>CppLicenseFunc()
	" Test authorName variable
	if !exists("g:CppToolkit_companyName")
		let g:CppToolkit_companyName = input("Enter name of the copyright holder : ")
	endif
	mark d
	let l:date = strftime("%Y")
	exec "normal O"."/* \<enter>".substitute( g:CppToolkit_licenseTag, "\<enter>", "\<enter>", "g" )
    exec "normal a"."/"
	"if( g:CppToolkit_licenseTag == s:licenseTag )
		exec "normal %jA".l:date."\<enter>".g:CppToolkit_companyName
	"endif
	exec "normal `d"
endfunction

""""""""""""""""""""""""""
" Include Guards
""""""""""""""""""""""""""
function! <SID>CppIncludeGuardFunc(guardName)

	exec "normal gg"
    exec "normal I#ifndef ".a:guardName."\<enter>"
    exec "normal I#define ".a:guardName."\<enter>"
	mark d
    exec "normal G"
    exec "normal o#endif //".a:guardName
	exec "normal `d"

endfunction

""""""""""""""""""""""""""
" Class skeleton
""""""""""""""""""""""""""
function! <SID>CppClassFunc(className)

    exec "normal Oclass ".a:className." "
    mark d
    exec "normal o{"
    exec "normal opublic:"
    exec "normal o".a:className."();"
    exec "normal o".a:className."(const ".a:className."& rhs);"
    exec "normal o~".a:className."();"
    exec "normal o".a:className."& operator=(const ".a:className."& rhs);"
    exec "normal o\<enter>private:"
    exec "normal o};"
	exec "normal `d"
    "startinsert!

endfunction

""""""""""""""""""""""""""
" Interface skeleton
""""""""""""""""""""""""""
function! <SID>CppInterfaceFunc(className)

    exec "normal Oclass ".a:className
    exec "normal o{"
    exec "normal opublic:"
    exec "normal ovirtual ~".a:className."() { }"
    exec "normal o};"
    exec "normal Ovirtual "
    startinsert!

endfunction

"""""""""""""""""""""""""""""""""""
" Simple warning message function
"""""""""""""""""""""""""""""""""""
function! s:WarnMsg( msg )
  echohl WarningMsg
  echo a:msg
  echohl None
  return
endfunction

function! <SID>CppHeaderFunc(guardName)

    :call <SID>CppIncludeGuardFunc(a:guardName)
    :call <SID>CppLicenseFunc()

endfunction

function! <SID>CppSourceFunc()

	exec "normal gg"
    :call <SID>CppLicenseFunc()

endfunction

""""""""""""""""""""""""""
" Shortcuts...
""""""""""""""""""""""""""
command! -nargs=0 CppLic :call <SID>CppLicenseFunc()
command! -nargs=1 CppGuard :call <SID>CppIncludeGuardFunc(<q-args>)
command! -nargs=1 CppClass :call <SID>CppClassFunc(<q-args>)
command! -nargs=1 CppInterface :call <SID>CppInterfaceFunc(<q-args>)
command! -nargs=1 CppHeader :call <SID>CppHeaderFunc(<q-args>)
command! -nargs=0 CppSource :call <SID>CppLicenseFunc()
