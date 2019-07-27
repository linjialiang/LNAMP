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

## 开始配置 mariadb

> 作为 php 开发者我们不会去对 mariadb 做更多的优化，一般只做一下几步：

| 步骤 | 详情                          |
| ---- | ----------------------------- |
| 01   | 修改数据存放目录的路径        |
| 02   | 如果需要，修改 mariadb 端口号 |
| 03   | 对 mariadb 初始化             |
| 04   | 开启 mariadb 备份             |
