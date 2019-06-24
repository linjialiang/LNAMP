# 在 Debian 上构建 MariaDB

> 如果您使用的是 Debian 或其任何直接衍生产品，并且希望从源代码编译 MariaDB，您可以使用 MariaDB 源存储库来完成您感兴趣的发布。

```shell
# “安装构建依赖项”前需要如下安装包及其依赖项支持
$ apt install software-properties-common devscripts dirmngr
```

## 安装构建依赖项（Installing Build Dependencies）

> MariaDB 需要从源代码编译许多包。幸运的是您可以使用 MariaDB 源存储库来检索所需版本的必要代码。

    - 使用【Repository Configuration工具】确定如何为您的Debian发行版设置MariaDB源存储库；
    - 确定您要安装的MariaDB版本以及您要使用的镜像。

> 点击进入： [Repository Configuration 工具](https://downloads.mariadb.org/mariadb/repositories/#mirror=neusoft)

1. 首先添加源存储库的身份验证密钥，然后添加源存储库

   ```shell
   $ apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8
   # 添加清华大学源镜像作为 mariadb10.4 的源存储库
   $ add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirrors.tuna.tsinghua.edu.cn/mariadb/repo/10.4/debian stretch main'
   ```

   ```text
   第二个命令将文本添加到 `/etc/apt/sources.list` 文件中：
        - 其中一行是包含 MariaDB 二进制包的存储库，另一行包含源包；
        - 默认情况下，源包的行已注释掉；
        - 使用 vim 文本编辑器打开文件并取消注释源存储库。
   ```

2. /etc/apt/sources.list 文件增加内容如下：

   ```conf
   # MariaDB 10.4 repository list - created 2019-06-22 01:08 UTC
   # http://downloads.mariadb.org/mariadb/repositories/
   deb [arch=amd64,i386,ppc64el] http://mirrors.tuna.tsinghua.edu.cn/mariadb/repo/10.4/debian stretch main
   deb-src [arch=amd64,i386,ppc64el] http://mirrors.tuna.tsinghua.edu.cn/mariadb/repo/10.4/debian stretch main
   ```

3. 更新源及软件包

   ```shell
   $ apt update
   $ apt dist-upgrade
   ```

### 检索构建依赖项

> 设置源存储库后，使用 apt 来检索构建依赖项：

```text
- 由 Ubuntu 提供的 MariaDB 包和由 MariaDB 源存储库提供的包具有相同的基本名称 mariadb-server；
- 并且需要指定要检索的特定版本，如：检索 mariadb-10.4 源代码包（注意，并不是检索 mariadb-server-10.4）
```

```shell
$ apt build-dep mariadb-10.4
```

## 构建 MariaDB（Building MariaDB）

> 这里我们以当前最新版 mariadb-10.4.6 版本为例

### 下载源码包

> mariadb 源码下载地址 https://github.com/MariaDB/server

```shell
$ mkdir -p /data/source/mariadb
$ cd /data/source/mariadb
# 源存储库-清华大学镜像
$ wget https://mirrors.tuna.tsinghua.edu.cn/mariadb/mariadb-10.4.6/source/mariadb-10.4.6.tar.gz
# 源存储库-大连东软信息学院
$ wget http://mirrors.neusoft.edu.cn/mariadb/mariadb-10.4.6/source/mariadb-10.4.6.tar.gz
```

> 解压源码包并创建编译所需目录和文件

```shell
$ tar -xzvf mariadb-10.4.6.tar.gz
$ mkdir -p /data/{build,compile}/mariadb-10.4.6
```

### 开始编译安装 MariaDB

> 使用 cmake 来生成 makefile 文件

```shell
$ cd /data/build/mariadb-10.4.6/
$ cmake /data/source/mariadb/mariadb-10.4.6 \
-DCMAKE_INSTALL_PREFIX=/data/compile/mariadb-10.4.6
```

> # 查看 mariadb 选项配置情况

```shell
$ cmake /data/source/mariadb/mariadb-10.4.6 -LH
```

> make 开始工作

```shell
# 构建
$ make
# 编译
 make install
# 清理编译留下的缓存
$ make clean
```

## 初始化 mariadb 数据

> mariadb 使用 mysql_install_db 初始化 MariaDB 数据目录

1. 创建默认选项文件

   ```shell
   $ mkdir /data/etc
   $ touch /data/etc/my.cnf
   ```

2. 创建 mariadb 用户

   ```shell
   $ useradd -d /data/compile/mariadb-10.4.6 -s /bin/false -c 'This is a mariadb user' mysql
   ```

3. 使用 mariadb_install_db 初始化

   ```shell
   $ rm -rf /data/compile/mariadb-10.4.6/data
   $ ./scripts/mariadb-install-db --defaults-file=/data/etc/my.cnf \
   --user=mysql \
   --skip-test-db \
   --skip-name-resolve \
   --auth-root-authentication-method=socket \
   --auth-root-socket-user=emad
   ```

## 权限

> MariaDB 的权限一般默认即可

```text
mariadb目录权限，正常设置：
    1.  mariadb 根目录
        - 用户：chown root:root -R /data/compile/mariadb-10.4.6
        - 权限：默认不变
    2. mariadb 数据目录
        - 用户：chown mysql:root -R ./data
        - 权限：chmod 700 -R ./data
```

## 操作可执行程序

> 将可执行程序加入到系统环境变量中

1.  /etc/profile 文件底部加入 bin 目录的路径

    ```shell
    $ cp /etc/profile{,.bak}
    $ vim /etc/profile
    ```

    ```conf
    export PATH=/data/compile/mariadb-10.4.6/bin:$PATH
    ```

2.  激活新设置的环境变量（或者重启服务器）

    ```shell
    $ source /etc/profile
    ```

## 开机启动 mariadb

> debian 下可以使用 systemctl 指令来引导开机启动项，具体操作如下：

1. 首先完成 init.d 启动

   > 将 `mysql.server` 文件复制到 init.d 目录下并重命名

   ```shell
   $ cp ./support-files/mysql.server /etc/init.d/mysql
   # 现在就可以启动mysqld了
   $ /etc/init.d/mysql {start|stop|restart|reload|status}
   ```

2. `systemctl` 管理开机启动

   > 使用 systemctl 让 mysql 加入开机启动

   ```shell
   # 开机启动
   $ /lib/systemd/systemd-sysv-install enable mysql
   # 禁止开机启动
   $ /lib/systemd/systemd-sysv-install disable mysql
   # 启动方式增加了下面两种：
   $ server mysql {start|stop|restart|reload|status}
   $ systemctl {start|stop|restart|reload|status} mysql
   ```

   > 现在就可以在开机时引导 mysqld 启动了

3. update-rc.d 命令

   > 该命令用于安装或移除 System-V 风格的初始化脚本连接

   ```text
   这部分暂不讲解
   ```

## my.cnf 选项文件

> 本次案例将默认选项文件设置为 `/data/etc/my.cnf`

```shell
$ vim /data/etc/my.cnf
```

> 内容如下：

```cnf

```
