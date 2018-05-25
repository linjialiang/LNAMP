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

> 将安装包全部解压到 `d:\wamp` 目录

> - 目录结构如下：

```shell
c:/wamp                         wamp部署目录（或者子目录）
├─32                            32位安装包
│  ├─apache24                   Web服务器
│  │  ├─bin                     阿帕奇可执行程序目录
│  │  ├─conf                    配置
│  │  │  ├─httpd.conf           阿帕奇主配置文件
│  │  │  └─ ...
│  │  │
│  │  └─ ...
│  │
│  ├─mariadb102                 mariadb 10.2版本
│  │  ├─bin                     mariadb可执行程序目录
│  │  ├─data                    数据存放目录
│  │  │  ├─
│  │  │  └─ ...
│  │  │
│  │  └─ ...
│  │
│  ├─mariadb101                 mariadb 10.1版本
│  │  ├─bin                     mariadb可执行程序目录
│  │  ├─data                    数据存放目录
│  │  │  ├─
│  │  │  └─ ...
│  │  │
│  │  └─ ...
│  │
│  ├─mariadb100                 mariadb 10.0版本
│  │  ├─bin                     mariadb可执行程序目录
│  │  ├─data                    数据存放目录
│  │  │  ├─
│  │  │  └─ ...
│  │  │
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
│  │  │
│  │  └─ ...
│  │
│  ├─mariadb102                 mariadb 10.2版本
│  │  ├─bin                     mariadb可执行程序目录
│  │  ├─data                    数据存放目录
│  │  │  ├─
│  │  │  └─ ...
│  │  │
│  │  └─ ...
│  │
│  ├─mariadb101                 mariadb 10.1版本
│  │  ├─bin                     mariadb可执行程序目录
│  │  ├─data                    数据存放目录
│  │  │  ├─
│  │  │  └─ ...
│  │  │
│  │  └─ ...
│  │
│  ├─mariadb100                 mariadb 10.0版本
│  │  ├─bin                     mariadb可执行程序目录
│  │  ├─data                    数据存放目录
│  │  │  ├─
│  │  │  └─ ...
│  │  │
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
└─phpMyAdmin                    基于Web的MariaDB管理工具

```

## 配置 apache2 并绑定 php

### 配置 httpd.conf 文件

> httpd.conf 是 apache2 的主配置文件，开发模式下我们需要配置的内容如下：

> - 注意： apache2 下只有正斜杆 `/` 没有反斜杠 `\` （路径都要替换成正斜杆的方式）

1. 为 apache2 配置正确的路径

  > 默认情况下 apache2 路径是 `c:/Apache2.4` ，需要修改成 apache2 当前所在路径

  ```shell
  # 32位
  将 httpd.conf 文件下所有 `c:/Apache24` 替换成 `d:/wamp/32/apache24`
  # 64位
  将 httpd.conf 文件下所有 `c:/Apache24` 替换成 `d:/wamp/64/apache24`
  ```

2. 为 apache2 配置当前服务器根目录

  > apache2 只允许浏览器对指定的目录进行访问和操作，所以我们要对 apache2 指定 web 根目录

  > - 将 httpd.conf 文件, 第 248-249 行的内容替换掉

  ```conf
  DocumentRoot "d:/wamp/www"
  <Directory "d:/wamp/www">
  ```

3. 为 apache2 开启虚拟主机，并配置虚拟主机

  > apache2 实现虚拟主机需要 3 步操作：

  > 1. 开启 `vhost_alias_module` 模块
  > 2. 为 apache2 虚拟主机指定配置文件或配置文件所在目录
  > 3. 修改虚拟主机配置文件

  ```conf
  # 将 httpd.conf 文件 第 180 行注释去掉
  LoadModule vhost_alias_module modules/mod_vhost_alias.so
  ```

  ```conf
  # 将 httpd.conf 第 513 行下面增加一行内容
  Include "d:/wamp/sites/*.conf"
  ```

  > sites 目录下面新建 1 个 conf格式文件，配置虚拟主机

  ```conf
  # vhost.conf 文件内容
  <VirtualHost *:80>
  DocumentRoot "d:/wamp/www/tp5/public"
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

4. apache2 开启将 .php 文件自动解析为 PHP 脚本

  > 第 419 行下面新增一行 AddType 内容

  ```conf
  # 新增内容
  AddType application/x-httpd-php .php
  ```

  > 当然 apache2 也支持多类型的文件，自动解析为 PHP 脚本

  ```conf
  AddType application/x-httpd-php .php .emad
  ```

5. 为 apache2 指定默认文件

  > 默认情况下只指定了 index.html 文件，我们可以根据自己的需要进行增加默认文件

  > - 在同一目录下存在多个指定默认文件，会按顺序靠前的文件打开

  ```conf
  # 修改 httpd.conf 文件第 281-283 行内容
  <IfModule dir_module>
  DirectoryIndex index.html index.php
  </IfModule>
  ```

6. 为 apache2 绑定 php

  > php 安装包里面自带绑定 apache2 扩展

  > - 在 httpd.conf 第 182 行下面新增下面四行：

  ```conf
  # 32位
  LoadModule php7_module d:/wamp/32/php72/php7apache2_4.dll
  ##LoadModule php7_module d:/wamp/32/php71/php7apache2_4.dll
  ##LoadModule php7_module d:/wamp/32/php72/php7apache2_4.dll
  ##LoadModule php5_module d:/wamp/32/php56/php5apache2_4.dll
  ```

  ```conf
  # 64位
  LoadModule php7_module d:/wamp/64/php72/php7apache2_4.dll
  ##LoadModule php7_module d:/wamp/64/php71/php7apache2_4.dll
  ##LoadModule php7_module d:/wamp/64/php72/php7apache2_4.dll
  ##LoadModule php5_module d:/wamp/64/php56/php5apache2_4.dll
  ```

7. 让 `.htaccess` 文件支持伪静态

  > 首先 apache2 开启伪静态扩展，来支持伪静态

  ```conf
  # 在 httpd.conf 文件第 160 行，去掉注释
  LoadModule rewrite_module modules/mod_rewrite.so
  ```

  > 接下来配置指定的 web 根目录, 在 `<Directory "d:/wamp/www">` 内部修改：

  ```conf
  # 将 AllowOverride None 修改为 AllowOverride All
  <Directory "d:/wamp/www">
  ...
  AllowOverride All
  ...
  </Directory>
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
[XDebug]
zend_extension="d:\wamp\对应位数目录名\对应php版本目录名\ext\php_xdebug.dll"
```

### 开启常用扩展

> 默认请下 php 的扩展都是没有开启的，我们需要这些扩展的注释去掉

> - 下面以 `thinkphp 5.1` 为例我们需要开启 `mbstring` 和 `pdo_mysql`
> - 具体项目中我们用到什么开启什么

1. 首先要指定扩展所在目录

  > php.ini 第 735 行下面新增一行

  ````
  ```ini
  extension_dir = "ext"
  ```

  > 也可以指定绝对路径

  ```ini
  extension_dir = "d:/server/wamp/php7.2/ext"
  ```
  ````

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

> 在 php.ini 中找到 display_errors , 设置错误提示的开启和关闭（off 时关，on 时开）

> - 同时设置 error_reporting 的值代表错误的级别

```ini
# php.ini 第99 行下新增
display_errors = On
```

```ini
# php.ini 第 110 行下新增
error_reporting = E_ALL
```

> 到此 php 配置基本结束，以后需要再自行修改配置
