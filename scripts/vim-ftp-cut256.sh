str=$1
n=100
len=${#str}
if ((len>n)); then
	echo ${str:len - $n}
else
	echo $str
fi
