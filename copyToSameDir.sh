#!/bin/bash
#将指定扩展的文件复制到同一目录，并根据数字编号重命名
if [ $# -lt 2 ]
then
	echo "copyToSameDir.sh sourceDir targetDir ext1 [ext2 ...]"
fi
n=1
path=$1
target=$2
cnt=2

#find $path -name '*.jpg' -and -name '*.png' -and -name 'jpeg' -and -name '*.gif' -and -name '*.JPG' > temp.txt

touch temp.txt
for i in $@
do
	if [ $cnt -eq 0 ] 
	then
		echo "ext = "$i
		find $path -name "*.$i" >>temp.txt
	else
		let cnt=cnt-1
	fi
done
while read line
do
	filename=`echo $line | awk -F"/" '{print $NF}'`
	ext=`echo $filename | awk -F"." '{print $NF}'`
	filename=$dist'/'$n'.'$ext
	cp "$line" "$target/$filename"
	let n=n+1
done<temp.txt
rm temp.txt
