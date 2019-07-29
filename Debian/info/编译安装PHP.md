# 安装 PHP

> php 最好还是编译，这样可以按自己需求构建扩展

## 构建前的准备

> 下载和解压 php7.3.7

```shell
$ mkdir /server/php
$ cd /data/
$ wget https://www.php.net/distributions/php-7.3.7.tar.gz
$ tar -xzvf php-7.3.7.tar.gz
$ mkdir /data/php-7.3.7/php_build
$ cd /data/php-7.3.7/php_build
```

## 编译 php

> 编译并安装 php

### 下载必备的依赖包

> 这是测试机上缺少的依赖包，具体缺失包视情况而定

```shell
$ apt install libxml2-dev libssl-dev
```

> 提示：`./configure` 构建不成功时会提示缺失的依赖包

### 构建选项

> 暂时构建的选项如下：

| 构建选项                   | 描述                                                                  |
| -------------------------- | --------------------------------------------------------------------- |
| `--prefix=/server/php`     | 指定 php 安装路径                                                     |
| `--enable-fpm`             | 构建 php-fpm 服务                                                     |
| `--enable-mbstring`        | 构建 mbstring 扩展，在 php.ini 文件里启用                             |
| `--with-openssl`           | 构建 openssl 扩展，在 php.ini 文件里启用                              |
| `--with-pcre-jit`          | 正则支持 jit 编译器                                                   |
| `--enable-mysqlnd`         | 构建 mysqlnd 扩展（php 官方写的 mysql 驱动）                          |
| `--with-pdo-mysql`         | 构建 pdo-mysql 扩展（默认使用 mysqlnd 驱动），在 php.ini 文件里启用   |
| `--with-mysqli`            | 构建 mysqli 扩展（默认使用 mysqlnd 驱动），在 php.ini 文件里启用      |
| `--with-curl=/server/curl` | 构建 curl 扩展（只有构建在指定目录下的 curl，php 才能找到指定的文件） |
| `--without-cdb`            | 禁止构建 cdb 扩展（一种数据库管理系统）                               |
| `--without-sqlite3`        | 禁止构建 sqlite3 扩展（一种数据库管理系统）                           |
| `--without-pdo-sqlite`     | 禁止构建 pdo-sqlite 扩展（一种数据库管理系统）                        |

1. 编译安装 curl

   > 由于 apt 安装的 curl 无法找到 php 所需的文件，所以需要我们自己编译安装 curl

   ```shell
   $ cd /data/
   $ wget https://curl.haxx.se/download/curl-7.65.3.tar.gz
   $ tar -xzvf curl-7.65.3.tar.gz
   $ cd curl-7.65.3
   $ mkdir /server/curl
   ```

   > 开始构建&编译&安装：

   ```shell
   $ ./configure --prefix=/server/curl
   $ make -j4
   $ make install
   ```

2. 编译 php：

   > 构建 & 编译 & 安装 php

   ```shell
   $ ../configure --prefix=/server/php \
   --enable-fpm \
   --enable-mbstring \
   --with-openssl \
   --with-pcre-jit \
   --enable-mysqlnd \
   --with-pdo-mysql \
   --with-mysqli \
   --with-curl=/server/curl \
   --without-cdb \
   --without-sqlite3 \
   --without-pdo-sqlite
   $ make -j4
   $ make test
   $ make install
   ```

## 安装额外扩展

> 额外需要安装的几个扩展：

| 扩展                                               | 描述                                                                 |
| -------------------------------------------------- | -------------------------------------------------------------------- |
| [ImageMagic](https://pecl.php.net/package/imagick) | 处理图片的                                                           |
| [xdebug](https://pecl.php.net/package/xdebug)      | xdebug 调试，也可以直接去[官方](https://xdebug.org/download.php)下载 |

### 用 phpize 编译共享 PECL 扩展库

> phpize 命令是用来准备 PHP 扩展库的编译环境的，使用 `phpize --help` 可以查看帮助

- 将 php 二进制文件加入环境变量中:

  > 使用 phpize 前，建议将 php 二进制文件加入环境变量中

  ```shell
  $ cp -p -r /etc/profile{,.bak}
  $ vim /etc/profile
  $ source /etc/profile
  ```

- php 配置文件

  > 使用 phpize 前，必须正确配置 php.ini 文件

  ```shell
  # 开发模式
  $ cp -p -r /data/php-7.3.7/php.ini-development /server/php/lib/php.ini
  # 部署模式
  $ cp -p -r /data/php-7.3.7/php.ini-production /server/php/lib/php.ini
  ```

- 安装 autoconf

  > 使用 phpize 如果出现如下报错，则必须安装 autoconf

  ```text
  Cannot find autoconf. Please check your autoconf installation and the
  $PHP_AUTOCONF environment variable. Then, rerun this script.
  ```

  > 安装 autoconf 及其依赖：

  ```shell
  $ apt install autoconf automake m4
  ```

- php 扩展库路径

  > 在没有指定扩展路径是，默认会出现在如下类似位置：
  >
  > - `/server/php/lib/php/extensions/no-debug-non-zts-20180731/`

- 查看扩展

  > 查看 php 已开启的扩展，最简单的的方法就是：

  ```shell
  $ php -m
  ```

  > 查看 php 的详细情况：

  ```shell
  $ php -r 'phpinfo();'
  ```

### 安装 php 扩展 xdebug

```shell
$ cd /data/
$ wget https://pecl.php.net/get/xdebug-2.7.2.tgz
$ tar -xzvf xdebug-2.7.2.tgz
$ cd xdebug-2.7.2
$ phpize
$ ./configure
$ make -j4
$ make test
$ make install
```

- 修改 php.ini 文件

  ```shell
  $ vim /server/php/lib/php.ini
  ```

- php.ini 文件底部增加如下内容：

  ```ini
  [Xdebug]
  zend_extension=xdebug
  xdebug.profiler_append = 0
  xdebug.profiler_enable = 1
  xdebug.profiler_enable_trigger = 0
  xdebug.profiler_output_dir ="/logs/php/xdebug"
  xdebug.trace_output_dir ="/logs/php/xdebug"
  xdebug.profiler_output_name = "cache.out.%t-%s"
  xdebug.remote_enable = 1
  xdebug.remote_autostart = 1
  xdebug.remote_handler = "dbgp"
  xdebug.remote_host = "127.0.0.1"
  xdebug.idekey= PHPSTROM
  ```

### 安装 php 扩展 imagick

> 安装之前需要自行编译依赖项 `ImageMagick`

- 编译依赖项 `ImageMagick`

  ```shell
  $ cd /data/
  $ wget http://mirror.checkdomain.de/imagemagick/ImageMagick-7.0.8-57.tar.gz
  $ tar -xzvf ImageMagick-7.0.8-57.tar.gz
  $ mkdir /data/ImageMagick-7.0.8-57/ImageMagick_bulld
  $ cd /data/ImageMagick-7.0.8-57/ImageMagick_bulld/
  $ ../configure --prefix=/server/ImageMagick
  $ make -j4
  $ make install
  ```

- 开始编译 php 扩展 `imagick`

  ```shell
  $ cd /data/
  $ wget https://pecl.php.net/get/imagick-3.4.4.tgz
  $ tar -xzvf imagick-3.4.4.tgz
  $ cd imagick-3.4.4
  $ phpize
  $ ./configure --with-imagick=/server/ImageMagick/
  $ make -j4
  $ make test
  $ make install
  ```

- 修改 php.ini 文件

  ```shell
  $ vim /server/php/lib/php.ini
  ```

  > 在 php.ini 文件 `第 940 行左右` 添加如下内容：

  ```ini
  extension=imagick
  ```

## 开启需要的扩展

>
