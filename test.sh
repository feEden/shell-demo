#!/bin/sh

# 数值测试
a=22
b=32
# if [ $a==$b ]
if test $a -eq $b
then
    echo '两个数字相等'
else
    echo '不相等'
fi
result=`expr $a + $b`
echo $result

# 字符串测试
str1=''
str2='song'
if test -z $str1
then
    echo '字符串的长度为零'
fi
if test -n $str2
then
    echo '不为零'
fi

# 文件测试
file='test.txt'
if test -e $file
then
    echo '文件存在'
    # 判断文件的属性
    if test -r $file
    then
        echo '文件可读'
    fi

    if test -w $file
    then
        echo '文件可写'
    fi

    if test -x $file
    then
        echo '文件可执行'
    fi

    if test -s $file
    then
        echo '文件不为空'
    fi
else
    echo `touch test.txt`
fi