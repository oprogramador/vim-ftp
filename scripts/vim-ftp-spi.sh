dir=$2
touch $1 &&
cp $1 $dir/$(date +'%Y-%m-%d_%H-%M-%S')_@$(vim-ftp-cut256.sh $(realpath $1 | sed 's/\//___/g'))
