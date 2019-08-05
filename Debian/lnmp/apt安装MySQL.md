# apt 安装 MySQL

> 不管是 MySQL 还是 MariaDB，它们的官方都有提供各个发行版本的 apt 安装源

| 软件    | apt 源                                                             |
| ------- | ------------------------------------------------------------------ |
| mysql   | https://dev.mysql.com/downloads/repo/apt/                          |
| mariadb | https://downloads.mariadb.org/mariadb/repositories/#mirror=neusoft |

> 注意：mysql 是通过执行脚本来选择 mysql 版本及 debian 版本

## 下载 mysql 安装脚本

```shell
wget https://repo.mysql.com//mysql-apt-config_0.8.13-1_all.deb
```

> 下载后使用 `./mysql-apt-config_0.8.13-1_all.deb` 来执行它

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
