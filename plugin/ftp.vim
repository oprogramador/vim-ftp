function Download()
    let host = g:ftp_conf['host']
    let user = g:ftp_conf['user']
    let pass = g:ftp_conf['pass']
    let local_base_path = g:ftp_conf['local_base_path']
    let remote_base_path = g:ftp_conf['remote_base_path']
    redir => fname
    silent execute "echo @%"
    redir END
    let fname = fname[1:]
    redir => relative
    silent execute "echo system('relative_path.sh '.local_base_path.' '.fname)"
    redir END
    let relative = relative[1:]
    echo 'ftp='.host
    echo 'fname='.fname
    echo 'relative='.relative
    echo 'relative.len='.len(relative) 
    echo 'fname.len='.len(fname) 
    echo 'join='.remote_base_path[:-2].relative[:-2]
    let scargs = host.' '.user.' '.pass.' '.local_base_path.' '.remote_base_path[:-2].relative[:-2].' '.fname.' get'
    echo 'scargs='.scargs
    echo system('ftp.sh '.scargs)
endfunction
