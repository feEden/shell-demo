### 简介
Shell是用C编写的程序，是一种命令语言，也是一种程序设计语言，它提供了一个界面，通过这个界面可以访问操作系统内核提供的服务。
Ken Thompson 的 sh 是第一种 Unix Shell，Windows Explorer 是一个典型的图形界面 Shell。
#### shell脚本
是一种为shell编写的脚本程序
#### 常见的shell
- Bourne Shell（/usr/bin/sh或/bin/sh
- Bourne Again Shell（/bin/bash））--- 易用免费， 大多数linux默认的shell
- C Shell（/usr/bin/csh）
- K Shell（/usr/bin/ksh）
- Shell for Root（/sbin/sh）
#### 所需环境
- 能写代码的文本编辑器
- shell脚本解释器
#### 第一个shell脚本
```
// 指定执行shell脚本的解释器，也就是指定使用哪种shell来执行这个脚本
#! /bin/bash
// 向屏幕输出
echo "hello Shell"
```
##### 执行脚本
- 处理成可执行的程序
    - 使用下面的命令，将保持的shell文件，变成可执行文件
    ```
    # 使脚本具有可执行的权限
    chmod +x ./test.sh
    # 执行脚本
    ./test.sh
    ```
    > 注意：一定要写成`./test.sh`,而不能写成`test.sh`的形式，运行其他二进制文件程序也是一样的，直接写test.sh，会直接去`Path`环境里找有没有配置这个命令，而只有`/bin`,`/sbin`,`/usr/bin`,`/usr/sbin`在Pth中，当前编码的目录如果不在Path中，会提示找不到命令
    
    - 直接作为解释器参数
    ```
    /bin/sh test.sh
    ```
    > 用这种方式执行脚本在编码的时候就不需要用#!指定脚本解释器了
    
### 语法
#### 变量
##### 定义
定义变量需要遵守以下的命名规则：
- 只能使用英文字母，数字和下划线，首个字母不能以数字开头
- 中间不能有空格，可以使用个下划线
- 不能使用标点符号
- 不能使用bash里的关键字（可以使用help命令查看保留的关键字）

> 在给变量赋值的时候，等号两边不允许出现空格

##### 使用变量
- 在定义的变量名之前加`$`即可。
```
name="aaa"
# 建议使用{}讲变量名包裹
echo ${name}
```
- 只有使用变量的时候才需要加`$`,给变量重新赋值不需要
```
username='huangss'
echo ${username}
# 这里会报错
$username='x'
# 这里输出的还是huangss
echo ${username}
```
- 设置变量为只读
```
username='huangss'
readonly username
# 报错 username: 只读变量
username='hahha'

readonly sex='male'
# male
echo ${sex}
sex='female'
# male
echo ${sex}
```
- 使用`unset`删除变量
    - 变量删除后不能再次使用，
    - 不能删除只读变量
```
username='huangss'
readonly username
# 删除变量 无法删除只读
unset username
# 输出huangss
echo ${username}

passwd=1234
unset passwd
# 没有任何输出
echo ${passwd}
```
- 变量类型
    - *局部变量* 局部变量在脚本或命令中定义，仅在当前shell实例中有效，其他shell启动的程序不能访问局部变量。
    - *环境变量* 所有的程序，包括shell启动的程序，都能访问环境变量，有些程序需要环境变量来保证其正常运行。必要的时候shell脚本也可以定义环境变量。
    - *shell变量* shell变量是由shell程序设置的特殊变量。shell变量中有一部分是环境变量，有一部分是局部变量，这些变量保证了shell的正常运行

#### 字符串
##### 使用
可以使用双引号，也可以使用单引号
- 使用双引号
    - 双引号中可以存在变量
    - 可以出现转义字符
- 使用单引号
    - 单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的
    - 单引号字串中不能出现单独一个的单引号（对单引号使用转义符后也不行），但可成对出现，作为字符串拼接使用
```
username="huangss"
age=18
gender='male'
echo "这是一个${gender},叫'${username}',今年\"${age}\"岁"

echo '这是一个'${gender}',叫\"${username}\",今年${age}岁'
```
##### 对字符串的操作
- 获取字符串长度
- 提取子字符串
- 查找字符串
```
person="thisa is male, call huangss, this year 18"
# 获取字符串长度 38
echo ${#person}
# 提取子字符串 hisa
echo ${person:1:4}
# 查找子字符串 查找i或者s 那个先出现返回那个字符的索引 3
# 变量需要用“”， ``执行命令
echo `expr index "${person}" is`
```
#### 数组
只支持一维数组，没有限定数组的大小
- 下标从0开始
- 使用管辖表获取数组中的元素，下标可以是整数，算术表达式，大于等于0
##### 定义数组
```
arrName=(val1 val2 val3.....valn)
```
也可以单独定义数组的每一项
```
arrName[0]=val0
arrName[1]=val1
...
```
可以不使用联系的下标定义数组，而且下标也没有限制
##### 使用数组
1. 使用`${arr[下标]}`读取数组的指定项
2. 使用`${arr[@]}`读取书的所有元素
3. 获取数组的长度
```
# 取得数组元素的个数
length=${#array_name[@]}
# 或者
length=${#array_name[*]}
# 取得数组单个元素的长度
lengthn=${#array_name[n]}
```
#### 注释
1. 单行注释用`#`
2. 多行注释，使用`EOF`
```
:<<EOF
注释内容...
注释内容...
注释内容...
EOF
```
### 传递参数
```
./args.sh 1 2 aa 4
```
在执行脚本的时候，可以指定参数，脚本内可以通过`$n`的形式获取传递的参数值
```
# 测试传递参数
echo "测试shell传递参数"
echo "执行文件名: $0"
echo "参数1: $1"
echo "参数2: $2"

# 输入shell中处理参数的几个特殊的字符
echo "传递到脚本的参数个数: $#"
# "$1 $2 … $n"的形式输出所有参数
echo "传递的所有参数: $*"
echo "运行脚本的当前进程ID: $$"
echo "后台运行的最后一个进程的ID: $!"
# "$1" "$2" … "$n"
echo "返回输入的所有参数: $@"
echo "返回shell使用的当前选项: $-"
echo "显示最后的退出状态，0表示没有错误，其他都是有错误: $?"

# 执行结果：
:<<EOF
测试shell传递参数
执行文件名: ./args.sh
参数1: 1
参数2: 2
传递到脚本的参数个数: 4
传递的所有参数: 1 2 aa 4
运行脚本的当前进程ID: 14082
后台运行的最后一个进程的ID: 
返回输入的所有参数: 1 2 aa 4
返回shell使用的当前选项: hB
显示最后的退出状态，0表示没有错误，其他都是有错误: 0
EOF
```
> $* 与 $@ 区别：

- 相同点：都是引用所有参数。
- 不同点：只有在双引号中体现出来。假设在脚本运行时写了三个参数 1、2、3，，则 " * " 等价于 "1 2 3"（传递了一个参数），而 "@" 等价于 "1" "2" "3"（传递了三个参数）
```
:<<EOF
-- $* 演示 ---
1 2 aa 4
-- $@ 演示 ---
1
2
aa
4
EOF

# 测试 $* 和 $@的区别
echo "-- \$* 演示 ---"
for i in "$*"; do
    echo $i
done

echo "-- \$@ 演示 ---"
for i in "$@"; do
    echo $i
done
```
### 基本运算符
原生的bash不支持简单的数学运算，但可以同其他命令来实现，例如`awk`和`expr`;`expr`一款表达式计算工具，使用它能完成表达式的求职操作。使用使用反引号`将计算的表达包裹

> 有两点需要注意:
- 表达式和运算符之间要有空格，例如 2+2 是不对的，必须写成 2 + 2
- 完整的表达式要被 ` ` 包含

1. 算数运算符
- 支持的运算符号：+ - * / & = == !=
```
#!/bin/bash
a=10
b=20

val=`expr $a + $b`
echo "a + b : $val"

val=`expr $a - $b`
echo "a - b : $val"

# 乘 *需要转义
val=`expr $a \* $b`
echo "a * b : $val"

val=`expr $b / $a`
echo "b / a : $val"

val=`expr $b % $a`
echo "b % a : $val"

if [ $a==$b ]
then
   echo "a 等于 b"
fi

if [ $a!=$b ]
then
   echo "a 不等于 b"
fi

:<<EOF
a + b : 30
a - b : -10
a * b : 200
b / a : 2
b % a : 0
a 不等于 b
EOF
```
> 注意：\
1. 条件表达式要放在[]之间，并且要有空格，例如[ $a == #b ];
2. 乘号(*)前边必须加反斜杠(\)才能实现乘法运算
3. 在 MAC 中 shell 的 expr 语法是：$((表达式))，此处表达式中的 "*" 不需要转义符号 "\"

2. 关系运算符
- 关系运算符只支持数字，不支持字符串，除非字符串的值是数字
- 支持的运算符：
    - -eq: 是否相等,相等返回true；
    - -ne: 是否相等，不相等返回true
    - -gt: 检查左边的是否大于右边的，是返回tue
    - -lt: 检查左边的时候小于右边的，是返回true
    - -ge: 检查左边的是否大于等于右边的，是返回true
    - -le: 检查左边的是否小于右边的，是，返true
```
#!/bin/bash
# 关系表达式运算
a=10;
# 参与运算的需要是整数，或者数字字符串
# b='aa';

if [ $a -eq $b ]
then
   echo "$a -eq $b : a 等于 b"
else
   echo "$a -eq $b: a 不等于 b"
fi
if [ $a -ne $b ]
then
   echo "$a -ne $b: a 不等于 b"
else
   echo "$a -ne $b : a 等于 b"
fi
if [ $a -gt $b ]
then
   echo "$a -gt $b: a 大于 b"
else
   echo "$a -gt $b: a 不大于 b"
fi
if [ $a -lt $b ]
then
   echo "$a -lt $b: a 小于 b"
else
   echo "$a -lt $b: a 不小于 b"
fi
if [ $a -ge $b ]
then
   echo "$a -ge $b: a 大于或等于 b"
else
   echo "$a -ge $b: a 小于 b"
fi
if [ $a -le $b ]
then
   echo "$a -le $b: a 小于或等于 b"
else
   echo "$a -le $b: a 大于 b"
fi

:<<EOF
10 -eq 20: a 不等于 b
10 -ne 20: a 不等于 b
10 -gt 20: a 不大于 b
10 -lt 20: a 小于 b
10 -ge 20: a 小于 b
10 -le 20: a 小于或等于 b
EOF
```
3. 布尔运算符
- 支持的运算
    - !：非运算，表达式为true，返回false
    - -o: 或运算，有一个表达式为true，返回true
    - -a: 与运算，两个表达式都为true，才返回true
```
#!/bin/bash
# 逻辑运算

a=10
b=20

if [ $a != $b ]
then
   echo "$a != $b : a 不等于 b"
else
   echo "$a != $b: a 等于 b"
fi
if [ $a -lt 100 -a $b -gt 15 ]
then
   echo "$a 小于 100 且 $b 大于 15 : 返回 true"
else
   echo "$a 小于 100 且 $b 大于 15 : 返回 false"
fi
if [ $a -lt 100 -o $b -gt 100 ]
then
   echo "$a 小于 100 或 $b 大于 100 : 返回 true"
else
   echo "$a 小于 100 或 $b 大于 100 : 返回 false"
fi
if [ $a -lt 5 -o $b -gt 100 ]
then
   echo "$a 小于 5 或 $b 大于 100 : 返回 true"
else
   echo "$a 小于 5 或 $b 大于 100 : 返回 false"
fi

:<<EOF
10 != 20 : a 不等于 b
10 小于 100 且 20 大于 15 : 返回 true
10 小于 100 或 20 大于 100 : 返回 true
10 小于 5 或 20 大于 100 : 返回 false
EOF
```
4. 字符串运算符
- 支的运算符
    - &&：表达式两边都为true，返回true 
    - ||：一个为true就返回true
```
#!/bin/bash
# 逻辑运算

a=10
b=20

if [[ $a -lt 100 && $b -gt 100 ]]
then
   echo "返回 true"
else
   echo "返回 false"
fi

if [[ $a -lt 100 || $b -gt 100 ]]
then
   echo "返回 true"
else
   echo "返回 false"
fi

:<<EOF
返回 false
返回 true
EOF
```
5. 字符串运算符
- 支持的运算符
    -  =： 检查两边的字符串是否相等，相等返回true
    - !=： 检查两边的字符串是否相等，不相等返回true
    - -z:  检测字符串的长度是否为0，为0返回true
    - -n:  检测字符串的长度是否为0，不为0返回true
    - $:   检测字符串是否为空，不为空返回true
```
#!/bin/bash
# 字符串的运算符号

a="abc"
b="efg"

if [ $a = $b ]
then
   echo "$a = $b : a 等于 b"
else
   echo "$a = $b: a 不等于 b"
fi
if [ $a != $b ]
then
   echo "$a != $b : a 不等于 b"
else
   echo "$a != $b: a 等于 b"
fi
if [ -z $a ]
then
   echo "-z $a : 字符串长度为 0"
else
   echo "-z $a : 字符串长度不为 0"
fi
if [ -n "$a" ]
then
   echo "-n $a : 字符串长度不为 0"
else
   echo "-n $a : 字符串长度为 0"
fi
if [ $a ]
then
   echo "$a : 字符串不为空"
else
   echo "$a : 字符串为空"
fi

:<<EOF
abc = efg: a 不等于 b
abc != efg : a 不等于 b
-z abc : 字符串长度不为 0
-n abc : 字符串长度不为 0
abc : 字符串不为空
EOF
```
6. 文件测试运算符
- 用于检测Unix文件的各种属性
- 支持的运算符
    - -b filename: 检测文件是否是块设备文件
    - -c filename: 检测文件是否是字符设备文件
    - -d filename: 检测文件是否是目录
    - -f filename: 检测文件是否是普通文件
    - -g filename: 检测文件是否设置了SGID位
    - -k filename: 检测文件是否设置了年着位(sticky bit)
    - -p filename: 检测文件是否是有名管道
    - -u filename: 检测文件是否SUID位
    - -r filename: 检测文件是否可读
    - -w filename: 检测文件是否可写
    - -x filename: 检测文件是否可执行
    - -s filename: 检测文件是否为空（文件大小是否大于0）
    - -e filename: 检测文件(包括目录)是否存在
```
#!/bin/sh

# 检测文件的属性

# 在语句后面加;变量会带着;号走
file="/home/huangss/桌面/web-study/shell-demo/operator-file.sh"

if [ -r $file ]
then
   echo "文件可读"
else
   echo "文件不可读"
fi
if [ -w $file ]
then
   echo "文件可写"
else
   echo "文件不可写"
fi
if [ -x $file ]
then
   echo "文件可执行"
else
   echo "文件不可执行"
fi
if [ -f $file ]
then
   echo "文件为普通文件"
else
   echo "文件为特殊文件"
fi
if [ -d $file ]
then
   echo "文件是个目录"
else
   echo "文件不是个目录"
fi
if [ -s $file ]
then
   echo "文件不为空"
else
   echo "文件为空"
fi
if [ -e $file ]
then
   echo "文件存在"
else
   echo "文件不存在"
   touch ${file}
fi
```
> 语句结尾不要用`;`分隔。定义变量的时候，shell解释器读取到的值是带;号的

```
file="/home/huangss/桌面/web-study/shell-demo/operator-file.sh";
file1="/home/huangss/桌面/web-study/shell-demo/operator-file.sh"

# /home/huangss/桌面/web-study/shell-demo/operator-file.sh;
echo ${file}

# /home/huangss/桌面/web-study/shell-demo/operator-file.sh
echo ${file1}
```
### 输出指令echo和printf
- echo 类似PHP的echo
- printf 
    - 模仿 C 程序库（library）里的 printf() 程序。
    - 由 POSIX 标准所定义，因此使用 printf 的脚本比使用 echo 移植性好
    - 语法
    ```
    printf format-string [argments...]
    ```
```
# %s 空格 -10%s 表示10个空格 -表示文字对其的方式 默认右对齐
# %f 单精度数据类型 %4.2f 保留四位有效位数的单精度 .2 小数位
printf "%-10s %-8s %-4s\n"  姓名 性别 体重kg  
printf "%-10s %-8s %-4.2f\n" 郭靖 男 66.1234 
printf "%-10s %-8s %-4.2f\n" 杨过 男 48.6543 
printf "%-10s %-8s %-4.2f\n" 郭芙 女 47.9876 
```
### test指令
test指令用于检查某个条件是否成立，可以说进行数值、字符和文件三方面的测试
#### 数值测试
- 测试命令
    - -eq 等于为真
    - -ne 不等于为真
    - -gt 大于为真
    - -lt 小于为真
```
#!/bin/sh
a=22
b=32
# if [ $a==$b ]
if test $a -eq $b
then
    echo '两个数字相等'
else
    echo '不相等'
fi
```
#### 字符串测试
- 测试命令
    - = 等于为真
    - != 不等于为真
    - -z 字符串 字符串的长度为零则为真
    - -n 字符串 字符串的长度不为零为真
```
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
```
#### 文件测试
- 测试指令
    - -e 文件名 存在为真
    - -r 文件名 文件存在且可读为真
    - -w 文件名 文件存在且可写为真
    - -x 文件名 文件存在且可执行为真
    - -s 文件名 文件存在且至少有一个字符为真
    - -d 文件名 文件存在且为目录则为真
    - -f 文件名 文件存在且为普通文件则为真
    - -c 文件名 文件存在且为字符类文件则为真
    - -b 文件名 文件存在且为块特殊文件则为真
```
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
```
#### 逻辑判断
用于将测试条件连接起来，其优先级为："!"最高，"-a"次之，"-o"最低
- 测试指令
    - -a 逻辑与
    - -o 逻辑或
    - ！ 逻辑非

### 流程控制
- 分支不能为空，没有就不要写
- let 命令：执行一个或多个表达式，变量计算中不需要加上`$`来表示变量
- util循环：条件为true 停止，。为false， 继续
- case ...in ... esac, 类似于switch...case
```
#! /bin/bash

echo '请输入:'
read num
case $num in
    1) echo '你输入了1'
    # 表示break
    ;;
    2) echo '你输入了2'
    ;;
    3) echo '你输入了3'
    ;;
    *) echo "你输入了${num}"
    ;;
esac
```
- break 跳出所有循环    continue 跳出当前循环

### 函数
- 定义
```
[function] funcname [()]{
    [return int;]
}
```
- `function`可选
- 函数返回值，默认将以最后一条命令的运行结果作为返回值，`return`后面跟数值n(0-255)
- 函数返回值通过`$?`获得
- 10个以后的参数，需要通过`${n}`n>=10获取

### 文件输入输出
0 是标准输入（STDIN），1 是标准输出（STDOUT），2 是标准错误输出（STDERR）
- 重定向
    - 一般情况下，每个 Unix/Linux 命令运行时都会打开三个文件：
        * 标准输入文件(stdin)：stdin的文件描述符为0，Unix程序默认从stdin读取数据。
        * 标准输出文件(stdout)：stdout 的文件描述符为1，Unix程序默认向stdout输出数据。
        * 标准错误文件(stderr)：stderr的文件描述符为2，Unix程序会向stderr流中写入错误信息。
    - 默认情况下，command > file 将 stdout 重定向到 file，command < file 将stdin 重定向到 file。
- 屏蔽输出，可以将输入重定向到`/dev/null`，`/dev/null`是一个特殊的文件，写入的内容都会被丢弃
- Here Document
    - 语法形式
    ```
    command << delimiter
    document
    delimiter
    ```
    - 作用：将document作为标准输入的内容，传递给command
- 将标准输入和输出均重定向
```
command < file1 > file2
```
- 将标准错误重定向输出
```
command 2 >> file
```
- 将标准输出(stdout)和标准错误(stderr)输出合并重定向到file
```
command >> file 2 >&1
```
### 文件包含
`.`/`source` 需要引入的文件
```
#inclede1.sh
#!/bin/bash
url="http://www.baidu.com"

# include2.sh
#!/bin/bash

#. './include1.sh'
source './include1.sh'

echo $url
```
> 被包含的文件可以不需要可执行权限

### [Linux命令大全](https://www.runoob.com/linux/linux-command-manual.html)