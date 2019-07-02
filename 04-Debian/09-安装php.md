# 安装 php

> 这里我们以安装 php-7.3.6 为例

## 下载 php

> 直接去 php [官网](https://www.php.net)下载

```shell
$ mkdir /server/php
$ cd /server/php
$ wget https://www.php.net/distributions/php-7.3.6.tar.bz2
$ tar -jxvf php-7.3.6.tar.bz2
```

## 编译前的准备

> 具体查看 [编译前的准备](./info/编译前的准备.md)

## 编译 php 源代码

> php 是使用 autotools 工具来编译的。

```txt
autotools 工具编译的包：
    - 可以使用 ./configure --help 指令来查看所有配置选项
```

1. 创建目录

   ```shell
   $ mkdir /server/php/build
   ```

2. 安装编译依赖

   > 解决依赖项最方便的方法就是缺啥补啥，怎么多执行几次 `./configure` 就是了

   ```shell
   # 我这里只缺少 libxml2-dev
   $ apt install libxml2-dev
   ```

3. 开始编译

   ```shell
   $ cd /server/php/build
   $ /server/php/php-7.3.6/configure
   $ make
   $ make test
   $ make install
   ```

## 处理 php.ini 文件

> 在我们编译安装 PHP 的时候，编译安装完成是不会自动生成 php.ini 文件的，所以需要我们手动生成。

1. 通过命令行确定 `php.ini` 文件的位置

   > 保证 php 可执行文件已经加入环境变量，本次编译默认已加入

   ```shell
   $ php -r "phpinfo();" | grep 'php.ini'
   Configuration File (php.ini) Path => /usr/local/lib

   # 或者使用 php --ini
   $ php --ini
   Configuration File (php.ini) Path: /usr/local/lib
   Loaded Configuration File:         (none)
   Scan for additional .ini files in: (none)
   Additional .ini files parsed:      (none)
   ```

   > 这说明，php.ini 文件需要放在 /usr/local/lib 路径下，php 程序才能正常读取

2. 拷贝 `php.ini` 示例文件

   > 在源码根目录下一般都有 php.ini 示例文件：

   ```text
   开发环境示例： php.ini-development
   部署环境示例： php.ini-production
   ```

   > 具体操作如下：

   ```shell
   $ cd /server/php/php-7.3.6
   $ cp -p -r php.ini-* /usr/local/lib
   $ cd /usr/local/lib
   $ cp -p -r php.ini-development php.ini
   ```

   > 检测是否成功：

   ```shell
   $ php -r "phpinfo();" | grep 'php.ini'
   Configuration File (php.ini) Path => /usr/local/lib
   Loaded Configuration File => /usr/local/lib/php.ini
   # 或者使用 php --ini
   php --ini
   Configuration File (php.ini) Path: /usr/local/lib
   Loaded Configuration File:         /usr/local/lib/php.ini
   Scan for additional .ini files in: (none)
   Additional .ini files parsed:      (none)
   ```

   > 提示：当 `Loaded Configuration File` 出现并指定了文件全路径时，表示加载配置文件成功！

3. php.ini 创建软连接

   > 在 `/etc` 下创建 php 配置文件的软连接

   ```shell
   $ mkdir /etc/php
   $ ln -s /usr/local/lib/php.ini /etc/php/php.ini
   ```

## 安装 php 扩展

> php 扩展官方网址 http://pecl.php.net/

1. 查看已安装的扩展

   > 使用 `php -m` 查看已安装的扩展

   ```shell
   $ php -m
   [PHP Modules]
   Core
   ctype
   date
   dom
   fileinfo
   filter
   hash
   iconv
   json
   libxml
   pcre
   PDO
   pdo_sqlite
   Phar
   posix
   Reflection
   session
   SimpleXML
   SPL
   sqlite3
   standard
   tokenizer
   xml
   xmlreader
   xmlwriter

   [Zend Modules]
   ```

   > 这些扩展都是默认已经安装，并且始终开启，不受 php.ini 控制

2. 查看扩展所在位置

   > 使用 `php-config --extension-dir` 可以查看扩展安装所在路径

   ```shell
   $ php-config --extension-dir
   /usr/local/lib/php/extensions/no-debug-non-zts-20180731
   ```

   > `/usr/local/lib/php/extensions/no-debug-non-zts-20180731` 这个就是扩展路径

3. phpize 命令

   > phpize 命令是用来准备 PHP 扩展库的编译环境的

   | 指令             | 描述         |
   | ---------------- | ------------ |
   | phpize           | 生成编译环境 |
   | phpize --help    | 帮助说明     |
   | phpize --clean   | 清除编译环境 |
   | phpize --version | 显示版本     |
   | phpize -v        | 显示版本     |

### 安装 xdebug 扩展

> 下载地址 http://pecl.php.net/get/xdebug-2.7.2.tgz

```shell
$ mkdir -p /server/php/pkg/xdebug
$ cd /server/php/pkg/xdebug
$ wget http://pecl.php.net/get/xdebug-2.7.2.tgz
$ tar -zxvf xdebug-2.7.2.tgz
```

1. 开始编译

   ```shell
   $ cd /server/php/pkg/xdebug/xdebug-2.7.2
   $ phpize
   $ mkdir /server/php/pkg/xdebug/build
   $ cd /server/php/pkg/xdebug/build
   $ /server/php/pkg/xdebug/xdebug-2.7.2/configure
   $ make
   $ make install
   ```

   > 编译成功后一般会直接将 `.os` 文件拷贝到扩展路径里，否则请自行拷贝到扩展路径里

2. 接下来修改 php.ini

   > 将 xdebug 属于 zend_extension 扩展，写法必须如下：

   ```ini
   ...
   [Xdebug]
   zend_extension=xdebug
   xdebug.profiler_append = 0
   xdebug.profiler_enable = 1
   xdebug.profiler_enable_trigger = 0
   xdebug.profiler_output_dir ="/server/logs/xdebug"
   xdebug.trace_output_dir ="/server/logs/xdebug"
   xdebug.profiler_output_name = "cache.out.%t-%s"
   xdebug.remote_enable = 1
   xdebug.remote_autostart = 1
   xdebug.remote_handler = "dbgp"
   xdebug.remote_host = "127.0.0.1"
   xdebug.idekey= debian9
   ```

   > 创建 xdebug 日志目录

   ```shell
   $ mkdir -p /server/logs/xdebug
   ```

### 安装 pdo_mysql 扩展
