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

function DownloadAnyWithoutNewTab(fname)
    call Ftp(a:fname, 'get')
endfunction

function UploadAny(fname)
    call Ftp(a:fname, 'put')
endfunction

function ExecuteForAllTabs(f)
    redir => message
    silent execute "tabs"
    redir END
    let messages = split(message,'\n')
    for i in messages
        if i !~ '^Tab'
            call eval(a:f.'("'.i[4:].'")')
        endif
    endfor
endfunction

function ExecuteForAllBuffers(f)
    redir => message
    silent execute "buffers"
    redir END
    let messages = split(message,'\n')
    for i in messages
            call eval(a:f.'("'.matchstr(i, '".*"')[1:-2].'")')
    endfor
endfunction

function DownloadAllTabs()
    call ExecuteForAllTabs('DownloadAnyWithoutNewTab')
    execute "tabdo e"
endfunction

function UploadAllTabs()
    call ExecuteForAllTabs('UploadAny')
endfunction

function DownloadAllBuffers()
    call ExecuteForAllBuffers('DownloadAnyWithoutNewTab')
    execute "bufdo e"
endfunction

function UploadAllBuffers()
    call ExecuteForAllBuffers('UploadAny')
endfunction
