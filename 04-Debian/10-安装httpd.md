<!-- TOC START min:1 max:3 link:true asterisk:false update:true -->
- [编译安装](#编译安装)
    - [安装httpd](#安装httpd)
<!-- TOC END -->


# 编译安装

> 本小节主要是用于学习

## 安装httpd

> httpd 及其依赖包地址

```text
httpd
    http://mirrors.tuna.tsinghua.edu.cn/apache//httpd/httpd-2.4.39.tar.bz2
APR
    http://mirror.bit.edu.cn/apache//apr/apr-1.7.0.tar.bz2
expat
    https://github.com/libexpat/libexpat/releases/download/R_2_2_6/expat-2.2.6.tar.bz2
APR-util
    http://mirror.bit.edu.cn/apache//apr/apr-util-1.6.1.tar.bz2
m4
    http://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.bz2
libtool
    http://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.gz
pcre
    ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.43.tar.bz2
```

> 下载并解压 httpd 及其依赖包

```shell
$ mkdir -p /data/source/httpd
$ cd /data/source/httpd
$ wget http://mirrors.tuna.tsinghua.edu.cn/apache/httpd/httpd-2.4.39.tar.bz2
$ wget http://mirror.bit.edu.cn/apache/apr/apr-1.7.0.tar.bz2
$ wget http://mirror.bit.edu.cn/apache/apr/apr-util-1.6.1.tar.bz2
$ wget https://github.com/libexpat/libexpat/releases/download/R_2_2_6/expat-2.2.6.tar.bz2
$ wget http://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.bz2
$ wget http://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.gz
$ wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre2-10.33.tar.bz2

$ tar -xjvf {httpd-2.4.39,apr-1.7.0,expat-2.2.6,apr-util-1.6.1,m4-1.4.18,pcre-8.43}.tar.bz2
$ tar -xzvf libtool-2.4.6.tar.gz
```

> 创建build目录及安装目录

```shell
$ mkdir -p /data/{release,build}/{httpd-2.4.39,apr-1.7.0,expat-2.2.6,apr-util-1.6.1,m4-1.4.18,libtool-2.4.6,pcre-8.43}
```

> 安装 apr

```shell
$ cd /data/build/apr-1.7.0
$ /data/source/httpd/apr-1.7.0/configure
--prefix=/data/release/apr-1.7.0/
$ make -j4
$ make install
$ make clean
```

> 安装 expat（apr-util的依赖项）

```shell
$ /data/source/httpd/expat-2.2.6/configure \
--prefix=/data/release/expat-2.2.6/
$ make -j4
$ make install
$ make clean
```

> 安装 apr-util

```shell
$ cd /data/build/apr-util-1.6.1/
$ /data/source/httpd/apr-util-1.6.1/configure \
--prefix=/data/release/apr-util-1.6.1 \
--with-apr=/data/release/apr-1.7.0 \
--with-expat=/data/release/expat-2.2.6
$ make -j4
$ make install
$ make clean
```

> 安装 m4（libtool 的依赖项）

```shell
$ cd /data/build/m4-1.4.18/
$ /data/source/httpd/m4-1.4.18/configure \
--prefix=/data/release/m4-1.4.18
$ make -j4
$ make install
$ make clean
```

=========================================
还未安装完成

> 安装 libtool（pcre 的依赖项）

```shell
$ cd /data/build/libtool-2.4.6/
$ /data/source/httpd/libtool-2.4.6/configure \
--prefix=/data/release/libtool-2.4.6 \
--with-m4=/data/release/m4-1.4.18
$ make -j4
$ make install
$ make clean
```

> 安装 pcre（gcc编译套件需安装c++库）

```shell
$ cd /data/build/pcre-8.43/
$ /data/source/httpd/pcre-8.43/configure \
--prefix=/data/release/pcre-8.43
$ make -j4
$ make install
$ make clean
```

> 安装 apr-util

```shell
$ cd /data/build/httpd-2.4.39/
$ /data/source/httpd/httpd-2.4.39/configure \
--prefix=/data/release/httpd-2.4.39 \
--with-apr=/data/release/apr-1.7.0 \
--with-apr-util=/data/release/apr-util-1.6.1 \
--with-pcre=/data/release/pcre2-10.33/bin/pcre2-config
$ make -j4
$ make install
$ make clean
```

> 安装 httpd
