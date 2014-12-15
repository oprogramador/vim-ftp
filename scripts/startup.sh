sudo apt-get install realpath
cd `dirname $0`
sudo find . ! -name `basename $0` -type f -exec cp {} /usr/bin/  \;
