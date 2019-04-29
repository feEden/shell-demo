#! /bin/bash

echo '请输入:'
read num
case $num in
    1) echo '你输入了1'
    ;;
    2) echo '你输入了2'
    ;;
    3) echo '你输入了3'
    ;;
    *) echo "你输入了${num}"
    ;;
esac
