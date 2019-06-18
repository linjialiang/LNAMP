# mariadb 选项文件语法

> 我们可以使用选项文件配置 MariaDB

```text
您可以通过使用MariaDB的选项文件配置服务器，将MariaDB配置为以您希望的方式运行。
    - 在类Unix操作系统下，默认调用 /etc/my.cnf /etc/mysql/my.cnf ~/.my.cnf 为 MariaDB选项文件；
    - 根据您安装 MariaDB 的方式，默认选项文件可能位于多个位置，或者根本不存在。
```

## 与选项文件相关的全局选项

> 以下选项与 MariaDB 处理选项文件的方式有关。这些选项可以与 MariaDB 自带的大多数命令行工具一起使用，而不仅仅是 `主程序 mysqld`。它们必须作为命令行的第一个参数给出：

| 选项                           | 描述                                                 |
| ------------------------------ | ---------------------------------------------------- |
| --print-defaults               | 从选项文件中读取选项，打印所有选项值，然后退出程序。 |
| --no-defaults                  | 不要从任何选项文件中读取选项。                       |
| --defaults-file=<path>         | 仅从给定选项文件中读取选项。                         |
| --defaults-extra-file=<path>   | 读取所有其他选项文件后，请阅读此额外选项文件。       |
| --defaults-group-suffix=suffix | 除了默认选项组之外，还可以读取具有给定后缀的选项组。 |

## 默认选项文件位置

> 默认情况下，MariaDB 从许多不同的目录中读取选项文件。请参阅以下部分以了解检查哪个系统的目录。

- 有关特定程序在系统上读取的选项文件的完整列表，您可以执行：

  ```shell
  # 指令
  <mariadb 执行文件> --help --verbose
  # 案例（由于行数太多，建议在xshell等模拟终端上增加缓存行数）：
  $ mysqld --help --verbose
  ```

- 官方参考地址

> https://mariadb.com/kb/en/library/configuring-mariadb-with-option-files/

### Linux 上的默认选项文件位置

> 当 cmake 构建源码时，如果 `DEFAULT_SYSCONFDIR` 选项没有定义，MariaDB 的会安装以下顺序位置依次读取选项文件：

| 位置                 | 范围                                       |
| -------------------- | ------------------------------------------ |
| /etc/my.cnf          | 全局                                       |
| /etc/mysql/my.cnf    | 全局                                       |
| `$MYSQL_HOME/my.cnf` | 服务器                                     |
| defaults-extra-file  | --defaults-extra-file 指定的文件如果有的话 |
| ~/.my.cnf            | 用户                                       |

> 当 cmake 构建源码时，如果 `DEFAULT_SYSCONFDIR` 选项被定义，MariaDB 的会安装以下顺序位置依次读取选项文件：

| 位置                      | 范围                                       |
| ------------------------- | ------------------------------------------ |
| DEFAULT_SYSCONFDIR/my.cnf | 全局                                       |
| `$MYSQL_HOME/my.cnf`      | 服务器                                     |
| defaults-extra-file       | --defaults-extra-file 指定的文件如果有的话 |
| ~/.my.cnf                 | 用户                                       |

> 关于 `$MYSQL_HOME` 解释

```text
MYSQL_HOME是环境变量，指定了my.cnf文件所在目录的路径，
如果MYSQL_HOME未设置，并且服务器以mysqld_safe启动，MYSQL_HOME则会按如下规则设置默认值：
    - 如果MariaDB数据目录中有my.cnf文件，并且MariaDB基本目录中没有my.cnf文件，MYSQL_HOME则设置为MariaDB数据目录；
    - 除此以外，MYSQL_HOME将设置为MariaDB基目录。
```

### 默认选项文件层次结构

> MariaDB 将按顺序查看上述所有位置。

```text
即使已找到选项文件，也可能存在多个选项文件。例如：
    - 您可以使用 /etc/my.cnf 选择文件设置服务器的全局选项；
    - 然后您可以使用用户帐户的主目录 ~/.my.cnf，该文件将指定仅针对当前用户的其它选项（或覆盖先前指定的选项）。
```

> 如果通过 `--defaults-file=<path>` 指定了选项文件，那么：

```text
- 仅从给定选项文件中读取选项配置;
- 如果该文件不存在，则初始化 MariaDB 时，将引发错误提示。
```

### 自定义选项文件位置

> MariaDB 可以使用以下命令行参数从自定义选项文件中读取选项：

| 选项                         | 描述                                              |
| ---------------------------- | ------------------------------------------------- |
| --defaults-file=<path>       | 仅从给定选项文件中读取选项                        |
| --defaults-extra-file=<path> | 读取所有其他选项文件后，再读取这个 `额外选项文件` |

```text
- 这些命令行参数可以与MariaDB的大多数命令行工具一起使用，而不仅仅是mysqld。
- 它们必须作为命令的第一个参数给出，如：mysqld --defaults-file=<path>
```

## 选项文件语法

> MariaDB 选项文件的语法是：

```text
- 以＃开头的行是注释；
- 空行被忽略；
- 选项组使用语法[group-name]，如：[mysqld]；
- 相同的选项组可以多次出现；
- include 指令可用于包含其他选项文件；
- includedir 指令可用于包含给定目录中的所有“.cnf文件”(可能还包括“.cnf文件”)，目录中的选项文件按字母顺序读取；
- 选项中的虚线“-”和下划线“_”意义是一样的；
- 支持某些选项前缀；
```

## 选项组

> 选项组分为 `服务器选项组` 和 `客户选项组`

### 服务器选项组

> MariaDB 程序从以下服务器选项组中读取服务器选项：

| 选项组          | 描述                                                                 |
| --------------- | -------------------------------------------------------------------- |
| [mysqld]        | 由 mysqld 读取的选项（包括 `MariaDB Server` 和 `MySQL Server` ）     |
| [client-server] | 由 `MariaDB client` 和 `MariaDB Server` 共同读取的选项               |
| [server]        | 由 `MariaDB Server` 读取的选项                                       |
| [mariadb]       | 由 `MariaDB Server` 读取的选项                                       |
| [galera]        | 由 `MariaDB Server` 读取的选项(仅使用 Galera Cluster 编译的才会读取) |
| [mysqld-X.Y]    | 由特定版本的 mysqld 读取的选项，如：[mysqld-5.5]                     |
| [mariadb-X.Y]   | 由特定版本的 `MariaDB Server` 读取的选项。例如，[mariadb-10.3]       |

> 最常用的就是 `[client-server]` 和 `[mysqld]` 这两个

### 客户选项组

> MariaDB 程序从以下选项组中读取客户端选项：

| 组               | 描述                                                            |
| ---------------- | --------------------------------------------------------------- |
| [client]         | 所有 MariaDB 和 MySQL 客户端程序都读取的选项(例如：mysqldump)。 |
| [client-server]  | 同服务器选项组中的同名选项                                      |
| [client-mariadb] | 所有 MariaDB 客户端程序都读取的选项。                           |

> 最常用的就是 `[client-server]` 和 `[client]` 这两个

```text
- 除了公共组之外，许多客户端程序还将从选项组中读取与程序名称相同的客户机选项。
- 例如：mysqldump 还从 [mysqldump] 选项组中读取客户端选项。
```

### 自定义选项组后缀

> 这个不讲解，可以查看手册说明

## 包含选项文件

> 选项文件可以包含其他选项文件，例如：要包含 /etc/mysql/my001.cnf 选项文件的信息，选项文件可以添加这样一行

```ini
[mysqld]
...
!include /etc/mysql/my001.cnf
```

## 包括选项文件目录

> 也可以将目录中所有的选项文件包含在另一个选项文件里。例如，要包含 `/etc/my.cnf.d/` 目录下，所有选项文件：

```ini
[mysqld]
...
!includedir /etc/my.cnf.d/
```

> - 注意 1：目录中的选项文件按字母顺序读取；
> - 注意 2：类 Unix 操作系统上，所有选项文件名必须以 .cnf 结尾；
> - 注意 3：在 Windows 上，所有选项文件名必须以 .cnf 或结尾.ini。

## 检查程序选项

> 您可以使用 `--print-defaults` 命令行参数检查给定程序将使用哪些选项，这里我们忽略不讲

## 选项前缀

> MariaDB 支持可与选项一起使用的某些前缀。支持的选项前缀是：

| 选项前缀 | 描述                                                                |
| -------- | ------------------------------------------------------------------- |
| autoset  | 自动设置选项值。仅支持某些选项。                                    |
| disable  | 对于所有布尔选项，禁用该设置（相当于将其设置为 0）。与 skip 相同    |
| enable   | 对于所有布尔选项，启用设置（相当于将其设置为 1）。                  |
| loose    | 如果该选项不存在，请不要生成错误。                                  |
| maximum  | 设置选项的最大值。                                                  |
| skip     | 对于所有布尔选项，禁用该设置（相当于将其设置为 0）。与 disable 相同 |

> 案例：

```ini
[mariadb]
...
# 自动为open_files_limit确定一个好的值
autoset_open_files_limit

# 禁用unix套接字插件
disable_unix_socket

# 启用慢查询日志
enable_slow_query_log

# 如果这些选项不存在，则不会产生错误
loose_file_key_management_filename = /etc/mysql/encryption/keyfile.enc
loose_file_key_management_filekey = FILE:/etc/mysql/encryption/keyfile.key
loose_file_key_management_encryption_algorithm = AES_CTR

# 设置 max_allowed_pa​​cket为最大值
maximum_max_allowed_packet

# 禁用MyISAM的外部锁定
skip_external_locking
```

## 选项

> 选项中的虚线 `-` 和下划线 `_` 是可互换的，如果未明确设置选项，则服务器或客户端将仅使用该选项的默认值。

### MariaDB 服务器选项

### MariaDB 客户端选项

### 示例选项文件

> 在源代码发布中，示例选项文件通常位于 support-files 目录中；而在其他发行版中，示例选项文件通常位于 share/mysql 与 MariaDB 基本安装目录相关的目录中。

1. 示例一、最小选项文件

   > 以下是可用于测试 MariaDB 的最小 my.cnf 文件：

   ```ini
   [client-server]
   # 如果要使用与MariaDB的非标准连接，请取消下面两行注释
   #socket=/tmp/mysql.sock
   #port=3306

   # 这将传递给所有MariaDB客户端
   [client]
   #password=my_password

   # MariaDB服务器
   [mysqld]
   # 要放置数据的目录
   data=/usr/local/mysql/var
   # 您要使用的语言的 errmsg.sys 文件的目录
   language=/usr/local/share/mysql/english

   # 这是用于所有日志，错误和复制文件的前缀名称
   log-basename=mysqld

   # 默认启用日志记录以帮助查找问题
   general-log
   log-slow-queries
   ```

2. 示例二、混合选项文件

   > 以下是选项文件的摘录，如果想要同时使用 MySQL 和 MariaDB，则可以使用该文件：

   ```ini
   # mysql配置文件示例

   [client-server]
   socket=/tmp/mysql-dbug.sock
   port=3307

   # 这将传递给所有mysql客户端
   [client]
   password=my_password

   # 以下是某些特定程序的条目
   # 以下值假设您至少有 32M 内存

   # MySQL服务器
   [mysqld]
   temp-pool
   key_buffer_size=16M
   datadir=/my/mysqldata
   loose-innodb_file_per_table

   [mariadb]
   datadir=/my/data
   default-storage-engine=aria
   loose-mutex-deadlock-detector
   max-connections=20

   [mariadb-5.5]
   language=/my/maria-5.5/sql/share/english/
   socket=/tmp/mysql-dbug.sock
   port=3307

   [mariadb-10.1]
   language=/my/maria-10.1/sql/share/english/
   socket=/tmp/mysql2-dbug.sock

   [mysqldump]
   quick
   max_allowed_packet=16M

   [mysql]
   no-auto-rehash
   loose-abort-source-on-error
   ```
