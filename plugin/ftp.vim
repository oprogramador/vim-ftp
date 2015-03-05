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
    echo 'ftp fname='.a:fname
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

function DownloadWithBackup(name)
    call Backup(a:name)
    call Ftp(a:name, 'get')
endfunction

function UploadWithBackup(name)
    call Backup(a:name)
    call Ftp(a:name, 'put')
endfunction

function Download()
    call DownloadWithBackup(ThisFile())
    execute "e"
endfunction

function Upload()
    call UploadWithBackup(ThisFile())
endfunction

function DownloadAny(fname)
    call DownloadWithBackup(a:fname)
    exec 'tabedit '.a:fname
    execute "e"
endfunction

function DownloadAnyWithoutNewTab(fname)
    call DownloadWithBackup(a:fname)
endfunction

function UploadAny(fname)
    echo 'fname='.a:fname
    call UploadWithBackup(a:fname)
endfunction

function ExecuteForAllTabs(f)
    redir => message
    silent execute "tabs"
    redir END
    let messages = split(message,'\n')
    for i in messages
        if i !~ '^Tab'
            echo 'tab='.i[4:]
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

function Backup(name)
    echo system('vim-ftp-spi.sh '.a:name.' '.g:ftp_conf['local_backup_path'])
endfunction

function Tab(name)
    call Backup(a:name)
    exec "tabedit " . a:name
endfunction

command! -nargs=1 -complete=file Tab call Tab('<args>')

function CloseAll()
    redir => message
    silent execute "tabs"
    redir END
    let messages = split(message,'\n')
    for i in messages
        if i !~ '^Tab'
            call Backup(i[4:])
        endif
    endfor
    exec "qa"
endfunction

command! -nargs=0 CloseAll call CloseAll()

function Close()
    redir => message
    silent execute "echo @%"
    redir END
    call Backup(message[1:])
    exec "q"
endfunction

command! -nargs=0 Close call Close()

