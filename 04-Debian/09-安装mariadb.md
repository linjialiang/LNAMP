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
$ useradd -d /data/compile/mariadb-10.3.15 -s /bin/false  -c 'mariadb user' mariadb
# 设置权限，根目录为root用户，内部用户为mariadb用户
$ chown mariadb:mariadb -R /data/compile/mariadb-10.3.15
$ chown root:root /data/compile/mariadb-10.3.15
```

## 初始化 mariadb

> `./scripts/mysql_install_db` 这个脚本是 mariadb 的初始化工具

| 重要指令                                        | 指令描述                                                             |
| ----------------------------------------------- | -------------------------------------------------------------------- |
| --help                                          | 列出帮助说明                                                         |
| --basedir=path                                  | 指向 MariaDB 安装目录的路径                                          |
| --skip-test-db                                  | 不安装测试服务器                                                     |
| --skip-name-resolve                             | 创建时使用 IP 地址而不是主机名                                       |
| --auth-root-authentication-method=normal/socket | 为创建的初始根用户选择身份验证方法（备注： 1）                       |
| --auth-root-socket-user=user                    | 指定 MariaDB 根帐户名称，以及允许访问它的系统帐户名称。默认为 'root' |
| --datadir=path                                  | MariaDB 数据目录的路径                                               |
| --ldata=path                                    | 与`--datadir` 一样                                                   |
| --no-defaults                                   | 不要从任何选项文件中读取默认选项。                                   |
| --defaults-file=path                            | 只读取此配置文件。                                                   |

> 备注 1：`--auth-root-authentication-method` 属性描述

| 序号   | 描述                                                                     |
| ------ | ------------------------------------------------------------------------ |
| 作用   | 为创建的初始根用户选择身份验证方法。                                     |
| normal | 默认值，用于创建可以不使用密码登录的根用户，这可能是不安全的。           |
| socket | 只允许系统根用户作为 MariaDB 根用户登录;这需要 unix 套接字身份验证插件。 |

```shell
$ cd /data/compile/mariadb-10.3.15
$ ./scripts/mysql_install_db \
--basedir=/data/compile/mariadb-10.3.15 \
--datadir=/data/compile/mariadb-10.3.15/data \
--defaults-file=/data/conf/mariadb.conf \
--skip-test-db \
--skip-name-resolve \
--auth-root-socket-user=mariadb
```
