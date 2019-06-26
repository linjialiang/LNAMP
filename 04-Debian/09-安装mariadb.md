# 安装 MariaDB

> 这里我们以当前最新版 mariadb-10.4.6 版本为例

## 在 Debian 上构建 MariaDB

> MariaDB 官方为 Debian 设计了一种更加合理的编译方式，[点击查看最新手册](https://mariadb.com/kb/en/library/building-mariadb-on-debian/)
>
> - 不过我们这里使用的是最基本的编译方式，大家也可以参考 MariaDB 官网手册进行安装！

## 如何确认依赖项

> 使用 `./debian/autobake-deb.sh` 这个脚本 ，可以确认依赖项

```shell
$ cd /custom/source/mariadb-10.4.6
$ ./debian/autobake-deb.sh
```

> 如果缺少依赖会有如下提示：

```text
Incrementing changelog and starting build scripts
Creating package version 1:10.4.6+maria~stretch ...
dpkg-buildpackage: info: source package mariadb-10.4
dpkg-buildpackage: info: source version 1:10.4.6+maria~stretch
dpkg-buildpackage: info: source distribution stretch
dpkg-buildpackage: info: source changed by root <root@debian9>
dpkg-buildpackage: info: host architecture amd64
 dpkg-source -I --before-build mariadb-10.4.6
dpkg-checkbuilddeps: error: Unmet build dependencies: bison chrpath cmake (>= 2.7) dh-apparmor dh-systemd gdb libaio-dev libboost-dev libcrack2-dev (>= 2.9.0) libcurl3-dev libjemalloc-dev (>= 3.0.0~) libjudy-dev libkrb5-dev libncurses5-dev (>= 5.0-6~) libnuma-dev libpam0g-dev libpcre3-dev (>= 2:8.35-3.2~) libreadline-gplv2-dev libsnappy-dev libssl-dev | libssl1.0-dev libsystemd-dev libxml2-dev libzstd-dev unixodbc-dev uuid-dev zlib1g-dev (>= 1:1.1.3-5~)
dpkg-buildpackage: warning: build dependencies/conflicts unsatisfied; aborting
dpkg-buildpackage: warning: (Use -d flag to override.)
```

> 整理后，我们需要安装依赖包如下：

```shell
$ apt install bison chrpath cmake dh-apparmor dh-systemd gdb libaio-dev libboost-dev libcrack2-dev libcurl3-dev libjemalloc-dev libjudy-dev libkrb5-dev libncurses5-dev libnuma-dev libpam0g-dev libpcre3-dev libreadline-gplv2-dev libsnappy-dev libssl-dev libsystemd-dev libxml2-dev libzstd-dev unixodbc-dev uuid-dev zlib1g-dev
```

## 开始编译安装 MariaDB

1. 使用 cmake 来生成 makefile 文件

```shell
$ cd /server/build/mariadb-10.4.6/
$ cmake /server/source/mariadb/mariadb-10.4.6 \
-DSYSCONFDIR=/etc/mysql \
-DCMAKE_INSTALL_PREFIX=/server/compile/mariadb-10.4.6 \
-DMYSQL_DATADIR=/server/compile/mariadb-10.4.6/data \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_unicode_ci \
-DEXTRA_CHARSETS=all
```

2. 查看 mariadb 选项配置情况

```shell
$ cmake /server/source/mariadb/mariadb-10.4.6 -LH
```

3. make 开始工作

```shell
# 构建
$ make
# 编译
 make install
# 清理编译留下的缓存
$ make clean
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
