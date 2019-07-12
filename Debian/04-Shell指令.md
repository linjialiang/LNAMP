# Shell 指令

> Debian 下的指令其实与其它 linux 发行版本的并没有太大区别，都是指 Shell 指令，不过有些旧指令在 Debian10 中可能并不适用。

```text
建议：http://man.linuxde.net/ 网站收集了大量的linux指令并且对其分类，大家也可以去参考学习。
```

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
| rm    | 删除指令         |
| sed   | 编辑文件内容     |
| cat   | 显示文件内容     |

1. 输出文件名+行内容

   > 对 /server/conf 目录下所有 .conf 格式的文件进行搜索，打印出带有 www.debian.org 内容的文件的【文件名+行内容】：

   ```shell
   # 普通版
   $ find /server/conf -name "*.conf" -type "f" | xargs grep "www\.debian\.org"

   # 内容不区分大小写
   $ find /server/conf -name "*.conf" -type "f" | xargs grep "www\.debian\.org" -i

   # 文件名及文件格式不区分大小写
   $ find /server/conf -iname "*.conf" -type "f" | xargs grep "www\.debian\.org"
   ```

2. 仅输出文件名

   > 对 /server/conf 目录下所有 .conf 格式的文件进行搜索，仅打印出带有 www.debian.org 内容的文件的【文件名】：

   ```shell
   # 普通版
   $ find /server/conf -name "*.conf" -type "f"| xargs grep "www\.debian\.org" -l

   # 列出不符合的文件列表(grep 的 -L 参数是取反)
   $ find /server/conf -name "*.conf" -type "f"| xargs grep "www\.debian\.org" -L

   # 内容不区分大小写
   $ find /server/conf -name "*.conf" -type "f"| xargs grep "www\.debian\.org" -il

   # 文件名及文件格式不区分大小写
   $ find /server/conf -iname "*.conf" -type "f"| xargs grep "www\.debian\.org" -l

   # 查找当前目录下的所有文件中是否含有字符串 `debian.org`，并且只打印出文件名
   $ find . -type "f"|xargs grep "kccms" -il
   ```

3. 删除文件

   > 对 /server/conf 目录下所有 .conf 格式的文件进行搜索，并删除带有 www.debian.org 的文件：

   ```shell
   $ find /server/conf -name "*.conf" -type "f"| xargs grep "www\.debian\.org" -l | xargs rm -f
   ```

   > 注意：记住删除文件必须仅输出文件名（grep 使用 -l 或 -L 参数 ）

4. 删除目录

   > 搜索 /server/conf 目录下所有以 .conf 结尾的目录，并删除它们

   ```shell
   $ find /server/conf -name "*.conf" -type "d" | xargs rm -rf
   ```

   > 警告：最好不要使用此方法来删除目录，只要条件允许 `/server/conf` 目录也可以删除！

5. 文件拼接

   > 对 /server/conf 目录下所有 .conf 格式的文件进行搜索，并将带有 debian.org 内容的文件拼接到 debian_org.conf 文件下

   ```shell
   $  find /server/conf -name "*.conf" -type "f"| xargs grep "www\.debian\.org" -l | xargs cat {} \; > debian_org.txt
   ```

6. 删除文件内容

   > 对 /server/conf 目录下所有 .conf 格式的文件进行搜索，并将文件内容中的 `^M` 字符去掉

   ```shell
   # 使用 'cat -A file_path' 可以查看特殊元字符
   $find /server/conf -name "*.conf" -type "f"| xargs grep "^M" -l |xargs cat -A

   # 需要安装 dos2unix，仅适用dos文件转unix文件
   $ find /server/conf -name "*.conf" -type "f"| xargs grep "^M" -l |xargs dos2unix

   # sed 版
   $ find /server/conf -name "*.conf" -type "f"| xargs grep "^M" -l |xargs sed -i 's/^M//g'

   # sed 版，仅对每行结尾处的 `^M` 字符进行处理
   $ find /server/conf -name "*.conf" -type "f"| xargs grep -E "^M$" -l |xargs sed -i 's/^M$//g'
   ```

   > 提示：由于 dos 系统没有 `^M` 这个字符编码，所以必须在 unix 下使用快捷键 `C-V C-M` 生成！

### tar 解压缩应用案例

> 会用的指令及其说明

| 指令  | 描述                   |
| ----- | ---------------------- |
| tar   | 打包工具               |
| gzip  | 使 tar 支持 gzip 压缩  |
| bzip2 | 使 tar 支持 bzip2 压缩 |
| cat   | 对分割后的文件进行合并 |
| split | 对打包后的文件进行分割 |

1. tar 分卷打包文件

   > tar 分卷打包选项说明

   | 选项     | 描述                     |
   | -------- | ------------------------ |
   | -c       | 打包                     |
   | -v       | 显示详细信息             |
   | -f       | 指定文件名（打包文件名） |
   | -z       | 打包同时 gzip 压缩包     |
   | -j       | 打包同时 bzip2 压缩包    |
   | split    | 分割                     |
   | split -b | 按字节分割               |
   | split -d | 指定文件名               |

   > tar 分卷打包文件指令

   ```shell
   $ tar -[z|j]cvf - <原文件所在路径> | split -b <指定分卷最大容量，如：500M> -d - <打包文件存放路径>
   ```

   > 将 /server/conf 目录下的所有文件，分卷打包到 /server/www/tar 目录下

   ```shell
   # tar 打包，不压缩
   $ tar -cvf - /server/conf | split -b 10k -d - /server/www/tar/conf.tar.

   # tar 打包，gzip压缩
   $ tar -zcvf - /server/conf | split -b 5k -d - /server/www/tar/conf.tar.gz.

   # tar 打包，bzip2压缩
   $ tar -jcvf - /server/conf | split -b 5k -d - /server/www/tar/conf.tar.bz2
   ```

2. tar 分卷解压

   > tar 分卷打包选项说明

   | 选项       | 描述                       |
   | ---------- | -------------------------- |
   | -v         | 显示详细信息               |
   | -x         | 解包                       |
   | -z         | 对 gzip 压缩包进行解包     |
   | -j         | 对 bzip2 压缩包进行解包    |
   | -C（大写） | 指定包解压后文件的存放目录 |
   | cat        | 合并分割包                 |

   > tar 分卷解压指令

   ```shell
   $ cat <打包文件存放路径> | tar [z|j]xvf -C <解压后的文件存放路径>
   ```

   > 将 /server/www/tar 目录下的分卷打包文件，解压到 /server/tar 目录下

   ```shell
   # tar 解压
   $ cat /server/www/tar/conf.tar.* | tar xv -C /server/tar

   # gzip 解压
   $ cat /server/www/tar/conf.tar.gz.* | tar -zxv -C -p /server/tar.gz

   # bzip2 解压
   $ cat /server/www/tar/conf.tar.bz2.* | tar -jxv -C -p /server/tar.bz2
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

| 命令                             | 说明                                                                                                  |
| -------------------------------- | ----------------------------------------------------------------------------------------------------- |
| `pwd`                            | 显示当前/工作目录的名称                                                                               |
| `whoami`                         | 显示当前的用户名                                                                                      |
| `id`                             | 显示当前用户的身份（名称、uid、gid 和相关组）                                                         |
| `file <foo>`                     | 显示“<foo>”文件的文件类型                                                                             |
| `type -p <commandname>`          | 显示“<commandname>”命令的文件所处位置                                                                 |
| `which <commandname>`            | 同上                                                                                                  |
| `type <commandname>`             | 显示“<commandname>”命令的相关信息                                                                     |
| `apropos <key-word>`             | 查找与“<key-word>”有关的命令                                                                          |
| `man -k <key-word>`              | 同上                                                                                                  |
| `whatis <commandname>`           | 用一行解释 “<commandname>” 命令                                                                       |
| `man -a <commandname>`           | 显示“<commandname>”命令的解释（Unix 风格）                                                            |
| `info <commandname>`             | 显示“<commandname>”命令相当长的解释（GNU 风格）                                                       |
| `ls`                             | 显示目录内容（不包含以 . 点号开头的文件和目录）                                                       |
| `ls -a`                          | 显示目录内容（包含所有文件和目录）                                                                    |
| `ls -A`                          | 显示目录内容（包含几乎所有文件和目录，除了“..”和“.”）                                                 |
| `ls -la`                         | 显示所有的目录内容，并包含详细的信息                                                                  |
| `ls -lai`                        | 显示所有的目录内容，并包含 inode 和详细的信息                                                         |
| `ls -d`                          | 显示当前目录下的所有目录                                                                              |
| `tree`                           | 使用树状图显示目录内容                                                                                |
| `lsof <foo>`                     | 列出处于打开状态的文件 "<foo>"                                                                        |
| `lsof -p <pid>`                  | 列出被某进程打开的文件: "<pid>"                                                                       |
| `mkdir <foo>`                    | 在当前目录中建立新目录“<foo>”                                                                         |
| `rmdir <foo>`                    | 删除当前目录中的“<foo>”目录                                                                           |
| `cd <foo>`                       | 切换到当前目录下或变量“\$CDPATH”中的“<foo>”目录                                                       |
| `cd /`                           | 切换到根目录                                                                                          |
| `cd`                             | 切换到当前用户的家目录                                                                                |
| `cd /<foo>`                      | 切换到绝对路径为“/<foo>”的目录                                                                        |
| `cd ..`                          | 切换到上一级目录                                                                                      |
| `cd ~<foo>`                      | 切换到用户“<foo>”的家目录                                                                             |
| `cd -`                           | 切换到之前的目录                                                                                      |
| `</etc/motd pager`               | 使用默认的分页程序来显示“/etc/motd”的内容                                                             |
| `touch <junkfile>`               | 建立一个空文件“<junkfile>”                                                                            |
| `cp <foo> <bar>`                 | 将一个现有文件“<foo>”复制到一个新文件“<bar>”                                                          |
| `rm <junkfile>`                  | 删除文件“<junkfile>”                                                                                  |
| `mv <foo> <bar>`                 | 将一个现有文件“<foo>”重命名成“<bar>”（“<bar>”必须不存在）                                             |
| `mv <foo> <bar>`                 | 将一个现有文件“<foo>”移动到新的位置“<bar>/<foo>”（必须存在“<bar>”目录）                               |
| `mv <foo> <bar>/<baz>`           | 移动一个现有文件“<foo>”到新位置并重命名为“<bar>/<baz>”（必须存在“bar”目录，且不存在“bar>/<baz>文件”） |
| `chmod 600 <foo>`                | 使其他人无法读写现有文件“<foo>”（并且所有人都无法执行该文件）                                         |
| `chmod 644 <foo>`                | 使其他人对现有文件“<foo>”可读但不可写（并且所有人都无法执行该文件）                                   |
| `chmod 755 <foo>`                | 使其他人对“<foo>”可读而不可写（并且所有人都能执行该文件）                                             |
| `find . -name <pattern>`         | 使用 shell “<pattern>” 查找匹配的文件名（速度较慢）                                                   |
| `locate -d . <pattern>`          | 使用 shell “<pattern>” 查找匹配的文件名（速度较快，使用定期生成的数据库）                             |
| `grep -e "<pattern>" *.html`     | 在当前目录下以“.html”结尾的所有文件中，查找匹配“<pattern>”的文件并显示                                |
| `top`                            | 全屏显示进程信息，输入“q”退出                                                                         |
| `ps aux | pager`                 | 显示所有正在运行的进程的信息（BSD 风格）                                                              |
| `ps -ef | pager`                 | 显示所有正在运行的进程的信息（Unix system-V 风格）                                                    |
| `ps aux | grep -e "[e]xim4*"`    | 显示所有正在运行“exim”和“exim4”的进程                                                                 |
| `ps axf | pager`                 | 显示所有正在运行的进程的信息（ASCII 风格）                                                            |
| `kill <1234>`                    | 杀死 ID 为“<1234>”的进程                                                                              |
| `gzip <foo>`                     | 使用 Lempel-Ziv 编码（LZ77）将“<foo>”压缩为“<foo>.gz”                                                 |
| `gunzip <foo>.gz`                | 将“<foo>.gz”解压为“<foo>”                                                                             |
| `bzip2 <foo>`                    | 使用 Burrows-Wheeter 块排序压缩算法和 Huffman 编码将“<foo>”压缩为“<foo>.bz2”（压缩效果比 gzip 更好）  |
| `bunzip2 <foo>.bz2`              | 将“<foo>.bz2”解压为“<foo>”                                                                            |
| `xz <foo>`                       | 使用 Lempel-Ziv-Markov 链算法将“<foo>”压缩为“<foo>.xz”（压缩效果比 bzip2 更好）                       |
| `unxz <foo>.xz`                  | 将“<foo>.xz”解压为“<foo>”                                                                             |
| `tar -xvf <foo>.tar`             | 从“<foo>.tar”档案中提取文件                                                                           |
| `tar -xvzf <foo>.tar.gz`         | 从被 gzip 压缩过的“<foo>.tar.gz”档案中提取文件                                                        |
| `tar -xvjf <foo>.tar.bz2`        | 从“<foo>.tar.bz2”档案中提取文件                                                                       |
| `tar -xvJf <foo>.tar.xz`         | 从“<foo>.tar.xz”档案中提取文件                                                                        |
| `tar -cvf <foo>.tar <bar>/`      | 将目录“<bar>/”中的内容打包到“<foo>.tar”档案中                                                         |
| `tar -cvzf <foo>.tar.gz <bar>/`  | 将目录 “<bar>/” 中的内容打包并压缩成 “<foo>.tar.gz” 文件                                              |
| `tar -cvjf <foo>.tar.bz2 <bar>/` | 将目录“<bar>/”中的内容打包到“<foo>.tar.bz2”档案中                                                     |
| `tar -cvJf <foo>.tar.xz <bar>/`  | 将目录”<bar>/“中的内容打包到”<foo>.tar.xz“档案中                                                      |
| `zcat README.gz | pager`         | 使用默认的分页程序来显示 “README.gz” 压缩包中的内容                                                   |
| `zcat README.gz > foo`           | 将“README.gz”解压后的内容输出到文件“foo”中                                                            |
| `zcat README.gz >> foo`          | 将“README.gz”解压后的内容添加到文件“foo”的末尾（如果文件不存在，则会先建立该文件）                    |

## Debian 查看系统及内核版本

| shell command       | 说明                                                     |
| ------------------- | -------------------------------------------------------- |
| `uname -a`          | 显示 -m、 -n、 -r、 -s 和 -v 标志指定的所有信息          |
| `uname -r`          | 显示操作系统的发行版号                                   |
| `lsb_release -a`    | 显示 -v、 -i、 -d、 -r 和 -c 标志指定的所有信息          |
| `lsb_release -icr`  | 显示发行版的 id、发行版代号、当前系统是发行版的具体版本  |
| `cat /etc/issue`    | 正常与 `lsb_release -a` 相同（系统内核手动升级后会不同） |
| `cat /proc/version` | 和 `uname -a` 显示的内容相同，显示 linux 内核版本号      |

## apt 常用命令

| apt command                | 说明                                                         |
| -------------------------- | ------------------------------------------------------------ |
| `apt list foo-*`           | 查看 apt 源中是否存在 foo-相关的包                           |
| `apt update`               | 更新软件包档案库元数据                                       |
| `apt upgrade`              | 安装已安装的软件包的候选版本并且不移除任何其它的软件包       |
| `apt dist-upgrade`         | 安装已安装的软件包的候选版本，并且需要的话会移除其它的软件包 |
| `apt install foo`          | 安装"foo"软件包的候选版本以及它的依赖                        |
| `apt remove foo`           | 移除"foo"软件包，但留下配置文件                              |
| `apt autoremove`           | 移除不再需要的自动安装的软件包                               |
| `apt purge foo`            | 清除"foo"软件包的配置文件                                    |
| `apt clean`                | 完全清除本地仓库的软件包检索文件                             |
| `apt autoclean`            | 清除本地仓库中过时软件包的软件包检索文件                     |
| `apt-cache show foo`       | 显示"foo"软件包的详细信息                                    |
| `apt-cache search <regex>` | 搜索匹配 `<regex>` 的软件包`</regex>`                        |
| `apt-mark showmanual`      | 列出手动安装的软件包                                         |

## dpkg 常用命令

| dpkg command       | 说明                                     |
| ------------------ | ---------------------------------------- |
| `dpkg -l`          | 查看当前系统中已经安装的所有软件包的信息 |
| `dpkg -l vim`      | 查看当前系统中已经安装的 vim 的信息      |
| `dpkg -L vim`      | 查看系统中已经安装的 vim 文件的详细列表  |
| `dpkg -s *.deb`    | 查看已经安装的指定软件包的详细信息       |
| `dpkg -S /etc/vim` | 查看系统中的某个文件属于那个软件包;      |
| `dpkg -i *.deb`    | 文件的安装                               |
| `dpkg -r *.deb`    | 文件的卸载                               |
| `dpkg -P *.deb`    | 彻底的卸载 包括软件的配置文件等等        |
| `dpkg -c *.deb`    | 查询 deb 包文件中所包含的文件 rpm -qlp   |
| `dpkg -I *.deb`    | 查询 deb 包的详细信息                    |

## 其它使用命令

> 在实际工作中，这几个命令会大量缩短操作者时间

1. 检查是否安装了 openssh

```shell
$ dpkg --get-selections | grep openssh
```

2. 查看当前 httpd 相关的进程

```shell
$ ps -ef | grep httpd
```

3. 强制关闭进程（按上个指令可以查到进程 id -- PID）

```shell
$ kill -s 9 [PID]
```

| other unix command                 | 说明                 |
| ---------------------------------- | -------------------- |
| `whereis [-bmsu] 文件或者目录名称` | 查看文件的位置       |
| `which 可执行文件名称`             | 查看可执行文件的位置 |
