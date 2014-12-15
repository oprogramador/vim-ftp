vim-ftp

==

This plugin enables downloading and uploading files throw FTP using vim editor.

Installation:

1) Use pathogen, bundle or vundle to download the repository and to include it in vim.

2) Run scripts/startup.sh

Configuration:

Write your ftp settings to the vimrc like following:

let g:vim_sftp_configs = {
\       'local_base_path'  : '/Users/name/sample/',
\       'remote_base_path' : '/var/www/sample/',
\       'user' : 'username',
\       'pass' : 'password',
\       'host' : '127.0.0.1'
\   },

Use:

:call Download() - downloading current file

:call Upload() - downloading current file
