vim-ftp

==

This plugin enables downloading and uploading files throw FTP using vim editor.

Installation:

1) Use pathogen, bundle or vundle to download the repository and to include it in vim.

2) Run scripts/startup.sh

Configuration:

Write your ftp settings to the vimrc like the following:

let g:ftp_conf = {

\       'local_base_path'  : '/home/name/sample/',

\       'local_backup_path' : '/home/name/undo/',

\       'remote_base_path' : '/var/www/sample/',

\       'user' : 'username',

\       'pass' : 'password',

\       'host' : '127.0.0.1',

\       'silent' : 0

\   }


Use:

:call Download() - download current file

:call Upload() - upload current file

:call DownloadAny('file.txt') - download any file

:call UploadAny('file.txt') - upload any file

:call DownloadAllBuffers() - download files in all opened buffers

:call UploadAllBuffers() - upload files in all opened buffers

:call DownloadAllTabs() - download files in all opened tabs

:call UploadAllTabs() - upload files in all opened tabs

Tab - open new file with backup

Close - close current tab with backup

CloseAll - close all opened tabs with backup
