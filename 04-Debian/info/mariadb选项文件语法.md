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

| 选项                         | 描述                                           |
| ---------------------------- | ---------------------------------------------- |
| --defaults-file=<path>       | 仅从给定选项文件中读取选项。                   |
| --defaults-extra-file=<path> | 读取所有其他选项文件后，请阅读此额外选项文件。 |

```text
- 这些命令行参数可以与MariaDB的大多数命令行工具一起使用，而不仅仅是mysqld。
- 它们必须作为命令的第一个参数给出，如：mysqld --defaults-file=<path>
```
