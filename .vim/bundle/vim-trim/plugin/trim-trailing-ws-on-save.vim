func! RemoveTrailingWS()
    let l:save_cursor=getpos('.')
    :%s/\s\+$//ge
    call histdel('search', -1)
    call setpos('.', l:save_cursor)
endfunc

autocmd BufWrite * call RemoveTrailingWS()

