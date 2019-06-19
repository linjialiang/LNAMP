# mysql_install_db 选项

> mysql_install_db 用于初始化 MariaDB 数据目录并在数据库名为 `mysql` 的数据库中创建系统表（如果它们不存在）。
>
> - 官方地址： https://mariadb.com/kb/en/library/mysql_install_db/
> - MariaDB 使用 `数据库mysql中的这些表` 来管理权限、角色和插件；
> - MariaDB 还使用 `数据库mysql中的这些表` 为客户端中的 help 命令提供数据 mysql；
> - mysql_install_db 通过 mysqld 在 --bootstrap 模式下启动 MariaDB Server 的进程并发送命令来创建系统表及其内容。

## 使用 mysqld_install_db

> 要调用 mysql_install_db，请使用以下语法：

```shell
$ mysql_install_db [options]
```

```text
由于 mysqld 在运行时需要访问数据目录，
    - 您应该从用 `运行mysqld程序的相同用户` 或 `root用户` 运行 mysql_install_db；
    - `--user` 选项用来指定 mysqld 程序的用户名；
    - 可能需要指定其他选项，例如： mysql_install_db 可以使用 --basedir 和 --datadir 两个选项用于指定安装目录和数据目录的正确位置。
```

```shell
$ scripts/mysql_install_db --user=mysql \
   --basedir=/opt/mysql/mysql \
   --datadir=/opt/mysql/mysql/data
```

## 选项

> mysql_install_db 支持以下选项：

1.  --auth-root-authentication-method={normal/socket}

    ```text
    如果设置为normal：
        - 则会创建一个root@localhost帐户；
        - 该帐户使用身份 mysql_native_password 验证插件进行身份验证，并且没有设置初始密码，这可能是不安全的。
    如果设置为socket：
        - 则会创建一个 root@localhost 使用 unix_socket 身份验证插件进行身份验证的帐户。

    默认值：normal （自MariaDB 10.1起）
    ```

2.  --auth-root-socket-user=<linux 用户>

    ```text
    --auth-root-authentication-method=socket才起作用：
         1. 创建了“名为mysql数据库”中具有超级权限的root账号；
         2. 指定本地允许访问“名为mysql数据库”的第二个linux用户（linux的root用户始终允许访问“名为mysql数据库”）。

    默认值：默认为--user选项的值
    ```

3.  --basedir=path

    > MariaDB 安装目录的路径。

4.  --builddir=path

    > 如果在--srcdir 目录外构建文件，就需要将这个选项的值设置为构建文件所在的路径。

5.  --cross-bootstrap

    > 供内部使用。在与目标不同的主机上构建 MariaDB 系统表时使用。

6.  `--datadir=path` 和 `--ldata=path`

    > MariaDB 数据目录的路径。

7.  --defaults-extra-file=name

    > 读取全局文件后读取此文件，必须作为第一个选项。

8.  --defaults-file=name

    > 只读取给定文件名中的默认选项，必须作为第一个选项。

9.  --defaults-group-suffix=name

    > 除了给定的组，还要读取具有此后缀的组。

10. --force

    > mysql_install_db 即使 DNS 不起作用也会导致运行。在这种情况下，通常使用主机名的授权表条目将使用 IP 地址。

11. --no-defaults

    > 不要从任何选项文件中读取默认选项，必须作为第一个选项。

12. --print-defaults

    > 打印程序参数列表并退出，必须作为第一个选项。

13. --rpm

    > 供内部使用。在 MariaDB 安装过程中，RPM 文件使用此选项。

14. --skip-auth-anonymous-user

    > 不要创建匿名用户

15. --skip-name-resolve

    > 创建授权表条目时使用 IP 地址而不是主机名。如果您的 DNS 不起作用，此选项非常有用。

16. --skip-test-db

    > 不要安装测试数据库。

17. --srcdir=path

    ```text
    供内部使用，MariaDB源目录的路径。
        -- 此选项使用源树中编译的二进制文件和支持文件；
        -- 如果您不想安装MariaDB并且只想创建系统表，则此选项非常有用；
        -- mysql_install_db 查找支持文件的目录，例如错误消息文件和用于填充帮助表的文件。
    ```

18. --user=user_name

    ```text
    用于指定登录mysqld和运行mysqld的用户名：
        -- mysqld由此用户拥有的文件和目录将归该用户所有。您必须root使用此选项。
    默认情况下：
        - mysqld程序使用当前linux登录用户；
        - 创建的文件和目录都将归属当前linux登录用户。
    ```

    | --verbose |
    | --windows |
