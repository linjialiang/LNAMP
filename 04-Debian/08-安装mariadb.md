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

> 可以直接使用以下指令来执行：

```shell
$ mkdir /home/emad/downloads
$ cd /home/emad/downloads
$ wget https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
$ 
```
