# 安装 mariadb

> 我们这里要安装的是 mariadb 10.4.6

## 下载源码包

> mariadb 源码下载地址 https://downloads.mariadb.org/

```shell
$ mkdir -p /data/source/mariadb
$ cd /data/source/mariadb
$ wget http://mirrors.neusoft.edu.cn/mariadb/mariadb-10.4.6/source/mariadb-10.4.6.tar.gz
```

## 安装缺失的依赖项

> 当前这台服务器，安装 mariadb 缺少了如下包（及对应的依赖）

```shell
$ apt install git libncurses5-dev libghc-gnutls-dev libbison-dev libevent-dev libxml2-dev libjemalloc-dev libghc-bzlib-dev libcrack2-dev libpam0g-dev
```

## 编译 mariadb

> 使用 cmake 来编译 mariadb

```shell
$ tar -xzvf mariadb-10.4.6.tar.gz
$ mkdir -p /data/{build,compile}/mariadb-10.4.6
# 生成makefile文件
$ cd /data/build/mariadb-10.4.6/
$ cmake /data/source/mariadb/mariadb-10.4.6 \
-DCMAKE_INSTALL_PREFIX=/data/compile/mariadb-10.4.6
# 查看依赖是否缺失，缺啥补啥吧
$ cmake /data/source/mariadb/mariadb-10.4.6 -L
# 确认依赖都已满足，cmake生成makefile成功，就可以使用make构建了
$ make
# 编译
$ make install
# 清理编译留下的缓存
$ make clean
```

## 初始化 mariadb 前的准备

> mariadb 刚刚编译成功，事实上还不能开启服务，需要我们做初始化的工作，而初始化操作前，还有一个准备工作：

| 序号 | 初始化前需要准备的内容      |
| ---- | --------------------------- |
| 01   | 为 mariadb 创建用户及用户群 |
| 02   | 为 mariadb 目录设置权限     |

> 用户和群组名是可以按自己喜好来的，但是为了容易识别，一般都是使用 `mysql`

```shell
# 没有特别设置会自动创建跟用户同名的用户群组
# 使用 /bin/false 来禁止 mariadb 账户登录功能
$ useradd -d /data/compile/mariadb-10.4.6 -s /bin/false  -c 'The root user of mariadb' mysql
# 设置权限，根目录为root用户，内部用户为mysql_root用户
$ chown mysql:mysql -R /data/compile/mariadb-10.4.6
$ chown root:root /data/compile/mariadb-10.4.6
```

## 初始化 mariadb

> `./scripts/mysql_install_db` 这个脚本是 mariadb 的初始化工具
>
> - 有关 mariadb 初始化详情，请查阅 [mysql_install_db 选项](./info/mysql_install_db选项.md)

> 初始化操作指令

```shell
$ mkdir /data/conf
$ touch /data/conf/my.cnf
$ cd /data/compile/mariadb-10.4.6
$ ./scripts/mysql_install_db \
--defaults-file=/data/conf/my.cnf \
--user=mysql \
--auth-root-authentication-method=socket \
--basedir=/data/compile/mariadb-10.4.6 \
--datadir=/data/compile/mariadb-10.4.6/data \
--skip-name-resolve \
--skip-test-db
```

### 设置 mysql_safe 用户

> 在 Unix 中推荐使用 mysqld_safe 来启动 mysqld 服务器。mysqld_safe 增加了一些安全特性；
>
> - 例如:当出现错误时，会重启服务器并向错误日志文件写入运行时间信息。

```shell
$ /data/compile/mariadb-10.4.6/bin/mysqld_safe --user=mariadb_root
```

## 将可执行文件加入环境变量中

> 首先需要将 bin 目录下的可执行文件加入到环境变量

```shell
$ cp /etc/profile{,.bak}
$ vim /etc/profile
```

> 底部加入如下一行：

```conf
export PATH=/data/compile/mariadb-10.4.6/bin:$PATH
```

> 激活新设置的环境变量（或者重启服务器）

```shell
$ source /etc/profile
```

## 启动方式

> 启动方式主要有如下 3 种：

1. init.d 启动

   > 将 `mysql.server` 文件复制到 init.d 目录下并重命名

   ```shell
   $ cp ./support-files/mysql.server /etc/init.d/mysql
   $ /etc/init.d/mysql {start|stop|restart|reload|status}
   ```

2. service 启动（可用 `systemctl开机启动` 替代）

   > 将 `mysql.server` 文件加入 bin 目录（或者将其加入环境变量中）

   ```shell
   $ cp ./support-files/mysql.server ./bin
   $ systemctl daemon-reload
   $ server mysql {start|stop|restart|reload|status}
   $ systemctl {start|stop|restart|reload|status} mysql.service
   ```

   > 提示：将 `/etc/init.d/mysql` 通过 systemctl 程序加入开机启动时，加入环境变量的 `mysql.service` 文件，全部都会被移除（确保仅有 systemctl 启动程序中唯一存在）

3. `systemctl` 管理开机启动

   > 可以使用 systemctl 指令设置开机启动（确保 init.d 下面有对应的启动文件）

   ```shell
   # 开机启动
   $ /lib/systemd/systemd-sysv-install enable mysql
   # 禁止开机启动
   $ /lib/systemd/systemd-sysv-install disable mysql
   ```

## 其它设置

1. 为 mariadb 的根账户设置密码

   > 管理员直接使用 mysqladmin 这个程序设置根账户密码

   ```shell
   # 首先要先启动mysql，并且密码为空
   $ mysqladmin -u <根用户名> password [密码]
   # 案例一
   $ mysqladmin -u root password '123456'
   # 案例二
   $ mysqladmin -u mariadb_root password
   New password:123456
   Confirm new password:123456
   ```

2. mariadb 配置选项文件

   > 默认选项文件可能有多个，依次读取顺序为 `/etc/my.cnf` `~/.my.cnf` ，我们也可以使用 `--defaults-file=path` 自定义选项文件路径

   ```text
   注意：如果通过 `--defaults-file=path` 指定了选项文件
    - 那么仅从给定选项文件中读取选项配置;
    - 如果该文件不存在，则初始化 MariaDB 时，将引发错误提示。
   ```

   > 选项文件案例

   ```ini
   [client-server]
   socket=/tmp/mysql.sock
   port=3306

   [client]
   #password=my_password

   [mysqld]
   datadir=/data/compile/mariadb-10.4.6/data
   ```

   > mariadb 选项文件语法清查阅 [mariadb 选项文件语法](./info/mariadb选项文件语法.md)
