# 配置 mariadb

## 创建 my.ini 文件

> my.ini 是 mariadb 配置文件，我们在mariadb根目录上创建my.ini，并输入以下内容

```shell
[client]
port = 3306

[mysqld]
port = 3306
datadir = "c:/wamp/data"
```

> - 提示：`innodb` 索引扩展默认会跟 `datadir` 同级，如无必要不用配置
> - 注意：需要将mariadb根目录下的data目录下的全部数据复制到指定的路径下

## windows下mariadb配置文件my.ini路径相关

> 默认情况下mariadb支持读取的配置文件路径 `c:\my.ini` 和 `mariadb根目录下的my.ini`

my.ini路径             | 描述
-------------------- | -----
`mariadb根目录下的my.ini` | 默认可读取
`c:\my.ini`          | 默认可读取

> my.ini 路径优先顺序

优先序号 | 描述                                       | 是否需要定义
---- | ---------------------------------------- | --------------
1    | `--defaults-file="指定my.ini所在路径"` 具有最高优先权 | 必须指定路径
2    | `mariadb根目录下的my.ini`                     | 不需要定义，文件存在即可获取
3    | `c:\my.ini` 路径                           | 不需要定义，文件存在即可获取

> mariadb只会获取一个my.ini，如果存在多个my.ini就会获取存在的路径中，最优先的那个

## 初始化mariadb数据

> 初始化 `mariadb数据库存放目录的数据` 需要如下几个步骤：

序号  | 初始化步骤内容
--- | -----------------------------------------------
1   | 将data目录内容复制到指定的mariadb数据库存放目录
2   | 打开cmd（需管理员权限）
3   | cmd进入mariadb的bin目录
4   | 查找mariadb配置文件my.ini
5   | 获取mariadb数据存放目录（一般都是命名data）所在位置
6   | 开始执行初始化操作
7   | 数据存放目录的数据会被初始化
8-1 | 使用`mysqld --initialize`指令，root用户会生成随机密码，日志中查看密码
8-2 | 使用`mysqld --initialize-insecure`指令，root用户空密码

> 初始化 `mariadb数据库存放目录的数据` 相关说明

序号 | 初始化相关问题                     | 描述
-- | --------------------------- | ------------------------------
1  | my.ini中的数据库存放目录不是默认目录，会怎么办？ | my.ini下自定的数据库存放目录优先
2  | my.ini中指定的数据库存放目录没有找到，会怎么办？ | mariadb根目录下的数据库存放目录`data`会被初始化
3  | 没有找到my.ini，会怎么办？            | mariadb根目录下的数据库存放目录`data`会被初始化

## 配置phpmyadmin

> phpmyadmin 是一款非常优秀的web端数据库管理平台，使用语言php，支持mysql和mariadb

### phpmyadmin配置文件

- 默认配置文件

  > `libraries/config.default.php` 是phpmyadmin的默认配置文件，建议不要修改

- 创建phpmyadmin配置文件

  > 所有自己配置的内容都放在 `config.inc.php` 文件内（phpmyadmin根目录，如果不存在就需要手动新建一个）！

- `config.sample.inc.php` 文件

  > 这是让我们参考的文件，我们也可以直接复制一份黏贴到 `config.inc.php` 文件

- 一个简洁的config.inc.php配置内容：

  ```php
  //<?php
  # 短语密码,cookie认证时不能为空，推荐[a-Z0-9~!@#$%^&*()_+]的随机组合，大于32为佳
  $cfg['blowfish_secret'] = 'fvNqC4^HR8WELJ7$C5UD2a&xk6w@Rfr4M(MBU';
  $i = 0;
  $i++;
  # 设置登陆方式为cookie
  $cfg['Servers'][$i]['auth_type'] = 'cookie';
  $cfg['Servers'][$i]['host'] = 'localhost';
  $cfg['Servers'][$i]['compress'] = false;
  $cfg['Servers'][$i]['AllowNoPassword'] = false;
  $cfg['UploadDir'] = '';
  $cfg['SaveDir'] = '';
  ```

## 提示部分功能未启用的解决方法

> 1. 删除数据库： 将 phpmyadmin 数据库删除
> 2. 登陆phpMyAdmin:首页找到原因那里，进入原因页面
> 3. 创建数据库：进入原因页面后，点击Create会自动创建 phpmyadmin 数据库，这样即可！

## phpMyAdmin 一些注意事项

> - 数据库提供phpmyadmin的高级功能，如果删除，高级功能将无法使用 – 如果未安装或已经删除，可以在找到原因那里，点击Create自动创建
> - phpMyAdmin 连接数据库使用的是php的mysqli扩展，所以php必须安装mysqli扩展包
> - phpMyAdmin cookie登陆方式默认要求账户需要带密码登陆（当然也可以开放空密码登陆），所以我们要为mariadb创建一个带密码的账户

## 结束语

> 到此mariadb的讲解告一段落，mariadb与mysql的配置基本上没有太大区别，都是通用的
