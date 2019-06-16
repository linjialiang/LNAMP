# 安装 mariadb

> 我们这里要安装的是 mariadb 10.3.15

## 安装缺失的依赖项

> 当前这台服务器缺少了下面 4 个包及其依赖

```shell
$ apt install libncurses5-dev libghc-gnutls-dev libbison-dev libevent-dev
```

## 编译 mariadb

> 使用 cmake 来编译 mariadb

```shell
$ cd /data/source/maridb
$ tar -xzvf mariadb-10.3.15.tar.gz
$ mkdir -p /data/{build,compile}/mariadb-10.3.15
$ cd /data/build/mariadb-10.3.15/
# 生成makefile文件
$ cmake /data/source/mariadb/mariadb-10.3.15 \
-DCMAKE_INSTALL_PREFIX=/data/compile/mariadb-10.3.15/
# 构建
$ make
# 编译
$ make install
# 清理编译留下的缓存
$ make clean
```

## 初始化 mariadb 前的准备

> maridb 刚刚编译成功，事实上还不能开启服务，需要我们做初始化的工作，而初始化操作前，还有一个准备工作：

| 序号 | 初始化前需要准备的内容            |
| ---- | --------------------------------- |
| 01   | 为 mariadb 创建特定的用户及用户群 |
| 02   | 为 mariadb 目录设置权限           |

> 用户和群组名是可以按自己喜好来的，但是为了容易识别，一般都是使用 `mysql`

```shell
# 没有特别设置会自动创建跟用户同名的用户群组
# 使用 /bin/false 来禁止 mariadb 账户登录功能
$ useradd -d /data/compile/mariadb-10.3.15 -s /bin/false  -c 'mariadb user' mysql
# 设置权限，根目录为root用户，内部用户为mariadb用户
$ chown mysql:mysql -R /data/compile/mariadb-10.3.15
$ chown root:root /data/compile/mariadb-10.3.15
```

## 初始化 mariadb

> `./scripts/mysql_install_db` 这个脚本是 mariadb 的初始化工具

| 重要指令                                        | 指令描述                                     |
| ----------------------------------------------- | -------------------------------------------- |
| --help                                          | 列出帮助说明                                 |
| --user=user_name                                | 用于运行 mysqld 的登录用户名(详情查看备注 3) |
| --basedir=path                                  | 指向 MariaDB 安装目录的路径                  |
| --datadir=path                                  | MariaDB 数据目录的路径                       |
| --defaults-file=path                            | 只读取此配置文件。                           |
| --skip-test-db                                  | 不安装测试服务器                             |
| --skip-name-resolve                             | 创建时使用 IP 地址而不是主机名               |
| --auth-root-authentication-method=normal/socket | 备注 1                                       |
| --auth-root-socket-user=user                    | 备注 2                                       |
| --ldata=path                                    | 与`--datadir` 一样                           |
| --no-defaults                                   | 不要从任何选项文件中读取默认选项。           |

> 初始化操作指令

```shell
$ cd /data/compile/mariadb-10.3.15
$ touch /data/conf/mariadb.conf
$ ./scripts/mysql_install_db \
--user=mysql \
--basedir=/data/compile/mariadb-10.3.15 \
--datadir=/data/compile/mariadb-10.3.15/data \
--defaults-file=/data/conf/my.ini \
--auth-root-authentication-method=socket \
--skip-test-db \
--skip-name-resolve \
--auth-root-socket-user=root
```

> 备注 1：`--auth-root-authentication-method=normal|socket` 属性描述

| 序号   | 描述                                                                              |
| ------ | --------------------------------------------------------------------------------- |
| 作用   | 为创建的初始根用户选择身份验证方法。                                              |
| normal | 默认值，用于创建可以不使用密码登录的根用户，这可能是不安全的。                    |
| socket | 只允许 `系统root用户` 作为 `MariaDB 根用户` 登录(需要 `unix socket` 身份验证插件) |

> 备注 2 ： `--auth-root-socket-user=user`

```text
指定 MariaDB 根帐户名称，以及允许访问它的系统帐户名称。默认为 'root'
```

> 备注 3：`--user=user_name`

```text
用于运行mysqld的登录用户名。
由mysqld创建的文件和目录将由该用户拥有。
必须是root用户才能使用此选项。
默认情况下，mysqld使用您当前的登录名运行，它创建的文件和目录将由您拥有。
```

## 将可执行文件加入环境变量中

> 首先需要将 bin 目录下的可执行文件加入到环境变量

```shell
$ cp /etc/profile{,.bak}
$ vim /etc/profile
```

> 底部加入如下一行：

```conf
export PATH=/data/compile/mariadb-10.3.15/bin:$PATH
:wq
```

## 启动方式

> 启动方式主要有如下 3 种：

1. init.d 启动

   > 将 `mysql.server` 文件复制到 init.d 目录下并重命名

   ```shell
   $ cp ./support-files/mysql.server /etc/init.d/mysql
   $ /etc/init.d/mysql {start|stop|restart|reload}
   ```

2. service 启动（可用 `systemctl开机启动` 替代）

   > 将 `mysql.server` 文件加入 bin 目录（或者将其加入环境变量中）

   ```shell
   $ cp ./support-files/mysql.server ./bin
   $ systemctl daemon-reload
   $ server mysql {start|stop|restart|reload}
   $ systemctl {start|stop|restart|reload} mysql.service
   ```

   > 提示：将 `/etc/init.d/mysql` 通过 systemctl 程序加入开机启动时，加入环境变量的 `mysql.service` 文件，全部都会被移除（确保仅有 systemctl 启动程序中唯一存在）

3. `systemctl` 管理开机启动

   > 可以使用 systemctl 指令设置开机启动（确保 init.d 下面有对应的文件）

   ```shell
   # 开机启动（第一次可以使用这个指令）
   $ systemctl enable mysql
   # 禁止开机启动
   $ /lib/systemd/systemd-sysv-install disable mysql
   # 开机启动（第二次以后）
   $ /lib/systemd/systemd-sysv-install enable mysql
   ```

## 其它设置

1. 为 mariadb 的根账户设置密码

   > 管理员直接使用 mysqladmin 这个程序设置根账户密码

   ```shell
   # 首先要先启动mysql，并且密码为空
   $ mysqladmin -u <根用户名> -p [密码]
   ```

2. 配置文件 my.ini
