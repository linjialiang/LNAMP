# **mariadb 安装、配置与管理**

> `mariaDB` 数据管理系统是 `MySQL` 的一个分支，各大 `Linux` 发行版本逐渐用 `mariaDB` 来替代 `MySQL`

## **安装 `mariaDB`**

> Debian下安装 `mariaDB` 十分简单

> ```shell
> # apt-get install maraidb-server
> ```

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

3. _配置文件_

  ```conf
  ## 找到下面这2行并注释掉，
  ## skip-networking                    ## Debian 9.x 默认没有这行
  ## bind-address       = 127.0.0.1
  ```

4. _新建远程 `mariadb` 账户_

  > 授权管理员权限是很危险的

  > ```shell
  > # /etc/init.d/mysql restart
  > # mysql
  > MariaDB [(none)]> CREATE USER 'user1'@'%';
  > MariaDB [(none)]> SET PASSWORD FOR 'user1'@'%' = PASSWORD('123456');
  > MariaDB [(none)]> GRANT ALL PRIVILEGES ON *.* TO 'user1'@'%';
  > MariaDB [(none)]> FLUSH PRIVILEGES;
  > ```

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
> 1. `mariaDB` 中存在4个控制权限的表：user表、db表、tables_priv表、columns_priv表
> 2. 
