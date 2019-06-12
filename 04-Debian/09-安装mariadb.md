# 安装 mariadb

> 我们这里要安装的是 mariadb 10.3.15

## 获取源码仓库

> 常见的linux发行版，mariadb都有预编译的包，地址如下：

```text
https://downloads.mariadb.org/mariadb/repositories/
```

## 增加mariadb源

> 方法一

```shell
# 下面是将MariaDB添加到您的系统的命令:
$ apt-get install software-properties-common dirmngr
$ apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8
$ add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirrors.tuna.tsinghua.edu.cn/mariadb/repo/10.3/debian stretch main'

# 一旦密钥导入并添加了存储库，您就可以使用以下工具安装MariaDB:
$ apt-get update
$ apt-get install mariadb-server
```

> 方法二：您还可以创建自定义的 MariaDB 的 sources.list 文件。

> - 操作：复制并粘贴以下内容到 `/etc/apt/sources.list.d/` 目录下
> - 建议：我们建议将文件命名为 `MariaDB.list` 或者直接将代码添加到 `/etc/apt/sources.list` 文件的底部

```shell
# MariaDB 10.3 repository list - created 2019-06-12 01:53 UTC
# http://downloads.mariadb.org/mariadb/repositories/
deb [arch=amd64,i386,ppc64el] http://mirrors.tuna.tsinghua.edu.cn/mariadb/repo/10.3/debian stretch main
deb-src http://mirrors.tuna.tsinghua.edu.cn/mariadb/repo/10.3/debian stretch main
```
