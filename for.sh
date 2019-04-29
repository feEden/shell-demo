#! /bin/bash

count=0;
for file in `ls`
do
    printf "%-s\n" $file
    let count++;
done
echo $count

for((i=1;i<=10;i++));
do
    echo "$i"
done;