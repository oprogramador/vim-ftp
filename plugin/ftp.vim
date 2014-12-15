function Ftp(action)
    let host = g:ftp_conf['host']
    let user = g:ftp_conf['user']
    let pass = g:ftp_conf['pass']
    let local_base_path = g:ftp_conf['local_base_path']
    let remote_base_path = g:ftp_conf['remote_base_path']
    let silent = g:ftp_conf['silent']
    redir => fname
    silent execute "echo @%"
    redir END
    let fname = fname[1:]
    redir => relative
    silent execute "echo system('vim-ftp-relative_path.sh '.local_base_path.' '.fname)"
    redir END
    let relative = relative[1:]
    let scargs = host.' '.user.' '.pass.' '.local_base_path.' '.remote_base_path.' '.relative[:-2].' '.fname.' '.a:action
    if silent
        silent execute "echo system('vim-ftp-ftp.sh '.scargs)"
    else
        echo system('vim-ftp-ftp.sh '.scargs)
    endif
endfunction

function Download()
    call Ftp('get')
    execute "e"
endfunction

function Upload()
    call Ftp('put')
endfunction
