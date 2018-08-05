# windows下纯手工配置wamp开发环境

> 实践是检验真理的唯一标准，做开发最重要的一条就是练习、练习、再练习！

## wamp开发环境介绍

> 该wamp开发环境有两种组合：1）推荐版（64位）；2）兼容版（32位）

### 推荐版（64位）安装包列表

> 需要安装运行库版本 `vc15_x64`

1. `httpd-2.4.34-win64-VC15.zip`
2. `mariadb-10.3.8-winx64.zip`
3. `php-7.2.8-Win32-VC15-x64.zip`
4. `phpMyAdmin-4.8.2-all-languages.zip`
5. `MSVBCRT_AIO_2018.07.30_X86+X64.exe`

### 兼容版（32位）安装包列表

> 需要安装运行库版本 `vc11_x86`

1. `httpd-2.4.34-win32-VC11.zip`
2. `mariadb-10.0.36-win32.zip`
3. `php-5.6.37-Win32-VC11-x86.zip`
4. `phpMyAdmin-4.8.2-all-languages.zip`
5. `MSVBCRT_AIO_2018.07.30_X86.exe`

### 目录结构如下：

```shell
├─     ====================     wamp环境部署目录
├─32                            32位安装包
│  ├─apache24                   Web服务器
│  │  ├─bin                     阿帕奇可执行程序目录
│  │  ├─conf                    配置
│  │  │  ├─httpd.conf           阿帕奇主配置文件
│  │  │  └─ ...
│  │  └─ ...
│  │
│  ├─mariadb                    mariadb 10.0版本
│  │  ├─bin                     mariadb可执行程序目录
│  │  └─ ...
│  │
│  ├─php                        php 5.6版本
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
│  ├─mariadb                    mariadb 10.3版本
│  │  ├─bin                     mariadb可执行程序目录
│  │  └─ ...
│  │
│  ├─php                        php 7.2版本
│  │  ├─ext                     模块目录
│  │  ├─php.ini                 php主配置文件
│  │  └─ ...
│  │
│
├─conf                          公用配置文件目录
│
├─logs                          服务器相关日志文件目录
│  │  ├─apache24                apache24日志目录
│  │  ├─mariadb                 mariadb日志目录
│  │
│
├─sites                         站点配置文件目录
│
├─www                           Web根目录
│
├─www-default                   apache24站点缺省位置
│
├─data                          mariadb数据库存放目录
│
└─phpmyadmin                    网页版mariadb数据库管理平台（编程语言是php）
```



到此==============================================

### httpd.conf下为apache24配置日志
> 日志分 `访问日志` 和 `错误日志`

#### 错误日志级别

> - 描述：apache24定义了日志级别，我们可通过 `LogLevel` 定制自己的日志级别
> - 格式： `LogLevel 级别代号`

级别      | 描述
------- | -----------------------
`ALL`   | 所有级别，包括定制级别
`TRACE` | 比 DEBUG 级别的粒度更细
`DEBUG` | 指明细致的事件信息，对调试应用最有用
`INFO`  | 指明描述信息，从粗粒度上描述了应用运行过程
`WARN`  | 指明潜在的有害状况
`ERROR` | 指明错误事件，但应用可能还能继续运行
`FATAL` | 指明非常严重的错误事件，可能会导致应用终止执行
`OFF`   | 最高级别，用于关闭日志

1. 配置日志格式

  > `LogFormat` 下添加 `%V` ，让日志显示访问的域名

2. 配置日志记录值

  > 让 apache2 日志不记录图片、css、js等资源

  ```shell
  <FilesMatch "\.(ico|gif|jpg|png|bmp|swf|css|js)">
  SetEnv LOG_IMAG 1
  </FilesMatch>
  CustomLog "日志路径/日志文件名" combined env=!LOG_IMAG
  ```

#### 为 apache2 增加配置文件

> - 说明：阿帕奇可以在 httpd.conf 内使用 Include 加入其它配置文件
> - 操作：在 httpd.conf 底部增加两行 Include 指令
> - 注意：32位和64位有一个文件是不同的

digit | public                             | diff
----- | ---------------------------------- | ------------------------------------
32    | `Include "c:/wamp/conf/httpd.ini"` | `Include "c:/wamp/conf/httpd32.ini"`
64    | `Include "c:/wamp/conf/httpd.ini"` | `Include "c:/wamp/conf/httpd64.ini"`

#### 为 apache2 绑定 php

> 操作2个自定义配置文件： `httpd32.ini` `httpd64.ini`

> - `module-name`：apache2.4绑定php的模块名
> - `module-path`：apache2.4绑定php5的模块路径（绝对路径）
> - `phpinidir-path`：php.ini配置文件的路径（绝对路径）

```ini
LoadModule <module-name> <module-path>
PHPINIDir <phpinidir-path>
```

> 属性一览表

php    | digit | `module-name` | module-path                          | `phpinidir-path`
------ | ----- | ------------- | ------------------------------------ | ------------------
php7.2 | 64    | php7_module   | `c:/wamp/64/php72/php7apache2_4.dll` | `c:/wamp/64/php72`
php7.1 | 64    | php7_module   | `c:/wamp/64/php72/php7apache2_4.dll` | `c:/wamp/64/php71`
php7.0 | 64    | php7_module   | `c:/wamp/64/php70/php7apache2_4.dll` | `c:/wamp/64/php70`
php5.6 | 64    | php5_module   | `c:/wamp/64/php56/php5apache2_4.dll` | `c:/wamp/64/php56`
php5.5 | 64    | php5_module   | `c:/wamp/64/php55/php5apache2_4.dll` | `c:/wamp/64/php55`
php7.2 | 32    | php7_module   | `c:/wamp/32/php72/php7apache2_4.dll` | `c:/wamp/32/php72`
php7.1 | 32    | php7_module   | `c:/wamp/32/php72/php7apache2_4.dll` | `c:/wamp/32/php71`
php7.0 | 32    | php7_module   | `c:/wamp/32/php70/php7apache2_4.dll` | `c:/wamp/32/php70`
php5.6 | 32    | php5_module   | `c:/wamp/32/php56/php5apache2_4.dll` | `c:/wamp/32/php56`
php5.5 | 32    | php5_module   | `c:/wamp/32/php55/php5apache2_4.dll` | `c:/wamp/32/php55`
php5.4 | 32    | php5_module   | `c:/wamp/32/php54/php5apache2_4.dll` | `c:/wamp/32/php54`
php5.3 | 32    | php5_module   | `c:/wamp/32/php53/php5apache2_4.dll` | `c:/wamp/32/php53`

> 只有正确配置 `PHPINIDir` ，才能成功加载 php.ini 配置文件

#### 配置 httpd.ini 这个自定义配置文件

> 该文件为阿帕奇做了几件事情：

> 1. `vhost_alias_module` ：虚拟主机模块开启
> 2. `rewrite_module` ：伪静态模块开启
> 3. 将 .php 文件自动解析为 PHP 脚本
> 4. 新增一个Web目录
> 5. 为站点指定默认文件
> 6. 让 .htaccess 文件支持伪静态
> 7. 自定义虚拟主机配置文件

1. 为阿帕奇开启虚拟主机模块

  ```shell
  LoadModule vhost_alias_module modules/mod_vhost_alias.so
  ```

2. 为阿帕奇开启伪静态模块

  ```shell
  LoadModule rewrite_module modules/mod_rewrite.so
  ```

3. 将 .php 文件自动解析为 PHP 脚本

  ```shell
  AddType application/x-httpd-php .php
  ```

  > 当然阿帕奇也支持多类型的文件，自动解析为 PHP 脚本，例如：

  ```shell
  AddType application/x-httpd-php .php .emad
  ```

4. 新增一个Web目录

  ```shell
  <Directory "c:/wamp/www">
  Options Indexes FollowSymLinks
  AllowOverride None
  Require all granted
  </Directory>
  ```

5. 让 .htaccess 支持伪静态定义

  > - 在 `<Directory>` 内将 `AllowOverride None` 替换成 `AllowOverride All`
  > - 该Web目录及子目录下的所有 .htaccess 文件都支持伪静态定义

  ```shell
  AllowOverride All
  ```

6. 为站点指定默认文件

  > 格式： `DirectoryIndex <文件名.文件格式> ...`

  ```shell
  DirectoryIndex index.html index.php
  ```

7. 自定义虚拟主机配置文件

  > - `Include` 所指定的所有文件都会被阿帕奇视为配置文件，启动阿帕奇时将被加载
  > - 如下定义后，sites目录下所有conf格式的文件在阿帕奇启动时，都会被加载！

  ```shell
  Include "c:/wamp/sites/*.conf"
  ```

  > 附录： httpd.ini 自定义配置文件的所有内容

  ```shell
  LoadModule vhost_alias_module modules/mod_vhost_alias.so
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

1. 创建阿帕奇前有几个说明：

  > - 阿帕奇启动时，能被加载的配置文件，都可以用来创建站点
  > - 一个配置文件可以创建多个站点

2. 当前符合创建站点的配置文件

  > - 主配置文件：`httpd.conf`
  > - 子配置文件：`httpd.ini` `httpd32.ini` `httpd64.ini`
  > - 子配置文件：sites目录下的所有conf格式文件

3. 站点1：以 `Web根目录` 作为为站点根目录

  > 其实我们有多个 `Web根目录`，我们基本上只用 `c:/wamp/www` 这个Web根目录

  ```shell
  # 在sites目录下新建 vhosts.conf 文件（基本上只用1个文件作为站点配置文件）
  <VirtualHost *:80>
  DocumentRoot "c:/wamp/www"
  ServerName localhost
  </VirtualHost>
  ```

4. 站点2：用 `Web根目录的子目录` 作为站点根目录

  > 大多数网站都会以这类形式存在

  ```shell
  # vhosts.conf 文件新增内容
  <VirtualHost *:80>
  ServerAdmin linjialiang@163.com
  DocumentRoot "c:/wamp/www/tp5/public"
  ServerName www.tp5.com
  ServerAlias www.tp5.com tp5.com m.tp5.com
  ErrorDocument 404 /404.html

  ErrorLog "logs/tp5-error.log"
  CustomLog "logs/tp5-access.log" common

  RewriteEngine on
  RewriteCond %{HTTP_HOST} ^tp5.com$ [NC]
  RewriteRule ^(.*)$ http://www.%{HTTP_HOST}$1 [R=301,L]
  </VirtualHost>
  ```

5. 将域名绑定到本地

  > - 本地开发环境下，我们需要将站点域名加入到 `hosts` 系统文件下才能生效
  > - 文件路径： `c:\Windows\System32\drivers\etc\hosts`

  ```hosts
  # 在底部新增一行
  127.0.0.1 www.tp5.com tp5.com
  ```

### 将 apache2 加入到系统服务中

- 加入系统变量的操作

  > - 操作前提：只安装1个阿帕奇服务
  > - 操作方法：将 bin 目录加入到系统变量 PATH 中
  > - cmd要求：需要有管理员权限

  ```shell
  httpd.exe -k install -n <service-httpd>
  ```

- 不加入系统变量的操作

  > - 操作前提：安装多个阿帕奇服务
  > - 操作方法：进入 bin 目录后才能操作
  > - cmd要求：需要有管理员权限

  ```shell
  httpd.exe -k install -n <service-httpd>
  ```

### 将 apache2 从系统服务中卸载

> - 方法一：使用阿帕奇自带的工具卸载
> - 方法一：使用系统工具强制删除

- 使用阿帕奇自带的工具卸载

  > - 操作前提：确保阿帕奇服务未损坏
  > - 操作方法：未加入环境变量的需要进入 bin 目录后才能操作
  > - cmd要求：需要有管理员权限

  ```shell
  httpd.exe -k uninstall -n <service-httpd>
  ```

- 使用系统工具 `sc` 从注册表删除服务

  > - 优点1：不需要进入 bin 目录后才能操作
  > - 优点2：只要系统存在该服务，就算阿帕奇损坏了，也能正常删除
  > - cmd要求：需要有管理员权限

  ```shell
  sc delete <service-httpd>
  ```

### 启动 apache2 服务器

> - cmd要求：需要有管理员权限
> - 注意：阿帕奇需要安装到系统服务后才能启动

```shell
net start <service-httpd>
```

> - 默认情况：阿帕奇默认使用80和443端口，如果端口不变，系统只能开启一个阿帕奇服务
> - 修改端口：为每个阿帕奇都定义不同的空闲端口后，系统就可以开启多个阿帕奇服务
> - 端口占用：如果端口被占用也无法开启服务，需先关闭占用端口的软件，才能正常开启服务

### 关闭 apache2 服务器

> cmd要求：需要有管理员权限

```shell
net stop <service-httpd>
```

### `service-httpd` 属性值列表

digit | `service-httpd`
----- | ---------------
64    | apache24
32    | httpd

## 配置 php

### 配置前的准备

> - 进入php所在目录，拷贝文件 `php.ini-development` ，并重命名为 `php.ini`
> - 将对应版本的 php_xdebug 扩展文件复制到 ext 目录下，并重命名为 `php_xdebug.dll`

### 配置php扩展前的准备

> - 默认：ms版的php默认情况下扩展的路径是 `c:\php\etc`
> - 修改：如果我们的php路径不在c盘根目录下，`extension_dir` 就需要指定正确的 `绝对路径`
> - 操作：将 734 行内容 `; extension_dir = "ext"` 替换如下：

```ini
extension_dir = "<extension-path>"
```

digit | version  | `extension-path`
----- | -------- | ----------------------
64    | `php7.2` | `c:\wamp\64\php72\ext`
64    | `php7.1` | `c:\wamp\64\php71\ext`
64    | `php7.0` | `c:\wamp\64\php70\ext`
64    | `php5.6` | `c:\wamp\64\php56\ext`
64    | `php5.5` | `c:\wamp\64\php55\ext`
32    | `php7.2` | `c:\wamp\32\php72\ext`
32    | `php7.1` | `c:\wamp\32\php71\ext`
32    | `php7.0` | `c:\wamp\32\php70\ext`
32    | `php5.6` | `c:\wamp\32\php56\ext`
32    | `php5.5` | `c:\wamp\32\php55\ext`
32    | `php5.4` | `c:\wamp\32\php54\ext`
32    | `php5.3` | `c:\wamp\32\php53\ext`

### php允许错误提示

> php.ini 文件可以对错误是否提示进行控制

### 开启错误提示（php.ini-development 默认已经开启）

> 操作：php.ini 第 470 行左右：

```ini
display_errors = On
```

### 设置错误级别报告

1. php.ini 全局版（php.ini-development 默认已经开启）

  > - 说明：达到指定的错误级别才会提示错误报告
  > - 操作：php.ini 第 450 行左右：

  ```shell
  error_reporting = E_ALL
  ```

  > - 说明：错误的函数
  > - 操作：php.ini 第 540 行左右：

  ```shell
  html_errors = On
  ```

  > - 开发环境下错误级别报告推荐设置成 `E_ALL`
  > - 生产环境中应该将错误级别报告调整的尽量高些，比如： `E_ALL & ~E_DEPRECATED & ~E_STRICT`

2. `.php` 文件版

  > - 运用场景：一般都是在生产模式下，遇到问题针对个别文件开启调试用的
  > - 操作方法1：`error_reporting()` 函数能够在运行时设置 `error_reporting` 指令
  > - 操作方法2：`ini_set()` 函数能够为一个配置选项设置值

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

> [错误级别一览表](http://php.net/manual/zh/errorfunc.constants.php)

`error-id` | `error-name`        | 描述
---------- | ------------------- | ---------------------
1          | E_ERROR             | 致命的运行时错误
2          | E_WARNING           | 运行时警告
4          | E_PARSE             | 编译时语法解析错误
8          | E_NOTICE            | 运行时通知
16         | E_CORE_ERROR        | 在PHP初始化启动过程中发生的致命错误
32         | E_CORE_WARNING      | PHP初始化启动过程中发生的警告
64         | E_COMPILE_ERROR     | 致命编译时错误。
128        | E_COMPILE_WARNING   | 编译时警告
256        | E_USER_ERROR        | 用户产生的错误信息。
512        | E_USER_WARNING      | 用户产生的警告信息。
1024       | E_USER_NOTICE       | 用户产生的通知信息。
2048       | E_STRICT            | 启用 PHP 对代码的修改建议。
4096       | E_RECOVERABLE_ERROR | 可被捕捉的致命错误。
8192       | E_DEPRECATED        | 运行时通知
16384      | E_USER_DEPRECATED   | 用户产少的警告信息。
30719      | E_ALL               | E_STRICT除外的所有错误和警告信息。

> - 可以使用按位运算符来组合这些值或者屏蔽某些类型的错误
> - 在 php.ini 之中， 只有 `|` `~` `!` `^` `&` 生效，下面是[php位运算符规则](http://php.net/manual/zh/language.operators.bitwise.php)

例子         | 名称              | 结果
---------- | --------------- | ----------------------------------
`$a & $b`  | And（按位与）        | 将把 $a 和 $b 中都为 1 的位设为 1。
`$a 1 $b`  | Or（按位或）         | 将把 $a 和 $b 中任何一个为 1 的位设为 1。
`$a ^ $b`  | Xor（按位异或）       | 将把 $a 和 $b 中一个为 1 另一个为 0 的位设为 1。
`~ $a`     | Not（按位取反）       | 将 $a 中为 0 的位设为 1，反之亦然。
`$a << $b` | Shift left（左移）  | 将 $a 中的位向左移动 $b 次（每一次移动都表示"乘以 2"）。
`$a >> $b` | Shift right（右移） | 将 $a 中的位向右移动 $b 次（每一次移动都表示"除以 2"）。

### 开启 php_xdebug 扩展

> - 前提：php允许错误提示
> - 说明：开启php_xdebug扩展后，php对错误提示会更加直观
> - 操作：在 php.ini 底部新增两行

```ini
[XDebug]
zend_extension="php_xdebug.dll"
```

> 也可以省略前缀和后缀

```ini
[XDebug]
zend_extension="xdebug"
```

> 注意： `php5.3 php 5.4` 写法与高版本有所不同，需要将 `zend_extension` 改成 `extension`

```ini
[XDebug]
extension="php_xdebug.dll"
```

> 提示：如果以上两种写法都不行，可能是由于 `extension_dir` 没有使用绝对路径导致的，这样请用扩展的绝对地址（反斜杠 `\` 不需要转成正斜杠 `/`）！

### 开启php自带的扩展

> - 默认：默认情况下 php 的扩展是没有开启的
> - 操作：在php.ini文件中将扩展的注释去掉即可

- 案例：thinkphp5.1框架必须要开启的扩展

> php7.2版本的扩展名

modules   | explain
--------- | --------------------
mbstring  | 让php支持多字节字符串
pdo_mysql | 让php支持使用pdo格式操作mysql

> php5.6-php 7.1版本的扩展名

modules             | explain
------------------- | --------------------
`php_mbstring.dll`  | 让php支持多字节字符串
`php_pdo_mysql.dll` | 让php支持使用pdo格式操作mysql

## 配置 mariadb

### 创建 my.ini

> - 默认说明：默认情况下mariadb没有my.ini文件，需要我们自己新建
> - 参考文件：mariadb目录下有几个 `my-*.ini` 文件，都是参考文件，我们可以根据需要自行配置
> - 操作说明：下面我们在 `c:\wamp\conf` 目录下创建 my.ini，并输入如下内容：

```ini
[client]
port = 3306

[mysqld]
port = 3306
datadir = "c:/wamp/data"
```

> - 提示：`innodb` 索引扩展默认会跟 `datadir` 同级，没有特殊必要不需要配置
> - 注意：切换版本前需要将data目录下的非目录文件删除掉

### 初始化 data 目录

> 前提：需要将data目录内容复制到指定位置 cmd：cmd需要管理员权限 操作：cmd进入bin目录，输入指令如下：

```shell
mysqld --initialize
```

> mariadb 初始化影响不大，每次重启都会初始化（除非你不想重启）

### 安装mariadb到系统服务

> - 前提：data目录正确，my.ini文件路径正确
> - 情况1：my.ini 在mariadb根目录下的安装方法
> - 情况2：my.ini 不在mariadb根目录下的安装方法

1. my.ini 在mariadb根目录下

  > cmd：cmd需要管理员权限 操作：cmd进入bin目录，输入指令如下：

  ```shell
  mysqld.exe --install <service-mariadb>
  ```

  > `service-mariadb` 是自定义服务名，为空会自动命名为 `MySQL`

2. my.ini 不在mariadb根目录下

  > 默认:默认会获取在mariadb根目录上的my.ini（假如存在） cmd：cmd需要管理员权限 操作：cmd进入bin目录，输入指令如下：

  ```shell
  mysqld.exe --install <service-mariadb> --defaults-file=c:\wamp\conf\my.ini
  ```

### 卸载 mariadb 系统服务

- 用mariadb自带工具卸载

  > cmd：cmd需要管理员权限 操作：cmd进入bin目录，输入指令如下：

  ```shell
  mysqld.exe --remove <service-mariadb>
  ```

- 用系统 `sc` 工具从注册表删除服务

  > cmd：cmd需要管理员权限 `server` 是服务器地址，如果是本地可以省略

  ```shell
  sc <server> delete <service-mariadb>
  ```

### 启动 mariadb 服务

> - 安装系统服务的启动方式
> - 未安装系统服务的启动方式

- 安装系统服务版-启动mariadb服务

  > cmd要求：需要管理员权限

  ```shell
  net start <service-mariadb>
  ```

- 未安装系统服务版-启动mariadb服务

  > cmd要求：需要管理员权限 操作：cmd进入bin目录，输入如下代码：

  ```shell
  mysqld.exe
  ```

  > 如果my.ini不在mariadb根目录需要如下代码：

  ```shell
  mysqld.exe --defaults-file="c:\wamp\conf\my.ini"
  ```

### 停止 mariadb 服务

> - 安装系统服务的停止方式
> - 未安装系统服务的停止方式

- 安装系统服务版-停止mariadb服务

  > cmd要求：需要管理员权限

  ```shell
  net stop <service-mariadb>
  ```

- 未安装系统服务版-停止mariadb服务

  > cmd要求：需要管理员权限 操作：cmd进入bin目录，输入如下代码：

  ```shell
  mysqladmin.exe -uroot shutdown
  ```

  > 如果root存在密码，需要加上 `-p` ，并在出现提示时提供密码

  ```shell
  mysqladmin.exe -uroot -p shutdown
  ```

### `service-mariadb` 属性值一览表

digit | version    | `sercice-mariadb`
----- | ---------- | -----------------
64    | mariadb103 | mysql103
64    | mariadb102 | mysql102
64    | mariadb101 | mysql101
64    | mariadb100 | mysql100
64    | mariadb55  | mysql55
32    | mariadb103 | mariadb103
32    | mariadb102 | mariadb102
32    | mariadb101 | mariadb101
32    | mariadb100 | mariadb100
32    | mariadb55  | mariadb55

## 配置系统服务启动类型

> 配置服务：不管是阿帕奇系统服务、mariadb系统服务方式都一样：

```shell
sc config <service-name> start=<set-value>
```

`set-value` | explain
----------- | -------
auto        | 自动
demand      | 手动
disabled    | 禁用

## 安装 phpMyAdmin

> phpMyAdmin 一个基于Web的mariadb管理工具

### apche2 为 phpMyAdmin 配置别名

> - 别名说明：也算是一种站点的方式
> - 操作：httpd.ini 文件加入如下内容：

```shell
Alias /phpmyadmin c:/wamp/phpMyAdmin
<Directory c:/wamp/phpMyAdmin>
    Options FollowSymLinks
    DirectoryIndex index.php
    <RequireAll>
        Require local
    </RequireAll>
</Directory>
<Directory c:/wamp/phpMyAdmin/libraries>
    Require all denied
</Directory>
<Directory c:/wamp/phpMyAdmin/setup/lib>
    Require all denied
</Directory>
```

### 配置 phpMyAdmin

> - 默认配置文件： `libraries/config.default.php` 这个文件不用于修改
> - 操作： 所有可配置的数据都放在config.inc.php， 如果此文件不存在就创建一个（该文件只需包含你想要改变它们相应默认值的参数）

```php
// config.inc.php 的内容
//<?php
//短语密码
$cfg['blowfish_secret'] = 'bYm@XyamR)P2BurDwNKKwN\uL4YQsV$m(Fp6m';
$i = 0;
$i++;
//设置登陆方式为cookie
$cfg['Servers'][$i]['auth_type'] = 'cookie';
$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['compress'] = false;
$cfg['Servers'][$i]['AllowNoPassword'] = false;
$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';
```

### 提示部分功能未启用的解决方法

> 1. 删除数据库： 将 phpmyadmin 数据库删除
> 2. 登陆phpMyAdmin:首页找到原因那里，进入原因页面
> 3. 创建数据库：进入原因页面后，点击Create会自动创建 phpmyadmin 数据库，这样即可！

### phpMyAdmin 一些注意事项

> - 数据库提供phpmyadmin的高级功能，如果删除，高级功能将无法使用 – 如果未安装或已经删除，可以在找到原因那里，点击Create自动创建
> - phpMyAdmin 连接数据库使用的是php的mysqli扩展，所以php必须安装mysqli扩展包
> - phpMyAdmin 需要账户有密码登陆，所以我们要为mariadb创建一个带密码的账户（我已经将mariadb的root账户已经设置密码为123456）

## wamp 说明书

> 该 `wamp` 安装包解压即用，包含32位和64位版本，并且可自由选择 `mariadb` 与 `php` 的版本！

### mariadb 相关：

1. root的默认密码是123456
2. `mariadb 5.5` 的 `data` 内数据与其它版本有很大不同，最简单的方法就是将 `data` 目录的原始资源全部替换掉
3. `mariadb 10.0` 版本基本上完全兼容 `mariadb 5.5` ，所以 `mariadb 5.5` 已经可以淘汰

### `bat` 脚本须知：

1. bat 脚本的换行符必须是 `\r\n` ，否则不能执行
2. bat 脚本的编码格式需要gb2312（因为中文版系统，其它编码cmd会出现乱码）

### 几个命令脚本说明：

1. `常用服务指令.bat` 该脚本用于启动服务、停止服务、设置服务选项
2. `批量清除服务.bat` 该脚本用来一次性卸载所有相关服务（安装前可执行一遍）
3. `安装.bat` 该脚本用于安装指定版本到相关服务
4. `卸载.bat` 该脚本用于卸载指定版本的相关服务

### 安装说明：

1. 先使用 `批量清除服务.bat` 脚本文件清理一遍
2. 使用 `安装.bat` 脚本文件安装你需要的版本
3. 使用 `常用服务指令.bat` 脚本文件启动或关闭服务

### 运行库支持：该环境包需要运行库支持，运行库建议自己去下载最新版的 `VC15` `VC14` `VC11` `VC9`

### 软件包自带的运行库安装包：

- `MSVBCRT_AIO_2018.05.13_X86.exe`
- `MSVBCRT_AIO_2018.05.13_X86+X64.exe`

> `文档连接` ：[wamp环境搭建说明文档](https://github.com/linjialiang/programmer/blob/dev3/program-language/php/wamp/README.md)
