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

> 具体操作：

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

> php 自身提供的 `phpize` 程序可以安装额外扩展
