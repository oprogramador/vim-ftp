function Redir(args)
    redir => message
    silent execute a:args
    redir END
    return message[1:]
endfunction

function ThisFile()
    return Redir('echo @%')
endfunction

function GetCmd(cmd)
    return Redir("echo system('".a:cmd."')")
endfunction

function Ftp(fname, action)
    let host = g:ftp_conf['host']
    let user = g:ftp_conf['user']
    let pass = g:ftp_conf['pass']
    let local_base_path = g:ftp_conf['local_base_path']
    let remote_base_path = g:ftp_conf['remote_base_path']
    let silent = g:ftp_conf['silent']
    let relative = GetCmd('vim-ftp-relative_path.sh '.local_base_path.' '.a:fname)
    let scargs = host.' '.user.' '.pass.' '.local_base_path.' '.remote_base_path.' '.relative[:-2].' '.a:fname.' '.a:action
    if silent
        silent execute "echo system('vim-ftp-ftp.sh '.scargs)"
    else
        echo system('vim-ftp-ftp.sh '.scargs)
    endif
endfunction

function Download()
    call Ftp(ThisFile(), 'get')
    execute "e"
endfunction

function Upload()
    call Ftp(ThisFile(), 'put')
endfunction

function DownloadAny(fname)
    call Ftp(a:fname, 'get')
    exec 'tabedit '.a:fname
    execute "e"
endfunction

function UploadAny(fname)
    call Ftp(a:fname, 'put')
endfunction
