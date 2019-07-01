# 安装 MariaDB

> 这里我们以 mariadb-10.4.6 版本为例

```text
提示：由于mariadb官方对源代码安装方式的说明不够完善：
    - 我们决定本次教程以apt的方式安装；
    - 等待mariadb完善教程，我们再写一篇源代码安装的说明。
```

## 获取存储库

> MariaDB 公司提供了一个 shell 脚本，可以很方便的配置与当前系统匹配的 MariaDB 存储库

```text
脚本地址：
    - https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
包含3个存储库：
    - MariaDB存储库（我们一般只需要这个）
    - MariaDB MaxScale存储库
    - MariaDB工具库
```

1. 安装 dirmngr 证书管理工具及其依赖

   ```text
   dirmngr是一个服务器，用于管理和下载OpenPGP和X.509证书，以及与这些证书相关的更新和状态信号。
       - 对于OpenPGP，这意味着从公共HKP/HKPS密钥服务器或LDAP服务器中提取。
       - 对于X.509，这包括证书撤销列表(CRLs)和在线证书状态协议更新(OCSP)。
       - 它能够使用tor进行网络访问。
   ```

   ```shell
   $ apt install dirmngr
   ```

2. mariadb_repo_setup 工具选项

   > 要为脚本提供选项，您必须通过 `bash -s --` 来使用选项，如下所示：

   ```shell
   $ curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash -s -- --help
   ```

   | option                               | 说明                                                                                                    |
   | ------------------------------------ | ------------------------------------------------------------------------------------------------------- |
   | --help                               | 显示用法消息并退出                                                                                      |
   | --mariadb-server-version=<version>   | 覆盖默认的 MariaDB Server 版本。默认情况下，脚本将使用'mariadb-10.4'。                                  |
   | --mariadb-maxscale-version=<version> | 覆盖默认的 MariaDB MaxScale 版本。默认情况下，脚本将使用“2.3”。                                         |
   | --os-type=<type>                     | 覆盖 OS 类型的检测。可接受的值包括 debian，ubuntu，rhel，和 sles。                                      |
   | --os-version=<type>                  | 覆盖 OS 版本的检测。可接受的值取决于您指定的操作系统类型。                                              |
   | --skip-key-import                    | 跳过导入 GPG 签名密钥。                                                                                 |
   | --skip-server                        | 跳过'MariaDB Server'存储库。                                                                            |
   | --skip-maxscale                      | 跳过'MaxScale'存储库。                                                                                  |
   | --skip-tools                         | 跳过“工具”存储库。                                                                                      |
   | --write-to-stdout                    | 将输出写入 stdout 而不是 OS 的存储库配置文件。这也将跳过导入 GPG 公钥并在存在该行为的平台上更新包缓存。 |

3. 使用以下指令来增加：

   ```shell
   $ mkdir /home/emad/downloads
   $ cd /home/emad/downloads
   $ curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup |
   bash -s -- \
   --mariadb-server-version="mariadb-10.4" \
   --skip-maxscale \
   --skip-tools
   $ apt update
   $ apt dist-upgrade
   ```

## 安装 maraidb 服务

> 接下来我们安装 mariadb-server-10.4 及其依赖

```shell
$ apt install mariadb-server-10.4
```

> 注意:如果太慢，可以选择换源：

```text
官方换源地址：
    - https://downloads.mariadb.org/mariadb/repositories/
    - 也可以直接按这里的说明来安装 mariadb
```

## 提高 MariaDB 安装的安全性

> 使用 `mysql_secure_installation` 脚本用于提升 MariaDB 安装的安全性

```text
过以下方式提高MariaDB安装的安全性：
    - 您可以为root帐户设置密码；
    - 您可以删除可从本地主机外部访问的root帐户；
    - 您可以删除匿名用户帐户；
    - 您可以删除测试数据库，默认情况下，匿名用户可以访问该数据库。
注意：除自己编译安装外，其它安装方式一般都可略过该步骤！
```
