#! /bin/bash

# $() 和 `` 都可以存放命令变量
# if [ `ps -ef | grep -c 'ssh'` -gt 1 ]
if [ $(ps -ef | grep -c 'ssh') -gt 1 ]
then
    echo '大于1'
fi