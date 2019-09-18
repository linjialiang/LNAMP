# lnmp 一次升级操作

> 我在 wsl 上安装的 lnmp 运行了几个月时间，现在有很多包都更新了，现在我们就来做一次全面的升级操作！

## 升级 wsl 子系统

> 第一步，我们应该先升级系统

```shell
$ apt update
$ apt upgrade       # 小版本更新方式
$ apt dist-upgrade  # 大版本更新方式
```

更新完系统后，我们会发现 mariadb 已经更新到了最新版本 `10.4.8`

## 更新 nginx

> 注意：下载和解压缩等操作这里会直接省略，详情请查阅源码安装章节！

### 步骤说明：

```text
1. 先解压依赖库，本次只需解压 openssl-1.1.1d.tar.gz 即可，其它依赖库没有更新；
2. 解压nginx源码包，nginx-1.16.1.tar.gz
3. 开始编译 Nginx 新版本（只编译，不安装）
4. 平滑升级
```

### 编译新版 Nginx

> 创建编译目录

```shell
$ mkdir /data/nginx-1.16.1/nginx_bulid
$ cd /data/nginx-1.16.1
```

> 新版 Nginx 构建选项：

```shell
./configure --prefix=/server/nginx \
--builddir=/data/nginx-1.16.1/nginx_bulid \
--with-threads \
--with-file-aio \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_realip_module \
--with-http_image_filter_module \
--with-http_geoip_module \
--with-http_dav_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_auth_request_module \
--with-http_secure_link_module \
--with-http_degradation_module \
--with-http_slice_module \
--with-http_stub_status_module \
--without-http_ssi_module \
--without-http_uwsgi_module \
--without-http_scgi_module \
--without-http_grpc_module \
--with-mail \
--with-mail_ssl_module \
--with-stream \
--with-stream_ssl_module \
--with-stream_realip_module \
--with-stream_geoip_module \
--with-stream_ssl_preread_module \
--with-pcre=/data/pcre-8.43 \
--with-pcre-jit \
--with-zlib=/data/zlib-1.2.11 \
--with-openssl=/data/openssl-1.1.1d \
--with-debug
```

> 编译新版 Nginx

```shell
$ make -j4
```

### 升级 Nginx 版本

> 将刚刚编译后产生的文件，拷贝到 `/server/nginx/sbin` 下：

```shell
$ cp -p -r /data/nginx-1.16.1/nginx_bulid/nginx /server/nginx/sbin/
```

> 重启 nginx

```shell
$ /server/nginx/sbin/nginx -s stop
$ /server/nginx/sbin/nginx
```

> 提示：如果需要平滑升级，请查阅[Nginx 平滑升级](./../Nginx/03-Nginx平滑升级.md)

## 升级 php

> 升级 php 前可能需要先升级依赖库，具体步骤如下：

```text
1. 升级 curl 至 curl-7.66.0.tar.gz
2. 编译php新版本
3. 无缝升级操作
```

### 升级 curl

> 直接覆盖原先的，或者直接删除 `/server/curl` 数据，具体操作如下：

```
$ cd /data/curl-7.66.0
$ ./configure --prefix=/server/curl
$ make -j4
$ make install
```

### 编译安装新版 php

我这里的 php 没有必须要保存的文件，如果有需要保存的配置文件啥的，就应该要先保存好，在编译安装

> 构建 & 编译 & 安装 php

```shell
$ cd /data/php-7.3.9/php_build
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

> 配置 php.ini 文件

```shell
$ cp -p -r /data/php-7.3.9/php.ini-development /server/php/lib/php.ini
```

### php 扩展

我们之前为 php 安装了两个额外扩展，这两个扩展没有更新，因此只需在 php.ini 上加入即可。

> 提示：加入比较简单，详情清查阅 [从源码构建 PHP](./从源码构建PHP.md)

### 更新 ImageMagick

php 扩展 imagick 虽然没有更新，但是它的依赖包 ImageMagick 却有更新，这里我们也更新下 ImageMagick

```shell
$ mkdir /data/ImageMagick-7.0.8-64/ImageMagick_bulld
$ cd /data/ImageMagick-7.0.8-64/ImageMagick_bulld/
$ ../configure --prefix=/server/ImageMagick
$ make -j4
$ make install
```
