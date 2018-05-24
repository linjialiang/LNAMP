# ms 下的 php 开发环境

> 这里我们主要讲解手动配置开发环境

## 环境介绍

### 系统及安装包官网

-   系统： windows 10 家庭版（64位）
-   [php 官方](http://php.net/)
-   [apache 官方](http://httpd.apache.org/)
-   [mariadb 官方](https://downloads.mariadb.org/)
-   [apache2.4(vc15) 推荐下载地址](http://www.apachelounge.com/download/)

### 重要安装包列表

-   `httpd-2.4.33-win64-VC15.zip`
-   `mariadb-10.2.15-winx64.zip`
-   `php-5.6.36-Win32-VC11-x64.zip`
-   `php-7.0.30-Win32-VC14-x64.zip`
-   `php-7.1.17-Win32-VC14-x64.zip`
-   `php-7.2.5-Win32-VC15-x64.zip`

### 安装包解压后的位置

> -   我将安装包全部解压到了 `c:/wamp` 目录，子目录如下：

-   `apache2.4`
-   `mariadb10.2`
-   `php5.6`
-   `php7.0`
-   `php7.1`
-   `php7.2`

## 配置 apache2 并绑定 php

### 配置文件路径说明

1.  apache2 主配置文件

    > 路径： `C:\wamp\apache2.4\conf\httpd.conf`

2.  apache2 虚拟主机配置文件

    > 路径： `C:\wamp\apache2.4\conf\extra\httpd-vhosts.conf`
    >
    > -   注意：需要在 httpd.conf 下开启相关配置

3.  php 主配置文件

    > -   php7.2 路径： `C:/wamp/php7.2/php.ini`
    > -   php7.1 路径： `C:/wamp/php7.1/php.ini`
    > -   php7.0 路径： `C:/wamp/php7.0/php.ini`
    > -   php5.6 路径： `C:/wamp/php5.6/php.ini`
    > -   注意：开发环境下拷贝 `php.ini-development` 为 \`php.ini
    > -   注意：生产环境下拷贝 `php.ini-production` 为 `php.ini`

4.  apache2 绑定 php 的模块所在位置

    > -   apache2 绑定 php7.2 ： `C:/wamp/php7.2/php7apache2_4.dll`
    > -   apache2 绑定 php7.1 ： `C:/wamp/php7.1/php7apache2_4.dll`
    > -   apache2 绑定 php7.0 ： `C:/wamp/php7.0/php7apache2_4.dll`
    > -   apache2 绑定 php5.6 ： `C:/wamp/php5.6/php5apache2_4.dll`
    > -   注意：只能一个版本生效，其他应该处于备注状态

5.  php 正常模块的默认路径
    > -   php7.2 正常模块路径： `C:/wamp/php7.2/ext` 下
    > -   php7.1 正常模块路径： `C:/wamp/php7.1/ext` 下
    > -   php7.0 正常模块路径： `C:/wamp/php7.0/ext` 下
    > -   php5.6 正常模块路径： `C:/wamp/php5.6/ext` 下

### 配置 httpd.conf 文件

> httpd.conf 是 apache2 的主配置文件，开发模式下我们需要配置的内容如下：
>
> -   注意： apache2 下只有正斜杆 `/` 没有反斜杠 `\` （路径都要替换成正斜杆的方式）

1.  为 apache2 配置正确的路径

    > 默认情况下 apache2 路径是 `c:/Apache2.4` ，需要修改成 apache2 当前所在路径

    ```shell
    将 httpd.conf 文件下所有 `c:/Apache24` 替换成 `c:/wamp/apache2.4`
    ```

2.  为 apache2 配置当前服务器根目录

    > apache2 只允许浏览器对指定的目录进行访问和操作，所以我们要对 apache2 指定 web 根目录

    ```shell
    将 248-249 行的内容替换掉
    ```

    > 替换前（本来应该是 c:/Apache24/htdocs）

    ```conf
    DocumentRoot "c:/wamp/apache2.4/htdocs"
    <Directory "c:/wamp/apache2.4/htdocs">
    ```

    > 替换后

    ```conf
    DocumentRoot "c:/www"
    <Directory "c:/www">
    ```

3.  为 apache2 开启虚拟主机，并配置虚拟主机

    > apache2 实现虚拟主机需要 3 步操作：
    >
    > 1.  开启 `vhost_alias_module` 模块
    > 2.  为 apache2 虚拟主机指定配置文件或配置文件所在目录（开发模式使用默认配置文件即可）
    > 3.  修改虚拟主机配置文件

    ```conf
    # 将 httpd.conf 第 180 行注释去掉

    # 修改前
    # LoadModule vhost_alias_module modules/mod_vhost_alias.so

    # 修改后
    LoadModule vhost_alias_module modules/mod_vhost_alias.so
    ```

    > 将 httpd.conf 第 513 行注释去掉

    ```conf
    # 修改前
    # Include conf/extra/httpd-vhosts.conf

    # 修改后
    Include conf/extra/httpd-vhosts.conf
    ```

    > 编辑 `httpd-vhosts.conf` ，配置虚拟主机

    ```conf
    <VirtualHost *:80>
        DocumentRoot "c:/www/tp5/public"
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

4.  apache2 开启将 .php 文件自动解析为 PHP 脚本
    > 第 424 行新增一行 AddType 内容

    ```conf
    # 新增内容
    AddType application/x-httpd-php .php
    ```

    > 当然 apache2 也支持多类型的文件，自动解析为PHP脚本

    ```conf
    AddType application/x-httpd-php .php .emad
    ```

5.  为 apache2 指定默认文件
    > 默认情况下只指定了 index.html 文件，我们可以根据自己的需要进行增加默认文件
    >
    > -   在同一目录下存在多个指定默认文件，会按顺序靠前的文件打开

    ```conf
    # 在 httpd.conf 第 286-288 行内容修改前
    <IfModule dir_module>
        DirectoryIndex index.html
    </IfModule>

    # 在 httpd.conf 第 286-288 行内容修改后
    <IfModule dir_module>
        DirectoryIndex index.html index.php
    </IfModule>
    ```

6.  为 apache2 绑定 php

    > ms 系统下的 php 安装包里面自带绑定 apache2 扩展

    ```conf
    # 在 httpd.conf 第 182 行下面新增下面四行：

    LoadModule php7_module C:/wamp/php7.2/php7apache2_4.dll
    ## LoadModule php7_module C:/wamp/php7.1/php7apache2_4.dll
    ## LoadModule php7_module C:/wamp/php7.0/php7apache2_4.dll
    ## LoadModule php5_module C:/wamp/php5.6/php5apache2_4.dll
    ```

7. 让 `.htaccess` 文件支持伪静态

    > 首先 apache2 开启伪静态扩展，来支持伪静态

    ```conf
    # 在 httpd.conf 第 160 行，注释去掉

    # 修改前
    # LoadModule rewrite_module modules/mod_rewrite.so
    #
    # 修改后
    LoadModule rewrite_module modules/mod_rewrite.so
    ```

    > 接下来对指定的web根目录进行配置
    > - 在 `<Directory "c:/www">` 内部修改，位置如下

    ```conf
    # 修改前
    DocumentRoot "c:/www"
    <Directory "c:/www">
    #...
    AllowOverride None
    #...
    </Directory>
    ```

    ```conf
    # 修改后
    DocumentRoot "c:/www"
    <Directory "c:/www">
    #...
    AllowOverride All
    #...
    </Directory>
    ```

### 将 apache2 写入系统服务中
> 将 apache2 的 bin 目录加入到系统变量 PATH 中
> - 使用下面指令将 apache2 加入到系统服务中（需要管理员权限的cmd）

```shell
httpd.exe -k install -n apache2
```

> 使用下面的指令可以将 apache2 从系统服务中卸载（需要管理员权限的cmd）
> - 卸载后需要重启资源你管理器或重启系统才能彻底删除干净

```shell
httpd.exe -k uninstall -n apache2
```

> 启动 apache2 服务器

```shell
net start apache2
```

> 关闭 apache2 服务器

```shell
net stop apache2
```

> 到此 apache2 配置结束，后期需要自行修改配置

## 配置 php

### 配置前的准备

1. 拷贝 `php.ini-development` 文件，并重命名为 `php.ini`

2. 将对应版本的 php_xdebug 扩展文件复制到 ext 目录下，并重命名为 `php_xdebug.dll`

### 开发者模式下 php 需要开启 php_xdebug 扩展
> 在 `php.ini` 底部增加如下内容：

```ini
# php 7.2
[XDebug]
zend_extension="c:\wamp\php7.2\ext\php_xdebug.dll"
```

```ini
# php 7.1
[XDebug]
zend_extension="c:\wamp\php7.1\ext\php_xdebug.dll"
```

```ini
# php 7.0
[XDebug]
zend_extension="c:\wamp\php7.0\ext\php_xdebug.dll"
```

```ini
# php 5.6
[XDebug]
zend_extension="c:\wamp\php5.6\ext\php_xdebug.dll"
```

### 开启常用扩展
> 默认请下 php 的扩展都是没有开启的，我们需要这些扩展的注释去掉
> - 下面以 `thinkphp 5.1` 为例我们需要开启 `mbstring` 和 `pdo_mysql`
> - 具体项目中我们用到什么开启什么

```ini
# php 7.2 将以下 2 行注释去掉

extension=mbstring

extension=pdo_mysql
```

```ini
# php 7.1 7.0 5.6 将以下 2 行注释去掉

extension=mbstring

extension=php_pdo_mysql.dll
```

### 开启错误提示
> 在 php.ini 中找到 display_errors , 设置错误提示的开启和关闭（off时关，on时开）
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
