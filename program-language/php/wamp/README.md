# ms 下的 php 开发环境

> 这里我们主要讲解手动配置开发环境
>
> -   安装前需要先安装 `vc11` `vc14` `vc15` 这三个运行库

## 环境介绍

### 系统及安装包官网

-   系统： windows 10 家庭版（64 位）
-   [php 官方](http://php.net/)
-   [apache 官方](http://httpd.apache.org/)
-   [mariadb 官方](https://downloads.mariadb.org/)
-   [phpMyAdmin 官方](https://www.phpmyadmin.net/)
-   [apache2.4(vc15) 推荐下载地址](http://www.apachelounge.com/download/)

### 安装包列表（64 位）

-   `httpd-2.4.33-win64-VC15.zip`
-   `mariadb-10.0.35-winx64.zip`
-   `mariadb-10.1.33-winx64.zip`
-   `mariadb-10.2.15-winx64.zip`
-   `php-5.6.36-Win32-VC11-x64.zip`
-   `php-7.0.30-Win32-VC14-x64.zip`
-   `php-7.1.17-Win32-VC14-x64.zip`
-   `php-7.2.5-Win32-VC15-x64.zip`

### 安装包列表（32 位）

-   `httpd-2.4.33-Win32-VC15.zip`
-   `mariadb-10.0.35-win32.zip`
-   `mariadb-10.1.33-win32.zip`
-   `mariadb-10.2.15-win32.zip`
-   `php-5.6.36-Win32-VC11-x86.zip`
-   `php-7.0.30-Win32-VC14-x86.zip`
-   `php-7.1.17-Win32-VC14-x86.zip`
-   `php-7.2.5-Win32-VC15-x86.zip`

### 安装包解压后的位置

> 将安装包全部解压到 `c:\wamp` 目录
>
> -   目录结构如下：

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
├─data                          mariadb数据库存放目录
│
└─phpMyAdmin                    phpMyAdmin基于Web的数据库管理平台
```

## 配置 apache2 并绑定 php

### 配置 httpd.conf 文件

> httpd.conf 是 apache2 的主配置文件，开发模式下我们需要配置的内容如下：
>
> -   注意： apache2 下只有正斜杆 `/` 没有反斜杠 `\` （路径都要替换成正斜杆的方式）

#### 为 apache2 配置正确的路径

> 默认情况下 apache2 路径是 `c:/Apache2.4` ，需要修改成 apache2 当前所在路径

```shell
# 32位
将 httpd.conf 文件下所有 `c:/Apache24` 替换成 `c:/wamp/32/apache24`
# 64位
将 httpd.conf 文件下所有 `c:/Apache24` 替换成 `c:/wamp/64/apache24`
```

#### 为 apache2 增加配置文件

> -   说明：阿帕奇可以在 httpd.conf 内使用 Include 加入其它配置文件
> -   操作：在 httpd.conf 底部增加两行 Include 指令
> -   注意：32位和64位有一个文件是不同的

| digit | public                              | diff                                  |
| ----- | ----------------------------------- | ------------------------------------- |
| 32    | `Include "c:/wamp/sites/httpd.ini"` | `Include "c:/wamp/sites/httpd32.ini"` |
| 64    | `Include "c:/wamp/sites/httpd.ini"` | `Include "c:/wamp/sites/httpd64.ini"` |

#### 为 apache2 绑定 php

> 操作2个自定义配置文件： `httpd32.ini` `httpd64.ini`
>
> -   `module-name`：apache2.4绑定php的模块名
> -   `module-path`：apache2.4绑定php5的模块路径（绝对路径）
> -   `phpinidir-path`：php.ini配置文件的路径（绝对路径）

```ini
LoadModule <module-name> <module-path>
PHPINIDir <phpinidir-path>
```

> 属性一览表

| php    | digit | `module-name` | module-path                          | `phpinidir-path`   |
| ------ | ----- | ------------- | ------------------------------------ | ------------------ |
| php7.2 | 64    | php7_module   | `c:/wamp/64/php72/php7apache2_4.dll` | `c:/wamp/64/php72` |
| php7.1 | 64    | php7_module   | `c:/wamp/64/php72/php7apache2_4.dll` | `c:/wamp/64/php71` |
| php7.0 | 64    | php7_module   | `c:/wamp/64/php70/php7apache2_4.dll` | `c:/wamp/64/php70` |
| php5.6 | 64    | php5_module   | `c:/wamp/64/php56/php5apache2_4.dll` | `c:/wamp/64/php56` |
| php7.2 | 32    | php7_module   | `c:/wamp/32/php72/php7apache2_4.dll` | `c:/wamp/32/php72` |
| php7.1 | 32    | php7_module   | `c:/wamp/32/php72/php7apache2_4.dll` | `c:/wamp/32/php71` |
| php7.0 | 32    | php7_module   | `c:/wamp/32/php70/php7apache2_4.dll` | `c:/wamp/32/php70` |
| php5.6 | 32    | php5_module   | `c:/wamp/32/php56/php5apache2_4.dll` | `c:/wamp/32/php56` |

> 只有正确配置 `PHPINIDir` ，才能成功加载 php.ini 配置文件

#### 配置 httpd.ini 这个自定义配置文件

> 该文件为阿帕奇做了几件事情：
>
> 1.  `vhost_alias_module` ：虚拟主机模块开启
> 2.  `rewrite_module` ：伪静态模块开启
> 3.  将 .php 文件自动解析为 PHP 脚本
> 4.  新增一个Web目录
> 5.  为站点指定默认文件
> 6.  让 .htaccess 文件支持伪静态
> 7.  自定义虚拟主机配置文件

1.  为阿帕奇开启虚拟主机模块

    ```ini
    LoadModule vhost_alias_module modules/mod_vhost_alias.so
    ```

2.  为阿帕奇开启伪静态模块

    ```ini
    LoadModule rewrite_module modules/mod_rewrite.so
    ```

3.  将 .php 文件自动解析为 PHP 脚本

    ```ini
    AddType application/x-httpd-php .php
    ```

    > 当然阿帕奇也支持多类型的文件，自动解析为 PHP 脚本

    ```conf
    AddType application/x-httpd-php .php .emad
    ```

4.  新增一个Web目录

    ```ini
    <Directory "c:/wamp/www">
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
    </Directory>
    ```

5.  让 .htaccess 支持伪静态定义

    > -   在 `<Directory>` 内将 `AllowOverride None` 替换成 `AllowOverride All`
    > -   该Web目录及子目录下的所有 .htaccess 文件都支持伪静态定义

    ```ini
    AllowOverride All
    ```

6.  为站点指定默认文件

    > 格式： `DirectoryIndex <文件名.文件格式> ...`

    ```ini
    DirectoryIndex index.html index.php
    ```

7.  自定义虚拟主机配置文件

    > -   `Include` 所指定的所有文件都会被阿帕奇视为配置文件，启动阿帕奇时将被加载
    > -   如下定义后，sites目录下所有conf格式的文件在阿帕奇启动时，都会被加载！

    ```ini
    Include "c:/wamp/sites/*.conf"
    ```

    > 附录： httpd.ini 自定义配置文件的所有内容

    ```ini文件
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

#### 为阿帕奇创建站点

1.  创建阿帕奇前有几个说明：

    > -   阿帕奇启动时，能被加载的配置文件，都可以用来创建站点
    > -   一个配置文件可以创建多个站点

2.  当前符合创建站点的配置文件

    > -   主配置文件：`httpd.conf`
    > -   子配置文件：`httpd.ini` `httpd32.ini` `httpd64.ini`
    > -   子配置文件：sites目录下的所有conf格式文件

3.  站点1：以 `Web根目录` 作为为站点根目录

    > 其实我们有多个 `Web根目录`，我们基本上只用 `c:/wamp/www` 这个Web根目录

    ```conf
    # 在sites目录下新建 vhosts.conf 文件（基本上只用1个文件作为站点配置文件）
    <VirtualHost *:80>
        DocumentRoot "c:/wamp/www"
        ServerName localhost
    </VirtualHost>
    ```

4.  站点2：用 `Web根目录的子目录` 作为站点根目录

    > 大多数网站都会以这类形式存在

    ```conf
    # vhosts.conf 文件新增内容
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

5.  将域名绑定到本地

    > -   本地开发环境下，我们需要将站点域名加入到 `hosts` 系统文件下才能生效
    > -   文件路径： `c:\Windows\System32\drivers\etc\hosts`

    ```hosts
    # 在底部新增一行
    127.0.0.1 www.tp5.com tp5.com
    ```

### 将 apache2 加入到系统服务中

-   加入系统变量的操作

    > -   操作前提：只安装1个阿帕奇服务
    > -   操作方法：将 bin 目录加入到系统变量 PATH 中
    > -   cmd要求：需要有管理员权限

    ```shell
    httpd.exe -k install -n <service-httpd>
    ```

-   不加入系统变量的操作

    > -   操作前提：安装多个阿帕奇服务
    > -   操作方法：进入 bin 目录后才能操作
    > -   cmd要求：需要有管理员权限

    ```shell
    httpd.exe -k install -n <service-httpd>
    ```

### 将 apache2 从系统服务中卸载

> -   方法一：使用阿帕奇自带的工具卸载
> -   方法一：使用系统工具强制删除

-   使用阿帕奇自带的工具卸载

    > -   操作前提：确保阿帕奇服务未损坏
    > -   操作方法：未加入环境变量的需要进入 bin 目录后才能操作
    > -   cmd要求：需要有管理员权限

    ```shell
    httpd.exe -k uninstall -n <service-httpd>
    ```

-   使用系统工具强制删除

    > -   优点1：不需要进入 bin 目录后才能操作
    > -   优点2：只要系统存在该服务，就算阿帕奇损坏了，也能正常删除
    > -   cmd要求：需要有管理员权限

    ```shell
    sc delete <service-httpd>
    ```

### 启动 apache2 服务器

> -   cmd要求：需要有管理员权限
> -   注意：阿帕奇需要安装到系统服务后才能启动

```shell
net start <service-httpd>
```

> -   默认情况：阿帕奇默认使用80和443端口，如果端口不变，系统只能开启一个阿帕奇服务
> -   修改端口：为每个阿帕奇都定义不同的空闲端口后，系统就可以开启多个阿帕奇服务
> -   端口占用：如果端口被占用也无法开启服务，需先关闭占用端口的软件，才能正常开启服务

### 关闭 apache2 服务器

> cmd要求：需要有管理员权限

```shell
net stop <service-httpd>
```

### `service-httpd` 属性值列表

| digit | `service-httpd` |
| ----- | --------------- |
| 64    | apache24        |
| 32    | httpd           |

## 配置 php

### 配置前的准备

> -   进入php所在目录，拷贝文件 `php.ini-development` ，并重命名为 `php.ini`
> -   将对应版本的 php_xdebug 扩展文件复制到 ext 目录下，并重命名为 `php_xdebug.dll`

### 配置php扩展前的准备

> -   默认：ms版的php默认情况下扩展的路径是 `c:\php\etc`
> -   修改：如果我们的php路径不在c盘根目录下，`extension_dir` 就需要指定正确的 `绝对路径`
> -   操作：将 734 行内容 `; extension_dir = "ext"` 替换如下：

```ini
extension_dir = "<extension-path>"
```

| digit | version  | `extension-path`       |
| ----- | -------- | ---------------------- |
| 64    | `php7.2` | `c:\wamp\64\php72\ext` |
| 64    | `php7.1` | `c:\wamp\64\php71\ext` |
| 64    | `php7.0` | `c:\wamp\64\php70\ext` |
| 64    | `php5.6` | `c:\wamp\64\php56\ext` |
| 32    | `php7.2` | `c:\wamp\32\php72\ext` |
| 32    | `php7.1` | `c:\wamp\32\php71\ext` |
| 32    | `php7.0` | `c:\wamp\32\php70\ext` |
| 32    | `php5.6` | `c:\wamp\32\php56\ext` |

### php允许错误提示

> php.ini 文件可以对错误是否提示进行控制

### 开启错误提示

> 操作：php.ini 第 99 行新增内容：

```ini
display_errors = On
```

### 设置错误级别报告

1.  php.ini 全局版

    > -   说明：达到指定的错误级别才会提示错误报告
    > -   操作：php.ini 第 110 行下新增内容：

    ```ini
    error_reporting = E_ALL
    ```

    > -   开发环境下错误级别报告推荐设置成 `E_ALL`
    > -   生产环境中应该将错误级别报告调整的尽量高些，比如： `E_ALL & ~E_DEPRECATED & ~E_STRICT`

2.  `.php` 文件版

    > -   运用场景：一般都是在生产模式下，遇到问题针对个别文件开启调试用的
    > -   操作方法1：`error_reporting()` 函数能够在运行时设置 `error_reporting` 指令
    > -   操作方法2：`ini_set()` 函数能够为一个配置选项设置值

    ```php
    // <?php
    // 关闭错误报告
    error_reporting(0);

    // 报告 runtime 错误
    error_reporting(E_ERROR | E_WARNING | E_PARSE);

    // 报告所有错误
    error_reporting(E_ALL);

    // 等同 error_reporting(E_ALL);
    ini_set("error_reporting", E_ALL);

    // 报告 E_NOTICE 之外的所有错误
    error_reporting(E_ALL & ~E_NOTICE);
    ```

> 错误级别一览表


### 开启 php_xdebug 扩展

> -   前提：php允许错误提示
> -   说明：开启php_xdebug扩展后，php对错误提示会更加直观
> -   操作：在 php.ini 底部新增两行

```ini
[XDebug]
zend_extension="php_xdebug.dll"
```

> 也可以省略前缀和后缀

```ini
[XDebug]
zend_extension="xdebug"
```

> 提示：如果以上两种写法都不行，请用扩展的绝对地址（反斜杠 `\` 不需要转成正斜杠 `/`）！

### 开启php自带的扩展

> -   默认：默认情况下 php 的扩展是没有开启的
> -   操作：在php.ini文件中将扩展的注释去掉即可

-   案例：thinkphp5.1框架必须要开启的扩展

> php7.2版本的扩展名

| modules   | explain              |
| --------- | -------------------- |
| mbstring  | 让php支持多字节字符串         |
| pdo_mysql | 让php支持使用pdo格式操作mysql |

> php5.6-php 7.1版本的扩展名

| modules             | explain              |
| ------------------- | -------------------- |
| `php_mbstring.dll`  | 让php支持多字节字符串         |
| `php_pdo_mysql.dll` | 让php支持使用pdo格式操作mysql |

## 配置 mariadb

### 创建 my.ini

> -   默认说明：默认情况下mariadb没有my.ini文件，需要我们自己新建
> -   参考文件：mariadb目录下有几个 `my-*.ini` 文件，都是参考文件，我们可以根据需要自行配置
> -   操作说明：下面我们在 `c:\wamp\conf` 目录下创建 my.ini，并输入如下内容：

```ini
[client]
port = 3306

[mysqld]
port = 3306
datadir = "c:/wamp/data"
```

> -   提示：`innodb` 索引扩展默认会跟 `datadir` 同级，没有特殊必要不需要配置
> -   注意：切换版本前需要将data目录下的非目录文件删除掉

### 初始化 data 目录

> 前提：需要将data目录内容复制到指定位置
> cmd：cmd需要管理员权限
> 操作：cmd进入bin目录，输入指令如下：

```shell
mysqld --initialize
```

> mariadb 初始化影响不大，每次重启都会初始化（除非你不想重启）

### 安装mariadb到系统服务

> -   前提：data目录正确，my.ini文件路径正确
> -   情况1：my.ini 在mariadb根目录下的安装方法
> -   情况2：my.ini 不在mariadb根目录下的安装方法

1.  my.ini 在mariadb根目录下

    > cmd：cmd需要管理员权限
    > 操作：cmd进入bin目录，输入指令如下：

    ```shell
    mysqld.exe --install <serviceName>
    ```

    > `serviceName` 是自定义服务名，为空会自动命名为 `MySQL`

2.  my.ini 不在mariadb根目录下

    > 默认:默认会获取在mariadb根目录上的my.ini（假如存在）
    > cmd：cmd需要管理员权限
    > 操作：cmd进入bin目录，输入指令如下：

    ```shell
    mysqld.exe --install <serviceName> --defaults-file=c:\wamp\conf\my.ini
    ```

### 卸载 mariadb 系统服务

### 将 mariadb 安装到系统服务

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

## 配置系统服务启动类型

> 配置服务：不管是阿帕奇系统服务、mariadb系统服务方式都一样：

```shell
sc config <service-name> start=<set-value>
```

| `set-value` | explain |
| ----------- | ------- |
| auto        | 自动      |
| demand      | 手动      |
| disabled    | 禁用      |

## 附录一：指令集中营

### 阿帕奇指令篇

> 将阿帕奇写入系统服务

| `32 & 64` | command                           | 是否进入bin目录 |
| --------- | --------------------------------- | --------- |
| 64        | `httpd.exe -k install -n apache2` | 是         |
| 32        | `httpd.exe -k install -n httpd`   | 是         |

> 启动和关闭阿帕奇服务

| `32 & 64` | command             | 是否进入bin目录 |
| --------- | ------------------- | --------- |
| 64        | `net start apache2` | 否         |
| 32        | `net start httpd`   | 否         |
| 64        | `net stop apache2`  | 否         |
| 32        | `net stop httpd`    | 否         |

> 卸载阿帕奇服务

| `32 & 64` | command                             | 是否进入bin目录 |
| --------- | ----------------------------------- | --------- |
| 64        | `httpd.exe -k uninstall -n apache2` | 是         |
| 32        | `httpd.exe -k uninstall -n httpd`   | 是         |

> 强制删除阿帕奇服务
>
> -   阿帕奇损坏后，就不能使用阿帕奇自带的卸载指令，需使用cmd的 `sc delete service` 指令来删除

| `32 & 64` | command             | 是否进入bin目录 |
| --------- | ------------------- | --------- |
| 64        | `sc delete apache2` | 否         |
| 32        | `sc delete httpd`   | 否         |

### mariadb 指令篇

> 将 mariadb 写入系统服务

| versions     | `32 & 64` | command                     | 是否进入bin目录 |
| ------------ | --------- | --------------------------- | --------- |
| mariadb 10.2 | 64        | `mysqld install mysql102`   | 是         |
| mariadb 10.2 | 32        | `mysqld install mariadb102` | 是         |
| mariadb 10.1 | 64        | `mysqld install mysql101`   | 是         |
| mariadb 10.1 | 32        | `mysqld install mariadb101` | 是         |
| mariadb 10.0 | 64        | `mysqld install mysql100`   | 是         |
| mariadb 10.0 | 32        | `mysqld install mariadb100` | 是         |

> 启动 mariadb 服务

| versions     | `32 & 64` | command                | 是否进入bin目录 |
| ------------ | --------- | ---------------------- | --------- |
| mariadb 10.2 | 64        | `net start mysql102`   | 否         |
| mariadb 10.2 | 32        | `net start mariadb102` | 否         |
| mariadb 10.1 | 64        | `net start mysql101`   | 否         |
| mariadb 10.1 | 32        | `net start mariadb101` | 否         |
| mariadb 10.0 | 64        | `net start mysql100`   | 否         |
| mariadb 10.0 | 32        | `net start mariadb100` | 否         |

> 关闭 mariadb 服务

| versions     | `32 & 64` | command               | 是否进入bin目录 |
| ------------ | --------- | --------------------- | --------- |
| mariadb 10.2 | 64        | `net stop mysql102`   | 否         |
| mariadb 10.2 | 32        | `net stop mariadb102` | 否         |
| mariadb 10.1 | 64        | `net stop mysql101`   | 否         |
| mariadb 10.1 | 32        | `net stop mariadb101` | 否         |
| mariadb 10.0 | 64        | `net stop mysql100`   | 否         |
| mariadb 10.0 | 32        | `net stop mariadb100` | 否         |

> 卸载 mariadb 服务

| versions     | `32 & 64` | command                    | 是否进入bin目录 |
| ------------ | --------- | -------------------------- | --------- |
| mariadb 10.2 | 64        | `mysqld remove mysql102`   | 是         |
| mariadb 10.2 | 32        | `mysqld remove mariadb102` | 是         |
| mariadb 10.1 | 64        | `mysqld remove mysql101`   | 是         |
| mariadb 10.1 | 32        | `mysqld remove mariadb101` | 是         |
| mariadb 10.0 | 64        | `mysqld remove mysql100`   | 是         |
| mariadb 10.0 | 32        | `mysqld remove mariadb100` | 是         |

> 强制删除 mariadb 服务
>
> -   mariadb 损坏后，就不能使用 mariadb 自带的卸载指令，需使用cmd的 `sc delete service` 指令来删除

| versions     | `32 & 64` | command                | 是否进入bin目录 |
| ------------ | --------- | ---------------------- | --------- |
| mariadb 10.2 | 64        | `sc delete mysql102`   | 否         |
| mariadb 10.2 | 32        | `sc delete mariadb102` | 否         |
| mariadb 10.1 | 64        | `sc delete mysql101`   | 否         |
| mariadb 10.1 | 32        | `sc delete mariadb101` | 否         |
| mariadb 10.0 | 64        | `sc delete mysql100`   | 否         |
| mariadb 10.0 | 32        | `sc delete mariadb100` | 否         |
