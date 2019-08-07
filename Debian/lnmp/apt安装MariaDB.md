# apt 安装 MariaDB

> 不管是 MySQL 还是 MariaDB，它们的官方都有提供各个发行版本的 apt 安装源

| 软件    | apt 源                                                             |
| ------- | ------------------------------------------------------------------ |
| mysql   | https://dev.mysql.com/downloads/repo/apt/                          |
| mariadb | https://downloads.mariadb.org/mariadb/repositories/#mirror=neusoft |

> 注意：mysql 是通过执行脚本来选择 mysql 版本及 debian 版本

## 添加 MariaDB 源

> 下面是将 MariaDB 4.x 添加到您的系统的命令:

```shell
$ apt install software-properties-common dirmngr
$ apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8
```

> 在 `/etc/apt/sources.list.d/` 下创建 `mariadb.list` 文件，并增加内容。

```shell
$ cd /etc/apt/sources.list.d/
$ touch mariadb.list
$ vim mariadb.list
```

> mariadb.list 文件内容：

```conf
# MariaDB 10.4 repository list - created 2019-07-27 03:17 UTC
# http://downloads.mariadb.org/mariadb/repositories/
deb http://mirrors.tuna.tsinghua.edu.cn/mariadb/repo/10.4/debian buster main
deb-src http://mirrors.tuna.tsinghua.edu.cn/mariadb/repo/10.4/debian buster main
```

## 开始安装

> 使用 apt 安装 mariadb-server，默认会安装我们刚刚添加的新源里面的 mariadb-server

```shell
$ apt update
$ apt install mariadb-server
```

> 提示：

## 开始配置 mariadb

> 作为 php 开发者我们不会去对 mariadb 做更多的优化，一般只做一下几步：

| 步骤 | 详情                   |
| ---- | ---------------------- |
| 01   | 修改数据存放目录的路径 |
| 02   | 远程连接               |

### 更改数据存储目录

> 将 mariadb 的数据存储目录修改成 `/server/mysql/`

- 备份配置文件

  ```shell
  $ systemctl stop mysql
  $ cp -p -r /etc/mysql/my.cnf{,.bak}
  $ vim /etc/mysql/my.cnf
  ```

- 修改 my.cnf 文件下的 datadir 参数的值

  ```cnf
  ...
  # datadir       = /var/lib/mysql
  datadir       = /server/mysql
  ...
  ```

- 拷贝数据存放目录

  ```shell
  $ cd /var/lib
  $ tar -czvf mysql_data.tar.gz mysql/
  $ cp -p -r mysql/ /server/mysql/
  $ mv mysql{,.bak}/
  ```

### 远程连接

> 为了便于管理我们要开通指定 ip 地址的远程客户端操作 mariadb

- 修改 my.cnf 配置文件里的 `bind-address` 参数的值

  ```shell
  $ vim /etc/mysql/my.cnf
  ```

  > mariadb 移除对外部的访问限制

  ```cnf
  ...
  # bind-address        = 127.0.0.1
  bind-address        = 0.0.0.0
  ...
  ```

  > 提示：由于这样会很不安全，所以我们需要配合 iptables 来限制客户端，具体的内容我们会在 iptables 章节详细说明！

- 创建允许远程访问的 mysql 用户

  > 假如：服务器为 `192.168.10.252` ，客户端为 `192.168.10.0/24`

  ```shell
  $ su
  $ systemctl start mysql
  $ myqsl
  # 创建用户名设置密码
  MariaDB [(none)]> create user 'admin'@'192.168.10.%' identified by '123456';
  # 为用户授权，所有数据库的所有表的全部操作权限，并且允许将自己拥有的权限授权给别人（这货跟root的权限一样了，超级危险）
  MariaDB [(none)]> grant all privileges on *.* to 'admin'@'192.168.10.%' WITH GRANT OPTION;
  # 刷新权限
  MariaDB [(none)]> flush privileges;
  ```

---

## 创建 `init.d` 启动脚本

> 在常规 linux 中，我们可以使用 systemctl 来启动 mariadb,不过 win10 分发版本就只能使用 init.d 脚本来启动了

| 序号 | 启动脚本路径                                                |
| ---- | ----------------------------------------------------------- |
| 01   | [`init.d.mysqld.sh`](./../MariaDB/source/init.d.mysqld.sh)  |
| 02   | [`init.d.mysqld2sh`](./../MariaDB/source/init.d.mysqld2.sh) |

> 将上表中两个脚本任意选择一个，拷贝到 `/etc/init.d/` 目录下，并且重命名为 `mysqld`。

### 注意事项

> 想要脚本有效，必须满足：`数据库 root 用户的密码无效` 并且 `以root账号登陆系统` 。

- 数据库 root 用户设置了密码怎么办？

  > root 设置了密码，就必须更改启动脚本中的变量 `MYADMIN` 的值，具体如下：

  ```sh
  MYADMIN="/usr/bin/mysqladmin --defaults-file=/etc/mysql/my.cnf" -uroot -p密码"
  ```

### 启动脚本操作说明

> 由于只是开发环境，我就简单写了几个常用的选项：

| 描述     | 指令                         |
| -------- | ---------------------------- |
| 启动服务 | `/etc/init.d/mysqld start`   |
| 关闭服务 | `/etc/init.d/mysqld stop`    |
| 重新加载 | `/etc/init.d/mysqld reload`  |
| 重启服务 | `/etc/init.d/mysqld restart` |
