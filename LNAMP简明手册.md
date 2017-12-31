# **`LNAMP` 简明手册**

> 这是为自己准备的参考手册，内容涵盖以下几点：

> 1. `Debian` 简明手册；
> 2. `Vim` 简明手册；
> 3. `SSHD` 服务搭建与配置；
> 4. `VSFTPD` 服务搭建与配置；
> 5. `PHP7.x` 安装与配置；
> 6. `mariadb` 安装、配置与管理；
> 7. `Nginx` 高性能web服务安装与配置；
> 8. `Apache2` 高稳定web服务安装与配置。

--------------------------------------------------------------------------------

## **`Debian` 简明手册**

> 介绍了配置lnamp环境，常遇到的Debian知识点

--------------------------------------------------------------------------------

### `Linux` 常用 `shell` 指令

#### 查看系统及内核版本

shell command       | 说明
------------------- | -------------------------------------
`uname -a`          | 显示 -m、 -n、 -r、 -s 和 -v 标志指定的所有信息
`uname -r`          | 显示操作系统的发行版号
`lsb_relese -a`     | 显示 -v、 -i、 -d、 -r 和 -c 标志指定的所有信息
`lsb_relese -icr`   | 显示发行版的id、发行版代号、当前系统是发行版的具体版本
`cat /etc/issue`    | 正常与 `lsb_release -a` 相同（系统内核手动升级后会不同）
`cat /proc/version` | 和 `uname -a` 显示的内容相同，显示linux内核版本号

--------------------------------------------------------------------------------

#### `apt` 常用命令

apt command                | 说明
-------------------------- | ------------------------------
`apt list foo-*`           | 查看apt源中是否存在foo-相关的包
`apt-get update`           | 更新软件包档案库元数据
`apt-get upgrade`          | 安装已安装的软件包的候选版本并且不移除任何其它的软件包
`apt-get dist-upgrade`     | 安装已安装的软件包的候选版本，并且需要的话会移除其它的软件包
`apt-get install foo`      | 安装"foo"软件包的候选版本以及它的依赖
`apt-get remove foo`       | 移除"foo"软件包，但留下配置文件
`apt-get autoremove`       | 移除不再需要的自动安装的软件包
`apt-get purge foo`        | 清除"foo"软件包的配置文件
`apt-get clean`            | 完全清除本地仓库的软件包检索文件
`apt-get autoclean`        | 清除本地仓库中过时软件包的软件包检索文件
`apt-cache show foo`       | 显示"foo"软件包的详细信息
`apt-cache search <regex>` | 搜索匹配 `<regex>` 的软件包`</regex>`
`apt-mark showmanual`      | 列出手动安装的软件包

--------------------------------------------------------------------------------

#### `dpkg` 常用命令

dpkg command       | 说明
------------------ | ------------------------
`dpkg -l`          | 查看当前系统中已经安装的所有软件包的信息
`dpkg -l vim`      | 查看当前系统中已经安装的vim的信息
`dpkg -L vim`      | 查看系统中已经安装的vim文件的详细列表
`dpkg -s *.deb`    | 查看已经安装的指定软件包的详细信息
`dpkg -S /etc/vim` | 查看系统中的某个文件属于那个软件包;
`dpkg -i *.deb`    | 文件的安装
`dpkg -r *.deb`    | 文件的卸载
`dpkg -P *.deb`    | 彻底的卸载 包括软件的配置文件等等
`dpkg -c *.deb`    | 查询deb包文件中所包含的文件 rpm -qlp
`dpkg -I *.deb`    | 查询deb包的详细信息

--------------------------------------------------------------------------------

#### `find & grep & sed` 常用命令

find command                                                     | 说明
---------------------------------------------------------------- | -----------------------------------------------
`find -name "*.php"`                                             | 当前目录下搜索类型为php的所有文
`find . -type "f" -name "file*"`                                 | 当前目录下搜索以file开头的所有文件
`find ./ -type "d" -name "*dir"`                                 | 当前目录下搜索以dir结尾的所有目录
`find /home -type f -name file* -exec ls -l {} \;`               | /home目录下搜索以file开头的所有文件，并打印出文件的属性
`find /home -type "f" -name "file*" -exec mv {} /home/user1 ";"` | /home目录下搜索以file开头的所有文件，并将搜索到的文件移动到/home/user1目录

--------------------------------------------------------------------------------

grep command                          | 说明
------------------------------------- | ------------------------------------------------------------------
`grep "content" *.php`                | 在当前目录中查找php类型文件中包含content字符串的文件，并打印出该字符串的行
`grep -n "content" /home/user1/*.php` | 在/home/user1目录下查找php类型文件中包含content字符串的文件，并打印出该字符串的行（标识出该列数编号）
`grep -i "content" /home/user1/*.php` | 在/home/user1目录下查找php类型文件中包含content（不区分大小写）字符串的文件，并打印出该字符串的行
`grep -r "content" /home/user1/`      | 在/home/user1目录下查找所有文件中包含content字符串的文件，并打印出该字符串的行
`grep -rin "content" /home/user1/`    | 在/home/user1目录下查找所有文件中包含content（不区分大小写）字符串的文件，并打印出该字符串的行（标识出该列数编号）

--------------------------------------------------------------------------------

sed command                             | 说明
--------------------------------------- | -------------------------------------------------------
`sed -i "s/content/hello/p" file0.php`  | 直接编辑文件，会匹配file0.php文件中每一行的第一个 content 替换为 hello
`sed -i "s/content/hello/g" file0.php`  | 直接编辑文件，会匹配file0.php文件中所有的 content 替换为 hello
`sed -i "s/content/hello/i" file0.php`  | 直接编辑文件，会匹配file0.php文件中每一行的第一个 content（不区分大小写） 替换为 hello
`sed -i "s/content/hello/gi" file0.php` | 直接编辑文件，会匹配file0.php文件中所有的 content（不区分大小写） 替换为 hello

--------------------------------------------------------------------------------

1. 在/home/user1目录下查找所有php文件，并搜索包含content（不区分大小写）字符串的文件，并打印出该字符串的行（标识出该列数编号）

  ```shell
  # find /home/user1 -name "*.php" -exec grep -in "content" {} ";"
  ```

2. 在/home/user1目录下查找所有php文件，并搜索包含content（不区分大小写）字符串的文件，并打印出该字符串的行（标识出该列数编号）

  ```shell
  # find /home/user1 -name "*.php" | grep -in "content"
  ```

3. 在/home/user1目录下查找所有php文件，直接编辑匹配的文件，将匹配的文件中所有的 content（不区分大小写） 替换为 Hello

  ```shell
  # find /home/user1 -type "f" -name "*.php" -exec sed -i "s/world/Hello/gi" {} ";"
  ```

4. 查找当前目录下的所有文件中是否含有某个字符串,并且只打印出文件名

  ```shell
  # find .|xargs grep -ri '[FileName]' -l
  ```

--------------------------------------------------------------------------------

### 磁盘分区、格式化与挂载

- 磁盘分区

  1. 列出磁盘与分区情况

    ```shell
    # fdisk -l
    ```

  2. 指定磁盘sdb

    ```shell
    # fdisk /dev/sdb
    ```

  3. 列出磁盘分区情况`p`

    ```shell
    Command (m for help): p
    ```

  4. 通过fdisk的d指令来删除一个分区 `d`

    ```shell
    Command (m for help): d
    Partition number (1-4): 2
    ```

  5. 将表写入磁盘并退出（保存并退出）`w`

    ```shell
    Command (m for help): w
    ```

  6. 退出而不保存更改（退出但不保存）`q`

    ```shell
    Command (m for help): q
    ```

  7. 通过fdisk的n指令增加一个分区 `n`

    ```shell
    Command (m for help): n
    Partition type p primary (0 primary, 0 extended, 4 free) e extended (container for logical partitions) Select (default p): p Partition number (1-4): 1 First cylinder (1-391, default 1): Using default value 1 Last cylinder or +size or +sizeM or +sizeK (1-391, default 391): 100
    ```

    > _<font color="goldenrod">友情提醒 &gt;&gt; <code>First cylinder</code>是分区开始位置， <code>Last cylinder</code>是分区结束位置</font>_

  8. 将表写入磁盘并退出（保存并退出）`w`

    ```shell
    Command (m for help): w
    ```

  9. 退出而不保存更改（退出但不保存）`q`

    ```shell
    Command (m for help): q
    ```

- 磁盘格式化与挂载

  1. 磁盘分区格式化成ext4格式

    ```shell
    # mkfs.ext4 [/dev/sdb2]
    ```

    > _<font color="goldenrod">友情提醒 &gt;&gt;  mkfs.ext4 可以将磁盘分区格式化诚ext4格式</font>_

  2. 挂载分区到指定目录

    ```shell
    # mount [/dev/sdb2] [/home]
    # mount -t ext4 [/dev/sdb2] [/home]
    ```

  3. 卸载分区

    ```shell
    # umount [/dev/sdb2]
    ```

--------------------------------------------------------------------------------

### **为服务器配置网络**

> 服务器的网络，主要是服务器商的事情，这里就写个配置方法，搭建局域网服务器时会用到

1. 备份并打开网络配置文件

  ```shell
  # cp /etc/network/interfaces /etc/network/interfaces.backup
  # vim /etc/network/interfaces
  ```

2. 编辑网络配置文件

  - 有线网卡动态IP

    ```shell
    auto lo
    auto eth0                  # 开机自动连接有线网络

    iface lo inet loopback    
    allow-hotplug eth0        # 支持热插拔网卡，系统启动后,如果插入网线,系统会自动启动该接口
    iface eth0 inet dhcp      # dhcp表示使用动态ip地址上网
    ```

  - 有线网卡固定IP

    ```shell
    auto lo                    
    auto eth0                  # 开机自动连接有线网络

    iface lo inet loopback
    allow-hotplug eth0        # 支持热插拔网卡，系统启动后,如果插入网线,系统会自动启动该接口
    iface eth0 inet static    # static 表示使用固定IP地址上网
    address 192.168.9.100     # 设置静态ip地址
    netmask 255.255.255.0     # 设置子网掩码
    gateway 192.168.9.254     # 设置网关
    ```

  - 无线网卡动态IP

    ```shell
    auto lo
    auto wlan0                 # 开机自动连接无线网络

    iface lo inet loopback
    allow-hotplug eth0        # 支持热插拔网卡，系统启动后,如果插入网线,系统会自动启动该接口
    iface wlan0 inet dhcp     # dhcp表示使用动态ip地址上网
    wpa-ssid ssidName         # 无线账号（必须）
    wpa-psk ssidPassword      # 无线密码
    ```

  - 无线网卡固定IP

    ```shell
    auto lo
    auto wlan0                 # 开机自动连接无线网络

    iface lo inet loopback
    allow-hotplug eth0        # 支持热插拔网卡，系统启动后,如果插入网线,系统会自动启动该接口    
    iface eth0 inet static    # static 表示使用固定IP地址上网
    address 192.168.9.100     # 设置静态ip地址
    netmask 255.255.255.0     # 设置子网掩码
    gateway 192.168.9.254     # 设置网关
    wpa-ssid ssidName         # 无线账号（必须）
    wpa-psk ssidPassword      # 无线密码
    ```

3. 配置服务器的DNS文件

  - 备份并打开dns文件

    ```shell
    # cp /etc/resolv.conf /etc/resolv.conf.backup
    # vim /etc/resolv.conf
    ```

  - 修改dns文件

    ```shell
    nameserver 114.114.114.114
    nameserver 8.8.8.8
    ```

4. 启动网络服务接口

  - 启动网络接口

    ```shell
    # ifup eth0
    # ifup wlan0
    ```

  - 关闭网络接口

    ```shell
    # ifdown eth0
    # ifdown wlan0
    ```

5. 启动与关闭网络服务

  - 启动网络服务器

    ```shell
    # /etc/init.d/networking start
    ```

  - 关闭网络服务器

    ```shell
    # /etc/init.d/networking stop
    ```

  - 重启网络服务器

    ```shell
    # /etc/init.d/networking restart
    # systmctl restart networking.server
    ```

--------------------------------------------------------------------------------

### **配置镜像源**

> 一般这是服务器供应商解决好的，搭建局域网服务器会用到

- 备份并打开镜像源文件

  ```shel
  # cp /etc/apt/sources.list{,.backup}
  # vim /etc/apt/sources.list
  ```

- 修改镜像源文件

  ```shell
  deb http://mirrors.ustc.edu.cn/debian/ stretch main contrib non-free
  deb-src http://mirrors.ustc.edu.cn/debian/ stretch main contrib non-free

  deb http://mirrors.ustc.edu.cn/debian/ stretch-updates main contrib non-free
  deb-src http://mirrors.ustc.edu.cn/debian/ stretch-updates main contrib non-free

  deb http://mirrors.ustc.edu.cn/debian/ stretch-backports main contrib non-free
  deb-src http://mirrors.ustc.edu.cn/debian/ stretch-backports main contrib non-free

  deb http://mirrors.ustc.edu.cn/debian-security/ stretch/updates main contrib non-free
  deb-src http://mirrors.ustc.edu.cn/debian-security/ stretch/updates main contrib non-free
  ```

- 更新镜像软件索引，并更新软件

  ```shell
  # apt-get update
  # apt-get upgrade
  ```

--------------------------------------------------------------------------------

### **配置服务器编码**

> 选择适合的服务器编码语言，一般选择 zh_CN.UTF-8

- 选择系统编码

  ```shell
  # dpkg-reconfigure locales
  ```

- 查看系统编码

  ```shell
  # locale
  ```

--------------------------------------------------------------------------------

### **Debian 常用包**

> 这些比不可少的常用包（就是ms下的软件），让 `linux` 终端变的更加实用

#### `lrzsz` 下载上传软件

> 在linux里可代替ftp上传和下载，支持xshell终端管理软件

> - `rz` 上传文件或压缩包
> - `sz [/path/file]` 下载文件或压缩包

- 安装lrzsz

  ```shell
  # apt-get install lrzsz
  ```

#### `zip & unzip` zip压缩与解压缩包

> `zip` `unzip` 这两个包一个是"压缩与解压缩" "文件或目录"，debian 9.x 默认已经安装

1. 安装 `zip` 与 `unzip`

  ```shell
  # apt-get install zip unzip
  ```

2. `unzip` 命令说明

  - unzip 将 "当前目录" 的压缩包的内容 解压到 "当前目录"

    ```shell
    # unzip file.zip
    ```

  - unzip 将 "当前目录" 的压缩包的内容 解压到 "当前目录"，如果已有相同的文件存在，要求unzip命令不覆盖原先的文件。

    ```shell
    # unzip -n file.zip
    ```

  - unzip 将 "当前目录" 的压缩包的内容 解压到 "当前目录"，如果已有相同的文件存在，要求unzip命令覆盖原先的文件。

    ```shell
    # unzip -o file.zip
    ```

  - unzip 将 "指定目录" 的压缩包的内容 解压到 "指定目录"，如果已有相同的文件存在，要求unzip命令覆盖原先的文件。

    ```shell
    # unzip -o /path1/file.zip -d /path2
    ```

3. `zip` 命令说明

  - zip 将 `指定目录` 下的所有文件和文件夹打包到 `当前目录`

    ```shell
    # zip -q -r file.zip /path1/dir
    ```

#### `tar` 打包、解包，压缩包、解压缩包

> Debian 9.x 系统自带 tar一系列包（包括gzip、bzip2），它是linux平台下最实用的打包工具

1. gzip 压缩与解压缩

  - 特点

    1. gzip 只能压缩文件，不能压缩目录
    2. gzip 压缩后，不保留源文件（tar.gz打包并压缩时就不会有tar打包文件遗留）

  - gzip 操作

    ```shell
    # gzip test.php
    # gunzip test.php.gz
    ```

2. bzip2 压缩与解压缩

  - 特点

    1. bzip2 只能压缩文件，不能压缩目录
    2. bzip2 压缩后，默认不保留源文件（-k 加上就会保留源文件）

  - bzip2 操作

    ```shell
    bzip2 test.php （压缩文件并删除源文件）
    bzip2 -k test.php （压缩文件并保留源文件）
    bunzip2 test.php.gz
    ```

3. tar 打包（1次只能 创建 1个包）

  ```shell
  -c ==> 打包
  -v ==> 显示详细信息
  -f ==> 指定文件名（打包文件名）
  -z ==> 打包同时gzip压缩包
  -j ==> 打包同时bzip2压缩包
  写法 ==> tar -cvf 指定包目录/指定包名 要打包的文件（或目录）所在路径1 被打包文件（或目录）所在路径2 被打包文件（或目录）所在路径3

  示例 ==> tar -cvf home.tar home/
  -- info >> 将 当前目录下的home目录 打包成 home.tar 并存放到当前目录下
  示例 ==> tar -cvf /user1.tar /home/user1/
  -- info >> 将 user1 这1个用户的家目录打包成 user1.tar 并存放在根目录下面
  示例 ==> tar -cvf /user.tar /home/user1/ /home/user2/ /home/user3/
  -- info >> 将 user1、user2、user3 这3个用户的家目录打包成 user.tar 并存放在根目录下面
  示例 ==> tar -zcvf /user.tar.gz /home/user1/ /home/user2/ /home/user3/
  -- info >> 将 user1、user2、user3 这3个用户的家目录 打包并压缩成 /user.tar.gz 并存放在根目录下面（以gzip压缩）
  示例 ==> tar -jcvf /user.tar.bz2 /home/user1/ /home/user2/ /home/user3/
  -- info >> 将 user1、user2、user3 这3个用户的家目录 打包并压缩成 user.tar.bz2 并存放在根目录下面（以bzip2压缩）
  ```

4. tar 解包 （1次只能 释放 1个包）

  ```shell
  -v ==> 显示详细信息
  -f ==> 指定文件名（打包文件名）
  -z ==> gzip解压
  -j ==> bzip2解压
  -C ==> 指定包解压后文件的存放目录
  写法 ==> tar -xvf 包所在目录/包名 [-C 指定包解压后文件的存放目录]

  示例 ==> tar -xvf home.tar
  -- info >> 将当前目录下的 home.tar 解压到当前目录下面
  示例 ==> tar -xvf /user1.tar -C /home/
  -- info >> 将根目录下的 user1.tar 解包到 /home/ 目录下面
  示例 ==> tar -zxvf /user1.tar.gz -C /home/
  -- info >> 将根目录下的 user1.tar 解压到 /home/ 目录下面 （用gunzip解压）
  示例 ==> tar -jxvf /user1.tar.bz2 -C /home/
  -- info >> 将根目录下的 user1.tar 解压到 /home/ 目录下面 （用bunzip2解压）
  ```

5. tar 测试包

  ```shell
  -t ==> 列出包内的内容
  -v ==> 显示详细信息
  -f ==> 指定文件名（打包文件名）
  -z ==> 查看tar.gz压缩包内容
  -j ==> 查看tar.bz2压缩包内容
  写法 ==> tar -tvf 包所在目录/包名

  示例 ==> tar -tvf test1.tar
  -- info >> 列出 test1.tar 包的内容（目录列表+文件列表）
  示例 ==> tar -ztvf test1.tar.gz
  -- info >> 列出 test1.tar.gz 压缩包的内容（目录列表+文件列表）
  示例 ==> tar -jtvf test1.tar.bz2
  -- info >> 列出 test1.tar.bz2 压缩包的内容（目录列表+文件列表）
  ```

6. tar 分卷打包

  ```shell
  -c ==> 打包
  -v ==> 显示详细信息
  -f ==> 指定文件名（打包文件名）
  -z ==> 打包同时gzip压缩包
  -j ==> 打包同时bzip2压缩包
  split ==> 分割
  -- -b >> 按字节分割
  -- -d >> 指定文件名
  写法 ==> tar -cvf - 要打包的路径/文件名（或目录名） | split -b 500M -d - 包存放目录/包文件名

  示例 ==> tar -cvf - user1/ | split -b 500M -d - user1.tar.
  -- info >> 将 user1 的家目录 分卷打包到 当前目录下面 后缀用数字命名 user1.tar.0x
  示例 ==> tar -cvf - /home/user1/ | split -b 500M -d - /user1.tar.
  -- info >> 将 user1 的家目录 分卷打包到 根目录下面 后缀用数字命名 user1.tar.0x
  示例 ==> tar -cvf - /home/user1/ /home/user2/ /home/user3/ | split -b 500M -d - /home.tar.
  -- info >> 将  user1、user2、user3 这3个用户的家目录 分卷打包到 根目录下面 后缀用数字命名 home.tar.0x
  示例 ==> tar -zcvf - /home/user1/ | split -b 500M -d - /user1.tar.gz.
  -- info >> 将 user1 的家目录 分卷压缩到 根目录下面 后缀用数字命名 user1.tar.gz.0x （以gzip压缩）
  示例 ==> tar -jcvf - /home/user1/ | split -b 500M -d - /user1.tar.bz2.
  -- info >> 将 user1 的家目录 分卷压缩到 根目录下面 后缀用数字命名 user1.tar.bz2.0x （以bzip2压缩）
  ```

7. tar 分卷解包

  ```shell
  -x ==> 解包
  -v ==> 显示详细信息
  -z ==> 打包同时gzip压缩包
  -j ==> 打包同时bzip2压缩包
  -C ==> 指定包解压后文件的存放目录
  cat ==> 合并
  写法 ==> cat 包所在路径/包名* | tar xv -C 指定解压后存放目录

  示例 ==> cat user1.tar.0* | tar xv
  -- info >> 将 user1.tar.0* 分卷压缩包 解压到当前目录下面
  示例 ==> cat /user1.tar.0* | tar xv
  -- info >> 将 根目录下的user1.tar.0*分卷压缩包 解压到当前目录下面
  示例 ==> cat /user1.tar.0* | tar xv -C /home/
  -- info >> 将 根目录下的user1.tar.0*分卷压缩包 解压到/home/目录下面
  示例 ==> cat user1.tar.gz.0* | tar zxv
  -- info >> 将 user1.tar.gz.0* 分卷压缩包 解压到当前目录下面
  示例 ==> cat user1.tar.bz2.0* | tar jxv
  -- info >> 将 user1.tar.bz2.0* 分卷压缩包 解压到当前目录下面
  ```

--------------------------------------------------------------------------------

### **服务器终端界面配置**

> `Debian shell` 默认情况下并不是特别友好，我们细微的改变下，就会大大提升用户体验

#### `.bashrc` 与 `.profile` 文件说明

1. `/etc/profile` `/etc/bash.bashrc` 是系统全局环境变量设定
2. `~/.profile` `~/.bashrc` 是用户家目录下的私有环境变量设定
3. `~/.profile` 可以设定本用户专有的路径，环境变量等，它只能登入的时候执行一次
4. `~/.bashrc` 也是某用户专有设定文档，可以设定路径，命令别名，每次shell script的执行都会使用它一次

#### 当登入系统时候获得一个shell进程时，其读取环境设定档有三步

1. 首先读入的是全局环境变量设定档 `/etc/profile` ，然后根据其内容读取额外的设定的文档，如

  - `/etc/profile.d` 和 `/etc/inputrc`

2. 然后根据不同使用者帐号，去其家目录读取 `~/.bash_profile` ，如果这读取不了就读取 `~/.bash_login` ，这个也读取不了才会读取 `~/.profile` ，这三个文档设定基本上是一样的，读取有优先关系

3. 最后根据用户帐号读取 `~/.bashrc`

> 在这里我们只是简单的改变 `~/.bashrc` 文件

#### 修改 `~/.bashrc` 文件

- 备份并打开 `~/.bashrc` 文件

  ```shell
  $ cp ~/.bashrc{,.backup}
  $ vim ~/.bashrc
  ```

- 编辑 `~/.bashrc` 文件

  ```shell
  export LS_OPTIONS='--color=auto'                      # 文件与文件夹显示不同颜色
  alias ls='ls $LS_OPTIONS -F'                          # ls 替代 ls -F
  alias ll='ls $LS_OPTIONS -lAF'                        # ll 替代 ls -lAF
  PS1='[${debian_chroot:+($debian_chroot)}\u:\w]\$ '    # 让命令行提示符更直观
  ```

#### `SP1` 配置说明

1. `\u@\h:\w$` >> 用户名@主机名:路径$
2. `\033[01;33;1m]` >> \033[显示状态;前景色;背景色m] （文章里没配置）

#### `PS1` 组成元素的编码

状态值  | 状态
---- | ------------------------------------------------
\a   | ASCII响铃字符（也可以键入\007）
\d   | "WedSep06"格式的日期
\e   | ASCII转义字符（也可以键入\033）
\h   | 主机名的第一部分（如"mybox"）
\H   | 主机的全称（如"mybox.mydomain.com"）
\j   | 在此shell中通过按^Z挂起的进程数
\l   | 此shell的终端设备名（如"ttyp4"）
\n   | 换行符
\r   | 回车符
\s   | shell的名称（如"bash"）
\t   | 24小时制时间（如"23:01:01"）
\T   | 12小时制时间（如"11:01:01"）
\@   | 带有am/pm的12小时制时间
\u   | 用户名
\v   | bash的版本（如2.04）
\V   | Bash版本（包括补丁级别）?/td>;
\w   | 当前工作目录（如"/home/drobbins"）
\W   | 当前工作目录的"基名(basename)"（如"drobbins"）
!    | 当前命令在历史缓冲区中的位置
#    | 命令编号（只要您键入内容，它就会在每次提示时累加）
\$   | 如果您不是超级用户(root)，则插入一个"$"；如果您是超级用户，则显示一个"#"
\xxx | 插入一个用三位数xxx（用零代替未使用的数字，如"/007"）表示的ASCII字符
\    | 反斜杠
[    | 这个序列应该出现在不移动光标的字符序列（如颜色转义序列）之前。它使bash能够正确计算自动换行。
]    | 这个序列应该出现在非打印字符序列之后。

#### `PS1` 颜色表

颜色  | 黑色 | 红色 | 绿色 | 黄色 | 蓝色 | 紫红色 | 青蓝色 | 白色
--- | -- | -- | -- | -- | -- | :-: | :-: | --
前景色 | 30 | 31 | 32 | 33 | 34 | 35  | 36  | 37
背景色 | 40 | 41 | 42 | 43 | 44 | 45  | 46  | 47

#### `PS1` 状态表

意义 | OFF | 高亮显示 | underline | 闪烁 | 反白显示 | 不可见
-- | :-: | :--: | :-------: | -- | :--: | :-:
代码 |  0  |  1   |     4     | 5  |  7   |  8

--------------------------------------------------------------------------------

