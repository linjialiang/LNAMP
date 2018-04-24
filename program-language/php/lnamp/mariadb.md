# **mariadb 安装、配置与管理**

> `mariaDB` 数据管理系统是 `MySQL` 的一个分支，各大 `Linux` 发行版本逐渐用 `mariaDB` 来替代 `MySQL`

## **安装 `mariaDB`**

> Debian下安装 `mariaDB` 十分简单

```shell
# apt-get install mariadb-server
```

## **`mariaDB` 服务器配置文件**

> - 刚刚安装好的 `mariadb` 需要通过进一步配置，才能更好的使用
> - 服务器配置文件位置： `/etc/mysql/mariadb.conf.d/50-server.cnf`

### **备份 `mariaDB` 配置文件**

```shell
# cp /etc/mysql/mariadb.conf.d/50-server.cnf{,.backup}
# vim /etc/mysql/mariadb.conf.d/50-server.cnf
```

### **修改 `mariaDB` 数据存放目录**

> `mariaDB` 安装时默认将数据存放路径安装在系统盘里的，所以需要将数据存放路径修改到指定位置

1. _配置文件_

  ```conf
  ## datadir       = /var/lib/mysql        ### 将默认路径注释掉
  datadir         = /alidata/mysql        ### 增加自定义的路径
  ```

2. _备份并移动数据存放目录_

  ```shell
  # cp /var/lib/mysql{,.backup}
  # mv /var/lib/mysql /alidata/mysql
  ```

### **让 `mariaDB` 支持远程管理工具**

> 数据库管理工具，操作 mariaDB 变得更加方便与高效

1. _配置文件_

  ```conf
  ## 找到下面这2行并注释掉，
  ## skip-networking                    ## Debian 9.x 默认没有这行
  ## bind-address       = 127.0.0.1
  ```

2. _新建远程 `mariadb` 账户_

  > 授权管理员权限是很危险的

  ```shell
  # /etc/init.d/mysql restart
  # mysql
  MariaDB [(none)]> CREATE USER 'user1'@'%';
  MariaDB [(none)]> SET PASSWORD FOR 'user1'@'%' = PASSWORD('123456');
  MariaDB [(none)]> GRANT ALL ON *.* TO 'user1'@'%';
  MariaDB [(none)]> FLUSH PRIVILEGES;
  ```

  > 注意：用以上命令授权的用户不能给其它用户授权，如果想让该用户可以授权，用以下命令:

  ```shell
  MariaDB [(none)]> GRANT ALL ON *.* TO 'user1'@'%' WITH GRANT OPTION;
  MariaDB [(none)]> FLUSH PRIVILEGES;
  ```

### **更改 `mariaDB` 日志路径**

> 1. 错误日志 `log_error`
> 2. 普通日志 `general_log` （警告!开启general_log会影响性能，谨慎使用。正式系统用完要关闭！)

1. 配置文件

  ```conf
  ## 找到这行，换成自己的错误日志路径
  ## log_error = /var/log/mysql/error.log
  log_error = /alidata/log/mysql/error.log
  ```

2. 复制错误日志文件到指定位置

  ```shell
  # cp -p -r /var/log/mysql/error.log /alidata/log/mysql/error.log
  ```

3. 配置文件

  ```conf
  ## 找到这两行，，默认是注释掉的，我们开放并修改
  # general_log_file = /var/log/mysql/mysql.log
  # general_log = 1
  general_log_file = /alidata/log/mysql/mysql.log
  general_log = 1
  ```

4. 新建 `mysql.log` 文件

  ```shell
  # touch /alidata/log/mysql/mysql.log
  # chown mysql:adm /alidata/log/mysql/mysql.log

  # /etc/init.d/mysql restart
  ```

5. 处理好问题后， `general_log` 需要及时关闭，这样才不会影响服务器性能

  ```conf
  ## 找到并注释掉下面两行
  ## general_log_file       = /alidata/log/mysql/mysql.log
  ## general_log            = 1
  ```

  ```shell
  # /etc/init.d/mysql restart
  ```

## **`mysql.user` 表说明**

> `user` 表用于配置 `mariaDB` 用户登录问题，及用户操作权限

### **`user` 表下的 `plugin` `password` `authentication_string` 3个字段关系**

> `plugin` 字段的三种写法

> 1. `unix_sicket`
> 2. `mysql_native_password`
> 3. 空白（下面用 `null` 代表）

`plugin`                | `password` | `authentication_string` | `user` 字段关系说明
----------------------- | ---------- | ----------------------- | -----------------------------
`unix_sicket`           | no         | no                      | 只能使用本地的root账户登录，不需要密码
`mysql_native_password` | no         | yes                     | `authentication_string` 字段为密码
`null`                  | yes        | no                      | `password` 字段为密码

## **`mariaDB` 权限介绍**

> 明白了权限问题，我们才能在工作中配置一个安全的 `mariaDB`

### **`mariaDB` 权限表验证过程**

> `mariaDB` 中存在4个控制权限的表：user表、db表、tables_priv表、columns_priv表

> 1. 先用 `user` 表中的 host， user， password， plugin， authentication_string 这几个字段中判断链接的ip、用户名、密码是否正确，正确则通过验证；
> 2. 通过身份认证后，进行权限分配，按照 `user` `db` `tables_priv` `columns_priv` 的顺序进行验证；
> 3. 先检查全局权限表 `user` ，如果 `user` 中对应的权限为Y，则此用户对所有数据库的权限都为Y，将不再检查 `db` `tables_priv` `columns_priv`；
> 4. 如果为N，则到 `db` 表中检查此用户对应的具体数据库，并得到 `db` 中为Y的权限;
> 5. 如果 `db` 中为N，则检查 `tables_priv` 中此数据库对应的具体表，取得表中的权限Y，以此类推

### **`mariaDB` 的权限**

权限                       | 权限级别                                                                             | 权限说明
------------------------ | -------------------------------------------------------------------------------- | ----------------------------------------------------------------------------
`Select_priv`            | 表-查询权限                                                                           | 用户可以通过SELECT命令选择数据
`Insert_priv`            | 表-插入权限                                                                           | 用户可以通过INSERT命令插入数据
`Update_priv`            | 表-更新权限                                                                           | 用户可以通过UPDATE命令修改现有数据
`Delete_priv`            | 表-删除权限                                                                           | 用户可以通过DELETE命令删除现有数据
`Create_priv`            | 数据库、表、索引-创建权限                                                                    | 用户可以创建新的数据库和表和索引
`Drop_priv`              | 数据库、表-删除权限                                                                       | 用户可以删除现有数据库和表
`Reload_priv`            | 服务器管理                                                                            | 用户可以执行刷新和重新加载MySQL所用各种内部缓存的特定命令,包括日志、权限、主机、查询和表;重新加载权限表
`Shutdown_priv`          | 服务器管理                                                                            | 用户可以关闭MySQL服务器;在将此权限提供给root账户之外的任何用户时,都应当非常谨慎
`Process_priv`           | 服务器管理                                                                            | 用户可以通过SHOW PROCESSLIST命令查看其他用户的进程;服务器管理
`File_priv`              | 服务器主机上的文件访问                                                                      | 用户可以执行SELECT INTO OUTFILE和LOAD DATA INFILE命令;加载服务器上的文件
`Grant_priv`             | 数据库、表或保存的程序                                                                      | 用户可以将已经授予给该用户自己的权限再授予其他用户（任何用户赋予全部已有权限）
`References_priv`        | 现在没有作用                                                                           | 目前只是某些未来功能的占位符
`Index_priv`             | 表-索引权限                                                                           | 用户可以创建和删除表索引，用索引查询表
`Alter_priv`             | 表-更改表权限                                                                          | 用户可以重命名和修改表结构
`Show_db_priv`           | 服务器管理-查看数据库权限                                                                    | 用户可以查看服务器上所有数据库的名字,包括用户拥有足够访问权限的数据库;可以考虑对所有用户禁用这个权限,除非有特别不可抗拒的原因
`Super_priv`             | 服务器管理-执行kill线程权限                                                                 | 用户可以执行某些强大的管理功能,例如通过KILL命令删除用户进程,使用SET GLOBAL修改全局MySQL变量,执行关于复制和日志的各种命令;超级权限
`Create_tmp_table_priv`  | 服务器管理                                                                            | 用户可以创建临时表
`Lock_tables_priv`       | 服务器管理-锁表权限                                                                       | 用户可以使用LOCK TABLES命令阻止对表的访问/修改
`Execute_priv`           | 存储过程-执行存储过程权限                                                                    | 此权限只在MySQL 5.0及更高版本中有意义
`Repl_slave_priv`        | 服务器管理-复制权限                                                                       | 用户可以读取用于维护复制数据库环境的二进制日志文件;此用户位于主系统中,有利于主机和客户机之间的通信;主服务器管理
`Repl_client_priv`       | 服务器管理-复制权限                                                                       | 用户可以确定复制从服务器和主服务器的位置;从服务器管理
`Create_view_priv`       | 视图-创建视图                                                                          | 用户可以创建视图;此权限只在MySQL 5.0及更高版本中有意义
`Show_view_priv`         | 视图-查看视图                                                                          | 用户可以查看视图或了解视图如何执行;此权限只在MySQL 5.0及更高版本中有意义
`Create_routine_priv`    | 存储过程-创建存储过程权限                                                                    | 用户可以更改或放弃存储过程和函数;此权限是在MySQL 5.0中引入的
`Alter_routine_priv`     | 存储过程-更改存储过程权限                                                                    | 用户可以修改或删除存储函数及函数;此权限是在MySQL 5.0中引入的
`Create_user_priv`       | 服务器管理-创建用户权限                                                                     | 用户可以执行CREATE USER命令,这个命令用于创建新的MySQL账户
`Event_priv`             | 创建事件调度器                                                                          | 用户能否创建、修改和删除事件;这个权限是MySQL 5.1.6新增的
`Trigger_priv`           | 创建触发器                                                                            | 用户能否创建和删除触发器,这个权限是MySQL 5.1.6新增的
`Create_tablespace_priv` | 创建表空间                                                                            |
`ssl_type`               | 支持ssl标准加密安全字段                                                                    |
`ssl_cipher`             | 支持ssl标准加密安全字段                                                                    |
`x509_issuer`            | 支持x509标准字段                                                                       |
`x509_subject`           | 支持x509标准字段                                                                       |
`max_questions`          | 0 每小时允许执行多少次查询                                                                   |
`max_updates`            | 0 每小时可以执行多少次更新（0表示无限制）                                                           |
`max_connections`        | 0 每小时可以建立的多少次连接（0表示无限制）                                                          |
`max_user_connections`   | 0 单用户可以同时具有的连接数（0表示无限制）                                                          |
`plugin`                 | 5.5.7开始,mysql引入plugins以进行用户连接时的密码验证,plugin创建外部/代理用户                              |
`authentication_string`  | 通过authentication_string可以控制两者的映射关系,（PAM plugin等,PAM可以支持多个服务名）尤其是在使用代理用户时，并须声明这一点 |
`password_expired`       | 密码过期 Y,说明该用户密码已过期 N相反                                                            |

## **`mariaDB` 常用指令**

## **一些常用sql语句**

## **`phpmyadmin` 配置文件**

### **配置文件所在位置**

> apt-get 安装的 在/user/share/phpmyadmin 下面 自己安装的，位置由自己指定，安全起见，一般都是设置别名，并且也应该独立开启一个目录

- /etc/phpmyadmin/config.inc.php # 这是debian本地默认配置文件，会覆盖phpmyadmin的配置文件，只有用 `apt-get install phpmyadmin` 安装才有
- /usr/share/phpmyadmin/config.sample.inc.php # 这是参考的配置，拷贝一份 `config.sample.inc.php` 到当前目录
- /usr/share/phpmyadmin/config.inc.php # 这是会生效的配置，如果没有就新建一个，一般是拷贝 `config.sample.inc.php` 内容
- /usr/share/phpmyadmin/libraries/config.default.php # 这是默认的配置，一般不去改动

### **简单的修改配置文件**

```php
# cookie模式最好
/* Authentication type and info */
# $cfg['Servers'][$i]['auth_type'] = 'config';
# $cfg['Servers'][$i]['user'] = 'root';
# $cfg['Servers'][$i]['password'] = '';
# $cfg['Servers'][$i]['extension'] = 'mysqli';
# $cfg['Servers'][$i]['AllowNoPassword'] = true;
# $cfg['Lang'] = '';
$cfg['Servers'][$i]['auth_type'] = 'cookie';

# 高级功能用户、密码可设置为空
/* User for advanced features */
# $cfg['Servers'][$i]['controluser'] = 'pma';
# $cfg['Servers'][$i]['controlpass'] = '';
$cfg['Servers'][$i]['controluser'] = '';
$cfg['Servers'][$i]['controlpass'] = '';

# 主题风格更改为original
$cfg['ThemeDefault'] = 'original';
```

### **`phpMyAdmin` 一些注意事项**

1. phpmyadmin数据库提供phpmyadmin的高级功能，如果删除，高级功能将无法使用 – 如果未安装或已经删除，可以在找到原因那里，点击Create自动创建
2. `phpMyAdmin` 连接数据库使用的是php的mysqli扩展，所以php必须安装mysqli扩展包

--------------------------------------------------------------------------------
