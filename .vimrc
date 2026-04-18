runtime ftplugin/man.vim

set tabstop=4

function! TmuxYank() abort
    if v:event.operator !=# 'y'
        return
    endif

    let l:data = join(v:event.regcontents, "\n")

    if !empty($TMUX)
        call system('tmux load-buffer -w -', l:data)
    elseif has('clipboard')
        call setreg('+', l:data)
    endif
endfunction

augroup TmuxClipboard
    autocmd!
    autocmd TextYankPost * call TmuxYank()
augroup END