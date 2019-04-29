#!/bin/sh
name="huangss"
# 换行\n \c 不换行 默认换行
echo "${name},\n很蠢\c"
echo "是呀是呀"
echo '这个结果讲输入文件中' > test.txt
# 输出命令的执行结果
echo `date`
# 单引号不会解析变量
echo '${name}'
echo `lsof -i tcp:80`
# read 命令 与命令行交互
# 一个一个词组地接收输入的参数，
# 每个词组需要使用空格进行分隔；
# 如果输入的词组个数大于需要的参数个数，
# 则多出的词组将被作为整体为最后一个参数接收
read name;
echo $name