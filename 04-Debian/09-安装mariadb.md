# 安装 MariaDB

> 这里我们以当前最新版 mariadb-10.4.6 版本为例

## 在 Debian 上构建 MariaDB

> MariaDB 官方为 Debian 设计了一种更加合理的编译方式，[点击查看最新手册](https://mariadb.com/kb/en/library/building-mariadb-on-debian/)
>
> - 不过我们这里使用的是最基本的编译方式，大家也可以参考 MariaDB 官网手册进行安装！

## 如何确认依赖项

> 通过 `./debian/control` 这个文件，可以确认 MariaDB 所需依赖项如下：

```shell
$ apt install bison chrpath cmake debhelper dh-apparmor dh-systemd gdb libaio-dev libboost-dev libcrack2-dev libcurl3-dev libjemalloc-dev libjudy-dev libkrb5-dev libncurses5-dev libnuma-dev libpam0g-dev libpcre3-dev libreadline-gplv2-dev libsnappy-dev libssl-dev libsystemd-dev libxml2-dev libzstd-dev lsb-release perl po-debconf psmisc unixodbc-dev uuid-dev zlib1g-dev
```

## 创建必备路径

> 创建 mariadb 编译过程中，必备的路径

```shell
$ mkdir /custom/{build,compile}/mariadb-10.4.6
$ mkdir /custom/etc/mariadb
```

## 开始编译 MariaDB 源代码

1. 使用 cmake 构建 makefile 文件

   ```shell
   $ cd /custom/build/mariadb-10.4.6
   $ cmake /custom/source/mariadb-10.4.6/ \
     -DSYSCONFDIR=/custom/etc/mariadb/ \
     -DCMAKE_INSTALL_PREFIX=/custom/compile/mariadb-10.4.6/ \
     -DMYSQL_DATADIR=/custom/web/mariadb/ \
     -DDEFAULT_CHARSET=utf8 \

     -DEXTRA_CHARSETS=all


     $ cmake /custom/source/mariadb-10.4.6/ \
     -DCMAKE_INSTALL_PREFIX=/custom/compile/mariadb-10.4.6/ \
     -DMYSQL_DATADIR=/custom/web/mariadb/
     -DINSTALL_MYSQLDATADIR=data \
     -DINSTALL_SYSCONFDIR=/custom/etc/mariadb/ \
     -DINSTALL_SYSCONF2DIR=/custom/etc/mariadb/my.cnf.d/ \
   ```

2. 查看 mariadb 选项配置情况

   ```shell
   $ cmake /custom/build/mariadb-10.4.6/ -LH
   # 或者直接查看 CMakeCache.txt 文件，这是最详细的
   $ vim /custom/build/mariadb-10.4.6/CMakeCache.txt
   ```

3. 使用 make 编译源代码

   > 正常情况下：

   ```shell
   # 编译
   $ make
   # 安装
   $ make install
   # 清理编译留下的缓存
   $ make clean
   # 卸载软件
   $ rm -rf /custom/compile/mariadb-10.4.6/
   ```

   > 如果 cmake 产生的文件不在当前路径，则需要指定路径：

   ```shell
   # 编译
   $ make -C /custom/build/mariadb-10.4.6/
   # 安装
   $ make -C /custom/build/mariadb-10.4.6/ install
   # 清理编译留下的缓存
   $ make -C /custom/build/mariadb-10.4.6/ clean
   # 卸载软件
   $ rm -rf /custom/compile/mariadb-10.4.6/
   ```

> 如何解决依赖问题：缺少依赖 cmake 无法成功，并且会给出相应的提示！

## 初始化 mariadb 数据

> mariadb 使用 mysql_install_db 初始化 MariaDB 数据目录

1. 创建默认选项文件

   ```shell
   $ mkdir /server/etc
   $ touch /server/etc/my.cnf
   ```

2. 创建 mariadb 用户

   ```shell
   $ useradd -d /server/compile/mariadb-10.4.6 -s /bin/false -c 'This is a mariadb user' mysql
   ```

3. 使用 mariadb_install_db 初始化

   ```shell
   $ rm -rf /server/compile/mariadb-10.4.6/data
   $ ./scripts/mariadb-install-db \
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
        - 用户：chown root:root -R /server/compile/mariadb-10.4.6
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
    export PATH=/server/compile/mariadb-10.4.6/bin:$PATH
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
$ vim /server/etc/my.cnf
```

> 内容如下：

```cnf

```
