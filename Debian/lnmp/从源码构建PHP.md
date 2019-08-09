# 安装 PHP

> php 最好还是编译，这样可以按自己需求构建扩展

## 构建前的准备

> 下载和解压 php7.3.8

```shell
$ mkdir /server/php
$ cd /data/
$ wget https://www.php.net/distributions/php-7.3.8.tar.gz
$ tar -xzvf php-7.3.8.tar.gz
$ mkdir /data/php-7.3.8/php_build
$ cd /data/php-7.3.8/php_build
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
   $ cd /data/php-7.3.8/php_build
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

## php-config 命令行工具

> php-config 是一个简单的命令行脚本用于获取所安装的 PHP 配置的信息。使用 `-h` 来查看：

```shell
$ php-config -h
```

> 提示： 在编译扩展时，如果安装有多个 PHP 版本，可以在配置时用 `--with-php-config` 选项来指定使用哪一个版本编译，该选项指定了相对应的 php-config 脚本的路径。

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
  ```

  ```conf
  # /etc/profile 底部增加一行
  export PATH=$PATH:/server/php/bin:/server/php/sbin
  ```

  ```shell
  $ source /etc/profile
  ```

- php 配置文件

  > 使用 phpize 前，必须正确配置 php.ini 文件

  ```shell
  # 使用 php --ini 查询php配置文件的情况
  $ php --ini
  # 开发模式
  $ cp -p -r /data/php-7.3.8/php.ini-development /server/php/lib/php.ini
  # 部署模式
  $ cp -p -r /data/php-7.3.8/php.ini-production /server/php/lib/php.ini
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
$ mkdir /data/ext/
$ cd /data/ext/
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
  $ mkdir /server/ImageMagick
  $ cd /data/
  $ wget http://mirror.checkdomain.de/imagemagick/ImageMagick-7.0.8-59.tar.gz
  $ tar -xzvf ImageMagick-7.0.8-59.tar.gz
  $ mkdir /data/ImageMagick-7.0.8-59/ImageMagick_bulld
  $ cd /data/ImageMagick-7.0.8-59/ImageMagick_bulld/
  $ ../configure --prefix=/server/ImageMagick
  $ make -j4
  $ make install
  ```

- 开始编译 php 扩展 `imagick`

  ```shell
  $ cd /data/ext
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

## 开启与禁用扩展库

> php 扩展库有两种：

| 库分类 | 描述                                            | 操作方式          |
| ------ | ----------------------------------------------- | ----------------- |
| 静态库 | 构建 php 时，默认安装或者添加了构建选项安装的库 | 重新编译 php      |
| 动态库 | 后期使用 phpize 安装的                          | 通过 php.ini 控制 |

- 启用 php 动态库

  1. 通过 phpize 安装动态库

  2. 通过 php.ini 添加 `extension=<库名>` 或者 `zend_extension=<库名>`

- 禁用动态扩展库

  1. 通过 php.ini ，找到对应的扩展库名，并在前面加上`;` 如：

     > `;extension=imagick`

## 开启 php-fpm 服务

> 配置 php-fpm 以及 开机启动 php_fpm 服务

### 配置 `php-fpm`

> 两个重要的配置文件：

| 进程      | 对应配置文件       | 数量         |
| --------- | ------------------ | ------------ |
| 主进程    | `php-fpm.conf`     | 仅有一个     |
| pool 进程 | `php-fpm.d/*.conf` | 可以拥有多个 |

```shell
$ cp -p -r /server/php/etc/php-fpm.conf{.default,}
$ cp -p -r /server/php/etc/php-fpm.d/www.conf{.default,}
```

> 如果没有特别指明，都是在 www 工作池对应的配置文件中修改

- 为 www 工作池指定用户及用户组

  > 跟 nginx 的用户及用户组一致即可

  ```shell
  $ groupadd -g 2000 nginx
  $ useradd -c 'Users of the Nginx service and php-fpm service' -u 2000 -s /usr/sbin/nologin -d /home/nginx -m -g nginx nginx
  $ vim /server/php/etc/php-fpm.d/www.conf
  ```

  > 指定用户级用户组，并指定监听用户和监听用户组：

  ```conf
  ...
  # user = nobody
  # group = nobody
  user = nginx
  group = nginx
  ...
  listen.owner = nginx
  listen.group = ningx
  ...
  ```

- 监听端口

  > 如果选择 TCP 端口监听，默认值已经设置了，一般我们不需要修改！

- 监听形式

  > 默认是以 TCP 端口监听的，我们也可以修改成 `在unix套接字上监听`，具体操作如下：

  ```shell
  $ mkdir /var/run/php/
  ```

  ```conf
  ...
  ;listen = 127.0.0.1:9000
  listen = /var/run/php/php73-fpm.sock
  ...
  ```

### 开机启动 php-fpm

> php 做的很好，编译时就将启动文件生成到构建目录里了。

- 进入构建目录：

  ```shell
  cd /data/php-7.3.8/php_build/sapi/fpm
  ```

  > 两个启动项相关文件：

  | 开机启动项        | init 启动文件    |
  | ----------------- | ---------------- |
  | `php-fpm.service` | `init.d.php-fpm` |

- init 启动具体操作：

  ```shell
  # 拷贝到 init.d 目录
  $ cp init.d.php-fpm /etc/init.d/php-fpm
  # 杀死之前打开的nginx进程，init的才能正常使用，否则pid冲突
  $ ps -ef | grep php-fpm
  $ kill -9 pid
  $ /etc/init.d/php-fpm {start|reload|stop|status}
  ```

- 开机启动具体操作

  > systemctl 可以将 init.d 上的启动脚本设置为开机启动

  ```shell
  # 首先使用 init 启动 php-fpm：
  $ /etc/init.d/php-fpm start
  # 开机启动
  $ systemctl enable php-fpm
  # 禁用开机启动
  $ systemctl disable php-fpm
  ```

  > 提示：在 debian9 上禁用开机启动，需要使用：
  >
  > - `/lib/systemd/systemd-sysv-install disable php-fpm`

## 附录：

1. Linux 子系统启动报错：

   > 如果 PHP-fmp 是以 TCP 监听就会发生下面的错误

   ```shell
   failed to retrieve TCP_INFO for socket: Protocol not available (92)
   ```

   > 解决：修改 `php-fpm.conf` 文件，设置 `log_level = alert` (治标不治本)
