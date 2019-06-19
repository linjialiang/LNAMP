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
    设置为normal：
        - 则会创建一个root@localhost帐户；
        - 该帐户使用 `mysql_native_password 身份验证插件` 进行验证；
        - 并且没有设置初始密码，这可能是不安全的。
    设置为socket：
        - 创建一个 root@localhost 帐户；
        - 并且使用 `unix_socket 身份验证插件` 进行身份验证的帐户；
        - 在 `MariaDB 10.4.3` 中成为默认值。
    默认值：normal （自MariaDB 10.1起）
    ```

2.  --auth-root-socket-user=<linux 用户>

    ```text
    --auth-root-authentication-method=socket才起作用：
         1. “mysql数据库”中创建了具有超级权限的root账号；
         2. 指定一个linux本地用户，并设置为第2个允许访问“mysql数据库”的账户。

    默认值：--user=<user_name> 选项的值
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

19. --verbose

    > 详细模式。打印有关程序功能的更多信息

20. --windows

    > 供内部使用。此选项用于创建 Windows 分发。

## 登录验证方式

> mariadb 主要有 `unix_socket` 和 `mysql_native_password` 两种登录验证方式！

### unix_socket 身份验证插件

> 官方说明地址：https://mariadb.com/kb/en/library/authentication-plugin-unix-socket/

```text
当用户通过本地Unix套接字文件连接到MariaDB时，
    - unix_socket身份验证插件允许用户使用操作系统凭据；
    - 这个Unix套接字文件由 “socket” 系统变量定义。

unix_socket认证插件的工作原理是：
    - unix_socket身份验证插件使用SO_PEERCRED套接字选项调用getsockopt系统调用；
    - 该选项允许它检索连接到套接字的进程的uid；
    - 然后，它能够获得与该uid关联的用户名；
    - 一旦有了用户名，它就会将连接的用户身份验证为具有相同用户名的MariaDB帐户。
```

1.  禁用插件

    > 在 MariaDB 10.4.3 及更高版本中，unix_socket 默认情况下会安装身份验证插件，因此如果您不希望它们在这些版本上默认可用，则需要禁用它。

    ```ini
    # 通过将unix_socket选项设置为OFF，重新启动mariadb服务，可以禁用unix_socket身份验证插件
    # 这可以指定为mysqld的命令行参数，也可以在选项文件中的相关服务器选项组中指定
    [mariadb]
    ...
    unix_socket=OFF
    ```

    ```ini
    # 作为一种替代方法，unix_socket选项也可以通过将该选项与disable选项前缀配对来设置为OFF。
    [mariadb]
    ...
    disable_unix_socket
    ```

2.  安装插件

    > 在 MariaDB 10.4.3 及更高版本中，unix_socket 默认情况下会安装身份验证插件，因此可以在这些版本上跳过此步骤。

    ```text
    在其它版本中，尽管插件的共享库默认使用auth_socket与MariaDB一起发布：
     - 但是默认情况下，MariaDB实际上并没有安装这个插件；
     - 有两种方法可以使用MariaDB安装插件。
    ```

    > 一、可通过执行 `INSTALL SONAME` 或 `INSTALL PLUGIN` 来动态安装插件，这种方式不需要重启服务器。

    ```shell
    $ mysql -uroot -p 123456
    mysql > INSTALL SONAME 'auth_socket';
    ```

    > 二、可以通过设置 `--plugin-load` 或 `--plugin-load-add` 选项来安装插件

    ```text
    - 这可以指定为 mysqld 的命令行参数，也可以在选项文件中的相关服务器选项组中指定；
    - 这个需要重新启动 mysqld 服务。
    ```

    ```ini
    [mariadb]
    ...
    plugin_load_add = auth_socket
    ```

3.  卸载插件

    > 您可以通过执行 `UNINSTALL SONAME` 或 `UNINSTALL PLUGIN` 动态卸载插件。例如：

    ```shell
    $ mysql -uroot -p 123456
    mysql > UNINSTALL SONAME 'auth_socket';
    ```

4.  创建用户

    > 要通过 `CREATE USER` 创建用户帐户，请在 `IDENTIFIED VIA` 子句中指定插件的名称：

    ```shell
    mysql > CREATE USER username@hostname IDENTIFIED VIA unix_socket;
    ```

5.  切换到基于密码的身份验证

    ```text
    有时候 Unix socket 身份验证不能满足您的需要
        - 因此最好将用户帐户切换回基于密码的身份验证；
        - 先通过执行 “ALTER USER” 语句，告诉MariaDB为帐户使用另一个身份验证插件；
        - 再使用 “IDENTIFIED VIA” 子句指定特定的身份验证插件；
    ```

    > 例如，如果您想切换到 mysql_native_password 身份验证插件，那么您可以执行:

    ```shell
    mysql > ALTER USER root@localhost IDENTIFIED VIA mysql_native_password;
    mysql > SET PASSWORD = PASSWORD('密码');
    ```

    ```ini
    # 注意，如果您的操作系统有脚本需要对MariaDB进行无密码访问，那么这可能会破坏这些脚本。
    # 您可以通过在 my.cnf 选项文件中的 [client] 选项组中设置密码来解决这个问题。
    [client]
    password=密码
    ```

6.  选项

    > unix_socket 在 my.cnf 等选项文件中的选项值

    ```text
    控制 mysqld 服务启动时应如何处理 unix_socket 插件。
        - 有效值：
            OFF - 禁用插件而不将其从mysql.plugins表中删除。
            ON - 启用插件。如果无法初始化插件，则服务器仍将继续启动，但该插件将被禁用。
            FORCE - 启用插件。如果无法初始化插件，则服务器将无法启动并显示错误。
            FORCE_PLUS_PERMANENT - 启用插件。如果无法初始化插件，则服务器将无法启动并显示错误。此外，无法在服务器运行时，使用 UNINSTALL SONAME 或 UNINSTALL PLUGIN 卸载插件。
        - 默认值： ON
    ```

7.  命令行

    ```shell
    --unix-socket={OFF|ON|FORCR|FORCE_PLUS_PERMANENT}
    ```

### mysql_native_password 身份验证插件

> 官方说明地址：https://mariadb.com/kb/en/library/authentication-plugin-mysql_native_password/

```text
mysql_native_password 身份验证插件,是默认的身份验证插件；
 - 当没有显式提到身份验证插件，并且设置 old_password=0 时，将使用该插件创建帐户；
 - 它使用MySQL 4.1中引入的密码哈希算法；
 - 当设置 old_password=0 时，PASSWORD()函数也使用它；
 - 该哈希算法基于SHA-1。
```

1. 安装插件

> mysql_native_password 身份验证插件是静态链接到服务器的，因此不需要安装。

2. 创建用户

    ```text
    使用 mysql_native_password身份验证插件 创建用户帐户的最简单方法是：
       - 确保设置了old_password=0；
       - 通过不指定身份验证插件的create user创建一个用户帐户；
       - 通过 `IDENTIFIED BY` 子句指定密码。
    ```

    ```shell
    mysql > SET old_passwords=0;
    mysql > CREATE USER username@hostname IDENTIFIED BY 'password';
    ```

3. 更改用户密码
   > 您可以使用 `SET PASSWORD` 语句更改用户帐户的密码，同时提供纯文本密码作为 PASSWORD()函数的参数。例如：

   ```shell
   mysql > SET PASSWORD =  PASSWORD('newpassword');
   ```

   ```text
   您还可以使用该 ALTER USER 语句更改用户帐户的密码。
    - 您必须确保 old_passwords=0 已设置；
    - 然后您必须通过该 IDENTIFIED BY 子句指定密码。例如：
        SET old_passwords=0;
        ALTER USER username@hostname IDENTIFIED BY 'newpassword';
   ```
