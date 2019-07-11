# Shell 指令

> Debian 下的指令其实与其它 linux 发行版本的并没有太大区别，都是指 Shell 指令，不过有些旧指令在 Debian10 中可能并不适用。

```text
建议：http://man.linuxde.net/ 网站收集了大量的linux指令并且对其分类，大家也可以去参考学习。
```

## linux 类型参数列表

> linux 类型参数列表分为下表 7 类：

| 类型 | 描述         |
| ---- | ------------ |
| -    | 普通文件     |
| f    | 普通文件     |
| d    | 目录         |
| l    | 符号链接     |
| c    | 字符设备节点 |
| b    | 块设备节点   |
| p    | 命名管道     |
| s    | 套接字       |

## 基本的 Unix 命令

> 参考地址：https://www.debian.org/doc/manuals/debian-reference/ch01.zh-cn.html#_basic_unix_commands

| 命令                           | 说明                                                                                                  |
| ------------------------------ | ----------------------------------------------------------------------------------------------------- |
| pwd                            | 显示当前/工作目录的名称                                                                               |
| whoami                         | 显示当前的用户名                                                                                      |
| id                             | 显示当前用户的身份（名称、uid、gid 和相关组）                                                         |
| file <foo>                     | 显示“<foo>”文件的文件类型                                                                             |
| type -p <commandname>          | 显示“<commandname>”命令的文件所处位置                                                                 |
| which <commandname>            | 同上                                                                                                  |
| type <commandname>             | 显示“<commandname>”命令的相关信息                                                                     |
| apropos <key-word>             | 查找与“<key-word>”有关的命令                                                                          |
| man -k <key-word>              | 同上                                                                                                  |
| whatis <commandname>           | 用一行解释 “<commandname>” 命令                                                                       |
| man -a <commandname>           | 显示“<commandname>”命令的解释（Unix 风格）                                                            |
| info <commandname>             | 显示“<commandname>”命令相当长的解释（GNU 风格）                                                       |
| ls                             | 显示目录内容（不包含以 . 点号开头的文件和目录）                                                       |
| ls -a                          | 显示目录内容（包含所有文件和目录）                                                                    |
| ls -A                          | 显示目录内容（包含几乎所有文件和目录，除了“..”和“.”）                                                 |
| ls -la                         | 显示所有的目录内容，并包含详细的信息                                                                  |
| ls -lai                        | 显示所有的目录内容，并包含 inode 和详细的信息                                                         |
| ls -d                          | 显示当前目录下的所有目录                                                                              |
| tree                           | 使用树状图显示目录内容                                                                                |
| lsof <foo>                     | 列出处于打开状态的文件 "<foo>"                                                                        |
| lsof -p <pid>                  | 列出被某进程打开的文件: "<pid>"                                                                       |
| mkdir <foo>                    | 在当前目录中建立新目录“<foo>”                                                                         |
| rmdir <foo>                    | 删除当前目录中的“<foo>”目录                                                                           |
| cd <foo>                       | 切换到当前目录下或变量“\$CDPATH”中的“<foo>”目录                                                       |
| cd /                           | 切换到根目录                                                                                          |
| cd                             | 切换到当前用户的家目录                                                                                |
| cd /<foo>                      | 切换到绝对路径为“/<foo>”的目录                                                                        |
| cd ..                          | 切换到上一级目录                                                                                      |
| cd ~<foo>                      | 切换到用户“<foo>”的家目录                                                                             |
| cd -                           | 切换到之前的目录                                                                                      |
| </etc/motd pager               | 使用默认的分页程序来显示“/etc/motd”的内容                                                             |
| touch <junkfile>               | 建立一个空文件“<junkfile>”                                                                            |
| cp <foo> <bar>                 | 将一个现有文件“<foo>”复制到一个新文件“<bar>”                                                          |
| rm <junkfile>                  | 删除文件“<junkfile>”                                                                                  |
| mv <foo> <bar>                 | 将一个现有文件“<foo>”重命名成“<bar>”（“<bar>”必须不存在）                                             |
| mv <foo> <bar>                 | 将一个现有文件“<foo>”移动到新的位置“<bar>/<foo>”（必须存在“<bar>”目录）                               |
| mv <foo> <bar>/<baz>           | 移动一个现有文件“<foo>”到新位置并重命名为“<bar>/<baz>”（必须存在“bar”目录，且不存在“bar>/<baz>文件”） |
| chmod 600 <foo>                | 使其他人无法读写现有文件“<foo>”（并且所有人都无法执行该文件）                                         |
| chmod 644 <foo>                | 使其他人对现有文件“<foo>”可读但不可写（并且所有人都无法执行该文件）                                   |
| chmod 755 <foo>                | 使其他人对“<foo>”可读而不可写（并且所有人都能执行该文件）                                             |
| find . -name <pattern>         | 使用 shell “<pattern>” 查找匹配的文件名（速度较慢）                                                   |
| locate -d . <pattern>          | 使用 shell “<pattern>” 查找匹配的文件名（速度较快，使用定期生成的数据库）                             |
| `grep -e "<pattern>" *.html`   | 在当前目录下以“.html”结尾的所有文件中，查找匹配“<pattern>”的文件并显示                                |
| top                            | 全屏显示进程信息，输入“q”退出                                                                         |
| `ps aux | pager`               | 显示所有正在运行的进程的信息（BSD 风格）                                                              |
| `ps -ef | pager`               | 显示所有正在运行的进程的信息（Unix system-V 风格）                                                    |
| `ps aux | grep -e "[e]xim4*"`  | 显示所有正在运行“exim”和“exim4”的进程                                                                 |
| `ps axf | pager`               | 显示所有正在运行的进程的信息（ASCII 风格）                                                            |
| kill <1234>                    | 杀死 ID 为“<1234>”的进程                                                                              |
| gzip <foo>                     | 使用 Lempel-Ziv 编码（LZ77）将“<foo>”压缩为“<foo>.gz”                                                 |
| gunzip <foo>.gz                | 将“<foo>.gz”解压为“<foo>”                                                                             |
| bzip2 <foo>                    | 使用 Burrows-Wheeter 块排序压缩算法和 Huffman 编码将“<foo>”压缩为“<foo>.bz2”（压缩效果比 gzip 更好）  |
| bunzip2 <foo>.bz2              | 将“<foo>.bz2”解压为“<foo>”                                                                            |
| xz <foo>                       | 使用 Lempel-Ziv-Markov 链算法将“<foo>”压缩为“<foo>.xz”（压缩效果比 bzip2 更好）                       |
| unxz <foo>.xz                  | 将“<foo>.xz”解压为“<foo>”                                                                             |
| tar -xvf <foo>.tar             | 从“<foo>.tar”档案中提取文件                                                                           |
| tar -xvzf <foo>.tar.gz         | 从被 gzip 压缩过的“<foo>.tar.gz”档案中提取文件                                                        |
| tar -xvjf <foo>.tar.bz2        | 从“<foo>.tar.bz2”档案中提取文件                                                                       |
| tar -xvJf <foo>.tar.xz         | 从“<foo>.tar.xz”档案中提取文件                                                                        |
| tar -cvf <foo>.tar <bar>/      | 将目录“<bar>/”中的内容打包到“<foo>.tar”档案中                                                         |
| tar -cvzf <foo>.tar.gz <bar>/  | 将目录 “<bar>/” 中的内容打包并压缩成 “<foo>.tar.gz” 文件                                              |
| tar -cvjf <foo>.tar.bz2 <bar>/ | 将目录“<bar>/”中的内容打包到“<foo>.tar.bz2”档案中                                                     |
| tar -cvJf <foo>.tar.xz <bar>/  | 将目录”<bar>/“中的内容打包到”<foo>.tar.xz“档案中                                                      |
| `zcat README.gz | pager`       | 使用默认的分页程序来显示 “README.gz” 压缩包中的内容                                                   |
| zcat README.gz > foo           | 将“README.gz”解压后的内容输出到文件“foo”中                                                            |
| zcat README.gz >> foo          | 将“README.gz”解压后的内容添加到文件“foo”的末尾（如果文件不存在，则会先建立该文件）                    |

## 案例说明

> 这里我们只给大家一些案例，指令的具体操作，可以自行去网上查看

```text
常见执行Linux命令的格式是这样的:
    - 命令名称 [命令参数] [命令对象]
```

### 文件搜索的组合应用

> 会使用到的指令及其说明：

| 指令  | 描述             |
| ----- | ---------------- |
| xargs | 用于组合多个指令 |
| find  | 查询指定的文件   |
| grep  | 查询文件的内容   |
| exec  | 执行指令         |

1. 搜索并输出行

> /server/conf 目录下搜索所有 .conf 格式的文件，打印出带有 www.debian.org 的文件名+行内容：

```shell
$ find /server/conf -name "*.conf" -type "f" | xargs grep "www\.debian\.org"
```

> /server/conf 目录下搜索所有 .conf 格式的文件，打印出带有 www.debian.org 的文件名+行内容（内容不区分大小写）：

```shell
$ find /server/conf -name "*.conf" | xargs grep "www\.debian\.org" -i
```

> /server/conf 目录下搜索所有 .conf 格式的文件，仅打印出带有 www.debian.org 的文件名：

```shell
$ find /server/conf -name "*.conf" | xargs grep "www\.debian\.org" -l
```

> /server/conf 目录下搜索所有 .conf 格式的文件，仅打印出带有 www.debian.org 的文件名（内容不区分大小写）：

```shell
$ find /server/conf -name "*.conf" | xargs grep "www\.debian\.org" -il
```
