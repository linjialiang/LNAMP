# 在 Debian 上构建 MariaDB

> 如果您使用的是 Debian 或其任何直接衍生产品，并且希望从源代码编译 MariaDB，您可以使用 MariaDB 源存储库来完成您感兴趣的发布。

```shell
# “安装构建依赖项”前需要如下安装包及其依赖项支持
$ apt install software-properties-common devscripts dirmngr
```

## 安装构建依赖项

> MariaDB 需要从源代码编译许多包。幸运的是您可以使用 MariaDB 源存储库来检索所需版本的必要代码。

    - 使用【Repository Configuration工具】确定如何为您的Debian发行版设置MariaDB存储库；
    - 确定您要安装的MariaDB版本以及您要使用的镜像。

> 点击进入： [Repository Configuration 工具](https://downloads.mariadb.org/mariadb/repositories/#mirror=neusoft)

1. 首先添加存储库的身份验证密钥，然后添加存储库

   ```shell
   $ apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8
   # 选项添加清华大学源镜像
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
