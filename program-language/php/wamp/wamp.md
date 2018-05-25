# ms 下的 php 开发环境

> 这里我们主要讲解手动配置开发环境

> - 安装前需要先安装 `vc11` `vc14` `vc15` 这三个运行库

## 环境介绍

### 系统及安装包官网

- 系统： windows 10 家庭版（64 位）
- [php 官方](http://php.net/)
- [apache 官方](http://httpd.apache.org/)
- [mariadb 官方](https://downloads.mariadb.org/)
- [apache2.4(vc15) 推荐下载地址](http://www.apachelounge.com/download/)

### 安装包列表（64 位）

- `httpd-2.4.33-win64-VC15.zip`
- `mariadb-10.0.35-winx64.zip`
- `mariadb-10.1.33-winx64.zip`
- `mariadb-10.2.15-winx64.zip`
- `php-5.6.36-Win32-VC11-x64.zip`
- `php-7.0.30-Win32-VC14-x64.zip`
- `php-7.1.17-Win32-VC14-x64.zip`
- `php-7.2.5-Win32-VC15-x64.zip`

### 安装包列表（32 位）

- `httpd-2.4.33-Win32-VC15.zip`
- `mariadb-10.0.35-win32.zip`
- `mariadb-10.1.33-win32.zip`
- `mariadb-10.2.15-win32.zip`
- `php-5.6.36-Win32-VC11-x86.zip`
- `php-7.0.30-Win32-VC14-x86.zip`
- `php-7.1.17-Win32-VC14-x86.zip`
- `php-7.2.5-Win32-VC15-x86.zip`

### 安装包解压后的位置

> 将安装包全部解压到 `c:\wamp` 目录

> - 目录结构如下：

```shell
c:/wamp                         wamp部署目录（或者子目录）
├─32                            32位安装包
│  ├─apache24                   Web服务器
│  │  ├─bin                     阿帕奇可执行程序目录
│  │  ├─conf                    配置
│  │  │  ├─httpd.conf           阿帕奇主配置文件
│  │  │  └─ ...
│  │  └─ ...
│  │
│  ├─mariadb102                 mariadb 10.2版本
│  │  ├─bin                     mariadb可执行程序目录
│  │  └─ ...
│  │
│  ├─mariadb101                 mariadb 10.1版本
│  │  ├─bin                     mariadb可执行程序目录
│  │  └─ ...
│  │
│  ├─mariadb100                 mariadb 10.0版本
│  │  ├─bin                     mariadb可执行程序目录
│  │  └─ ...
│  │
│  ├─php72                      php 7.2版本
│  │  ├─ext                     模块目录
│  │  ├─php.ini                 php主配置文件
│  │  └─ ...
│  │
│  ├─php71                      php 7.1版本
│  │  ├─ext                     模块目录
│  │  ├─php.ini                 php主配置文件
│  │  └─ ...
│  │
│  ├─php70                      php 7.0版本
│  │  ├─ext                     模块目录
│  │  ├─php.ini                 php主配置文件
│  │  └─ ...
│  │
│  └─php56                      php 5.6版本
│  │  ├─ext                     模块目录
│  │  ├─php.ini                 php主配置文件
│  │  └─ ...
│  │
│
├─64                            64位安装包
│  ├─apache24                   Web服务器
│  │  ├─bin                     阿帕奇可执行程序目录
│  │  ├─conf                    配置
│  │  │  ├─httpd.conf           阿帕奇主配置文件
│  │  │  └─ ...
│  │  └─ ...
│  │
│  ├─mariadb102                 mariadb 10.2版本
│  │  ├─bin                     mariadb可执行程序目录
│  │  └─ ...
│  │
│  ├─mariadb101                 mariadb 10.1版本
│  │  ├─bin                     mariadb可执行程序目录
│  │  └─ ...
│  │
│  ├─mariadb100                 mariadb 10.0版本
│  │  ├─bin                     mariadb可执行程序目录
│  │  └─ ...
│  │
│  ├─php72                      php 7.2版本
│  │  ├─ext                     模块目录
│  │  ├─php.ini                 php主配置文件
│  │  └─ ...
│  │
│  ├─php71                      php 7.1版本
│  │  ├─ext                     模块目录
│  │  ├─php.ini                 php主配置文件
│  │  └─ ...
│  │
│  ├─php70                      php 7.0版本
│  │  ├─ext                     模块目录
│  │  ├─php.ini                 php主配置文件
│  │  └─ ...
│  │
│  └─php56                      php 5.6版本
│  │  ├─ext                     模块目录
│  │  ├─php.ini                 php主配置文件
│  │  └─ ...
│  │
│
├─sites                         站点配置文件
│
├─www                           Web根目录
│
└─data                          mariadb数据库存放目录
```

## 配置 apache2 并绑定 php

### 配置 httpd.conf 文件

> httpd.conf 是 apache2 的主配置文件，开发模式下我们需要配置的内容如下：

> - 注意： apache2 下只有正斜杆 `/` 没有反斜杠 `\` （路径都要替换成正斜杆的方式）

#### 为 apache2 配置正确的路径

> 默认情况下 apache2 路径是 `c:/Apache2.4` ，需要修改成 apache2 当前所在路径

```shell
# 32位
  将 httpd.conf 文件下所有 `c:/Apache24` 替换成 `c:/wamp/32/apache24`
  # 64位
  将 httpd.conf 文件下所有 `c:/Apache24` 替换成 `c:/wamp/64/apache24`
```

#### 为 apache2 增加配置文件

> 使用 Include 可以在配置文件中加入其它配置文件

> - 在 httpd.conf 底部增加两行 Include 指令
> - 注意：32位和64位有一个文件是不同的

```conf
# 64位
   Include "c:/wamp/sites/httpd.ini"
   Include "c:/wamp/sites/httpd64.ini"

   #32位
   Include "c:/wamp/sites/httpd.ini"
   Include "c:/wamp/sites/httpd32.ini"
```

#### 为 apache2 绑定 php

> 操作2个自定义配置文件： `httpd32.ini` `httpd64.ini`

```ini
# 32位, 也就是 httpd32.ini 文件增加如下内容：
  LoadModule php7_module c:/wamp/32/php72/php7apache2_4.dll
  ##LoadModule php7_module c:/wamp/32/php71/php7apache2_4.dll
  ##LoadModule php7_module c:/wamp/32/php72/php7apache2_4.dll
  ##LoadModule php5_module c:/wamp/32/php56/php5apache2_4.dll
  <IfModule php7_module>
  PHPINIDir "c:/wamp/32/php72"
  ##PHPINIDir "c:/wamp/32/php71"
  ##PHPINIDir "c:/wamp/32/php70"
  </IfModule>
  <IfModule php5_module>
  PHPINIDir "c:/wamp/32/php56"
  </IfModule>
```

```ini
# 64位, 也就是 httpd64.ini 文件增加如下内容：
  LoadModule php7_module c:/wamp/64/php72/php7apache2_4.dll
  ##LoadModule php7_module c:/wamp/64/php71/php7apache2_4.dll
  ##LoadModule php7_module c:/wamp/64/php72/php7apache2_4.dll
  ##LoadModule php5_module c:/wamp/64/php56/php5apache2_4.dll
  <IfModule php7_module>
  PHPINIDir "c:/wamp/64/php72"
  ##PHPINIDir "c:/wamp/64/php71"
  ##PHPINIDir "c:/wamp/64/php70"
  </IfModule>
  <IfModule php5_module>
  PHPINIDir "c:/wamp/64/php56"
  </IfModule>
```

> 也可以去掉 IfModule，具体如下：

```ini
# 64位, 也就是 httpd64.ini 文件增加如下内容：
  LoadModule php7_module c:/wamp/64/php72/php7apache2_4.dll
  PHPINIDir "c:/wamp/64/php72"

  ##LoadModule php7_module c:/wamp/64/php71/php7apache2_4.dll
  ##PHPINIDir "c:/wamp/64/php71"

  ##LoadModule php7_module c:/wamp/64/php72/php7apache2_4.dll
  ##PHPINIDir "c:/wamp/64/php70"

  ##LoadModule php5_module c:/wamp/64/php56/php5apache2_4.dll
  ##PHPINIDir "c:/wamp/64/php56"
```

```ini
# 32位, 也就是 httpd32.ini 文件增加如下内容：
  LoadModule php7_module c:/wamp/32/php72/php7apache2_4.dll
  PHPINIDir "c:/wamp/32/php72"

  ##LoadModule php7_module c:/wamp/32/php71/php7apache2_4.dll
  ##PHPINIDir "c:/wamp/32/php71"

  ##LoadModule php7_module c:/wamp/32/php72/php7apache2_4.dll
  ##PHPINIDir "c:/wamp/32/php70"

  ##LoadModule php5_module c:/wamp/32/php56/php5apache2_4.dll
  ##PHPINIDir "c:/wamp/32/php56"
```

> 只有正确配置 `PHPINIDir` ，才能成功加载 php.ini 配置文件

> - 提示： `httpd32.ini` `httpd64.ini` 这两个文件只是为 apache2 绑定了 php

#### 配置 httpd.ini 这个自定义配置文件

> 该文件为阿帕奇做了几件事情：

> - 开启虚拟主机
> - 开启伪静态
> - 将 .php 文件自动解析为 PHP 脚本
> - 新增一个Web目录
> - 为站点指定默认文件
> - 让 .htaccess 文件支持伪静态

```ini文件
# 下面是 httpd.ini 配置文件的所有内容
LoadModule vhost_alias_module modules/mod_vhost_alias.so
#LoadModule ssl_module modules/mod_ssl.so
LoadModule rewrite_module modules/mod_rewrite.so

AddType application/x-httpd-php .php

<Directory "c:/wamp/www">
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
    DirectoryIndex index.html index.php
</Directory>

Include "c:/wamp/sites/*.conf"
```

1. 为阿帕奇开启虚拟主机模块

  > httpd.ini 文件新增一行

  ```ini
  LoadModule vhost_alias_module modules/mod_vhost_alias.so
  ```

2. 为阿帕奇开启伪静态模块

  > httpd.ini 文件新增一行

  ```ini
  LoadModule rewrite_module modules/mod_rewrite.so
  ```

3. 将 .php 文件自动解析为 PHP 脚本

  > httpd.ini 文件新增一行

  ```ini
  AddType application/x-httpd-php .php
  ```

  > 当然阿帕奇也支持多类型的文件，自动解析为 PHP 脚本

  ```conf
  AddType application/x-httpd-php .php .emad
  ```

4. 新增一个Web目录

  > httpd.ini 文件新增以下内容

  ```ini
  <Directory "c:/wamp/www">
      Options Indexes FollowSymLinks
      AllowOverride None
      Require all granted
  </Directory>
  ```

5. 为站点指定默认文件

  > 在 `<Directory "c:/wamp/www">` 内将 `AllowOverride None` 替换成 `AllowOverride All`

  ```ini
  <Directory "c:/wamp/www">
      Options Indexes FollowSymLinks
      AllowOverride All
      Require all granted
  </Directory>
  ```

6. 让 .htaccess 文件支持伪静态

  > 在 `<Directory "c:/wamp/www">` 内新增一行，该目录下的所有站点都支持 .htaccess 文件伪静态

  > - 新增内容： `DirectoryIndex index.html index.php`

  ```ini
  <Directory "c:/wamp/www">
      Options Indexes FollowSymLinks
      AllowOverride All
      Require all granted
      DirectoryIndex index.html index.php
  </Directory>
  ```

#### 创建虚拟主机

> sites 目录下面新建 1 个 conf格式文件，配置虚拟主机 提示：一个虚拟主机可以配置多个站点

```conf
# vhost.conf 文件内容

<VirtualHost *:80>
    DocumentRoot "c:/wamp/www"
    ServerName localhost
</VirtualHost>

<VirtualHost *:80>
    DocumentRoot "c:/wamp/www/tp5/public"
    ServerName www.tp5.com
    ServerAlias www.tp5.com tp5.com
    ErrorDocument 404 /404.html

    ErrorLog "logs/tp5-error.log"
    CustomLog "logs/tp5-access.log" common

    RewriteEngine on
    RewriteCond %{HTTP_HOST} ^tp5.com$ [NC]
    RewriteRule ^(.*)$ http://www.%{HTTP_HOST}$1 [R=301,L]
</VirtualHost>
```

> 将虚拟主机指定的域名加入到 `hosts` 文件下

```hosts
# 文件路径 c:\Windows\System32\drivers\etc\hosts
# 底部新增一行
127.0.0.1 www.tp5.com tp5.com
```

### 将 apache2 写入系统服务中

> 将 apache2 的 bin 目录加入到系统变量 PATH 中

> - 使用下面指令将 apache2 加入到系统服务中（需要管理员权限的 cmd）
> - 只能选择一个版本的 apache2 加入到系统变量
> - 注意：如果想要同时安装多个阿帕奇到系统服务，建议不要加入到系统变量，进入阿帕奇 bin 目录后再操作
> - 提示：阿帕奇默认使用80和443端口，不改变端口设置系统只能开启一个阿帕奇，如果想同时开启多个阿帕奇，需要为不同版本的阿帕奇设置不同的端口

```shell
# 64位
httpd.exe -k install -n apache2
# 32位
httpd.exe -k install -n httpd
```

> 使用下面的指令可以将 apache2 从系统服务中卸载（需要管理员权限的 cmd）

> - 卸载后需要重启资源你管理器或重启系统才能彻底删除干净

```shell
# 64位
httpd.exe -k uninstall -n apache2
# 32位
httpd.exe -k uninstall -n httpd
```

> 启动 apache2 服务器（需要管理员权限的 cmd）

```shell
# 64位
net start apache2
# 32位
net start httpd
```

> 关闭 apache2 服务器（需要管理员权限的 cmd）

```shell
# 64位
net stop apache2
# 32位
net stop httpd
```

> apache2 服务损坏后，如何彻底删除？

```shell
# 系统服务损坏后，管理员cmd下使用 `sc delete 服务名` 指令来删除
# 32位
sc delete httpd
# 64位
sc delete apache2
```

### 将阿帕奇服务设置为开机启动

> - 和其它系统服务一样，进入 `系统服务` 控制面板中：
> - 右键 > 属性 > 启动类型（选择自动）
> - 提示： windows 10 系统默认就是开机启动的，如果我们改变端口号，就只能让其中一个版本的阿帕奇开机启动

> 到此 apache2 配置结束，后期需要自行修改配置

## 配置 php

### 配置前的准备

1. 拷贝 `php.ini-development` 文件，并重命名为 `php.ini`

2. 将对应版本的 php_xdebug 扩展文件复制到 ext 目录下，并重命名为 `php_xdebug.dll`

### 开发者模式下 php 需要开启 php_xdebug 扩展

> 在 `php.ini` 底部增加如下内容：

```ini
# 64位 php7.2
[XDebug]
zend_extension="c:\wamp\64\php72\ext\php_xdebug.dll"

# 64位 php7.1
[XDebug]
zend_extension="c:\wamp\64\php71\ext\php_xdebug.dll"

# 64位 php7.0
[XDebug]
zend_extension="c:\wamp\64\php70\ext\php_xdebug.dll"

# 64位 php5.6
[XDebug]
zend_extension="c:\wamp\64\php56\ext\php_xdebug.dll"

# 32位 php7.2
[XDebug]
zend_extension="c:\wamp\32\php72\ext\php_xdebug.dll"

# 32位 php7.1
[XDebug]
zend_extension="c:\wamp\32\php71\ext\php_xdebug.dll"

# 32位 php7.0
[XDebug]
zend_extension="c:\wamp\32\php70\ext\php_xdebug.dll"

# 32位 php5.6
[XDebug]
zend_extension="c:\wamp\32\php56\ext\php_xdebug.dll"
```

### 开启常用扩展

> 默认请下 php 的扩展都是没有开启的，我们需要这些扩展的注释去掉

> - 下面以 `thinkphp 5.1` 为例我们需要开启 `mbstring` 和 `pdo_mysql`
> - 具体项目中我们用到什么开启什么

1. 首先要指定扩展所在目录

  > php.ini 第 735 行下面新增一行

  ```ini
  extension_dir = "ext"
  ```

  > 当然，也可以指定绝对路径

  ```ini
  extension_dir = "c:/wamp/位数目录名/php目录名/ext"
  ```

2. 接下来就是开启扩展

  ```ini
  # php 7.2 将以下 2 行注释去掉

  extension=mbstring

  extension=pdo_mysql
  ```

  ```ini
  # php 7.1 7.0 5.6 将以下 2 行注释去掉

  extension=php_mbstring.dll

  extension=php_pdo_mysql.dll
  ```

### 开启错误提示

> 在 php.ini 中找到 display_errors , 设置错误提示的开启和关闭（off关，on开），同时设置 error_reporting 的值代表错误的级别

```ini
# php.ini 第99 行下新增
display_errors = On
# php.ini 第 110 行下新增
error_reporting = E_ALL
```

> 到此 php 配置基本结束，以后需要再自行修改配置

## 配置 mariadb

> - 著配置文件 `my.ini`

1. 创建 my.ini

  > 默认情况下mariadb并没有my.ini文件，不过在根目录下面有几个参考文件：

  > - `my-huge.ini` `my-innodb-heavy-4G.ini` `my-large.ini` `my-medium.ini` `my-small.ini`
  > - 这里我们自行配置，因为有几个功能需要正确指定路径才能生效（不配置，只是部分功能受到限制）

  ```ini
  # 在 mariadb 根目录下面新建 my.ini
  [client]
  ##port = 3306

  [mysqld]
  ##port = 3306
  datadir = "c:/wamp/data"
  ##innodb_data_home_dir = ""
  ##innodb_data_file_path = ibdata1:10M:autoextend
  ##innodb_log_group_home_dir = ""
  ```

  > 注意：切换版本前需要将data目录下的非目录文件删除掉，并初始化

2. 初始化 mariadb 的 data 目录

  > 初始化前需要将data目录内容复制到指定位置，然后输入下面的指令

  ```shell
  mysqld --initialize
  ```

  > 提示： 各版本的data目录数据可以共用，这并不影响(切换版本是否需要初始化？)

  > - 同版本，不同位数间可以相互切换
  > - 不同版本，低版本切换到高版本允许，高版本切换到低版本就会报错

3. 将 mariadb 安装到系统服务

  > 打开cmd（有管理员权限），进入到mariadb的bin目录下,指令如下：

  ```shell
  # 64位 mariadb 10.2
  mysqld install mysql102
  # 64位 mariadb 10.1
  mysqld install mysql101
  # 64位 mariadb 10.0
  mysqld install mysql100

  # 32位 mariadb 10.2
  mysqld install mariadb102
  # 32位 mariadb 10.1
  mysqld install mariadb101
  # 32位 mariadb 10.0
  mysqld install mariadb100
  ```

  > 卸载系统服务，操作和安装类似，只是指令略有不同：

  ```shell
  # 64位 mariadb 10.2
  mysqld remove mysql102
  # 64位 mariadb 10.1
  mysqld remove mysql101
  # 64位 mariadb 10.0
  mysqld remove mysql100

  # 32位 mariadb 10.2
  mysqld remove mariadb102
  # 32位 mariadb 10.1
  mysqld remove mariadb101
  # 32位 mariadb 10.0
  mysqld remove mariadb100
  ```

  > 系统服务损坏如何删除？打开管理员权限的cmd（不需要指定路径），指令如下：

  ```shell
  # 64位 mariadb 10.2
  sc delete mysql102
  # 64位 mariadb 10.1
  sc delete mysql101
  # 64位 mariadb 10.0
  sc delete mysql100

  # 32位 mariadb 10.2
  sc delete mariadb102
  # 32位 mariadb 10.1
  sc delete mariadb101
  # 32位 mariadb 10.0
  sc delete mariadb100
  ```

> 到此 mariadb 告一段落！

## 附录一：指令集中营
