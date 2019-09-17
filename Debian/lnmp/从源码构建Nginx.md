# 从源码构建 nginx

> Nginx 源码使用 configure 命令配置构建，它定义了系统的各个方面，包括 nginx 允许用于连接处理的方法，最后 configure 会创建一个 Makefile 文件。

## Nginx 构建选项详解

> 这里我基于 nginx-1.16.1 版本的构建选项，做了全面的分析：

| 序号 | configure 选项分类                                                                 |
| ---- | ---------------------------------------------------------------------------------- |
| 00   | [configure 基本选项](../Nginx/configure/00-configure基本选项.md)                   |
| 01   | [I/O 模式相关的构建选项](../Nginx/configure/01-IO模式相关的构建选项.md)            |
| 02   | [设置用户的构建选项](../Nginx/configure/02-设置用户的构建选项.md)                  |
| 03   | [处理进程阻塞的构建选项](../Nginx/configure/03-处理进程阻塞的构建选项.md)          |
| 04   | [http 块默认不安装的构建选项](../Nginx/configure/04-http块默认不安装的构建选项.md) |
| 05   | [http 块允许禁用的构建选项](../Nginx/configure/05-http块允许禁用的构建选项.md)     |
| 06   | [http 块支持 perl 语言](../Nginx/configure/06-http块支持perl语言.md)               |
| 07   | [http 块其它的构建选项](../Nginx/configure/07-http块其它的构建选项.md)             |
| 08   | [禁用 http 块服务的构建选项](../Nginx/configure/08-禁用http块服务的构建选项.md)    |
| 09   | [mail 块相关构建选项](../Nginx/configure/09-mail块相关构建选项.md)                 |
| 10   | [stream 块相关构建选项](../Nginx/configure/10-stream块相关构建选项.md)             |
| 11   | [开发者构建选项](../Nginx/configure/11-开发者构建选项.md)                          |
| 12   | [第三方模块相关构建选项](../Nginx/configure/12-第三方模块相关构建选项.md)          |
| 13   | [不需要考虑的构建选项](../Nginx/configure/13-不需要考虑的构建选项.md)              |
| 14   | [构建 pcre 库选项](../Nginx/configure/14-构建pcre库选项.md)                        |
| 15   | [构建 zlib 库选项](../Nginx/configure/15-构建zlib库选项.md)                        |
| 16   | [构建 libatomic 库选项](../Nginx/configure/16-构建libatomic库选项.md)              |
| 17   | [构建 openssl 库选项](../Nginx/configure/17-构建openssl库选项.md)                  |
| 18   | [调试日志构建选项](../Nginx/configure/18-调试日志构建选项.md)                      |

## 必备安装包准备

> 编译 Nginx 前我们要满足如下表所示的条件：

| 必备         | 操作                                                                            |
| ------------ | ------------------------------------------------------------------------------- |
| 编译环境     | `apt install gcc g++ autotools-dev make`                                        |
| libgd 库     | `apt install libgd-dev`                                                         |
| geoip 库     | `apt install libgeoip-dev`                                                      |
| openssl 库   | [`openssl-1.1.1d.tar.gz`](https://www.openssl.org/source/openssl-1.1.1d.tar.gz) |
| pcre 库      | [`pcre-8.43.tar.gz`](https://ftp.pcre.org/pub/pcre/pcre-8.43.tar.gz)            |
| zlib 库      | [`zlib-1.2.11.tar.gz`](http://zlib.net/zlib-1.2.11.tar.gz)                      |
| nginx 源码包 | [`nginx-1.16.1.tar.gz`](http://nginx.org/download/nginx-1.16.1.tar.gz)          |

> 备注说明：编译 pcre 库 需要 gcc 套件的 c++编译器，也就是 g++

### 下载软件包

```shell
$ wget <urls>
$ tar -xzvf <pkg_name>
```

### 创建必备目录

```shell
$ mkdir -p /server/nginx
$ mkdir /data/nginx-1.16.1/nginx_bulid
$ cd /data/nginx-1.16.1
```

## 部署环境构建

> 可用于部署环境的构建选项（mail 和 stream 模块按需安装）：

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

> 编译并安装：

```shell
# 不需要切换到 --builddir 的目录，还是构建时的目录（configure时的目录）
$ make -j4
$ make install
```

## Nginx 加入开机启动

> Debian10 下面处理开机启动项的方式有很多，我这里就提供`init.d`方案：

1. 首先在 `/etc/init.d` 目录下创建一个 `nginx` 文件：

   ```shell
   $ touch /etc/init.d/nginx
   $ chmod +x /etc/init.d/nginx
   $ vim /etc/init.d/nginx
   ```

2. `/etc/init.d/nginx` 文件内容：

   > [nginx 启动文件](../Nginx/source/init.d.nginx.sh) 这是我测试过的启动文件

3. 将 /etc/init.d/nginx 脚本加入开机自动启动

   ```shell
   # 开启 nginx
   $ /etc/init.d/nginx start
   # 使用 systemctl 启用开机启动
   $ systemctl enable nginx
   # 使用 systemctl 禁用开机启动
   $ /lib/systemd/systemd-sysv-install disable nginx
   ```

> 注意：以后就需要使用 `systemd-sysv-install` 执行了：

| 描述               | 代码                                              |
| ------------------ | ------------------------------------------------- |
| 启用开机启动 nginx | `/lib/systemd/systemd-sysv-install enable nginx`  |
| 禁用开机启动 nginx | `/lib/systemd/systemd-sysv-install disable nginx` |

## Nginx 全局配置

> main 上下文是对 nginx 全局的配置，有下面几点需要关注：

```nginx
{
    ...

    # 一般跟cpu个数相同
    worker_processes 4;
    # 配合worker_processes选项
    worker_cpu_affinity 0001 0010 0100 1000;
    # 如果不加以限制会造成core文件过大，导致磁盘占满
    worker_rlimit_core  50M;
    # 为客户端设置一个超时，超时后 nginx 将尝试强制关闭当前客户端打开的所有连接，保证服务器资源不被占用
    worker_shutdown_timeout 30s;
    # 它主要用于编写 core 文件，工作进程应该具有对指定目录的写权限（/tmp/ 默认为 777 权限）
    working_directory /tmp/;
    # 更改工作进程打开文件的最大数量限制（理论值应该于 `ulimit -n` 相同）
    worker_rlimit_nofile 65535;

    ...
    events{
        # 设置单个 worker 进程能同时打开的最大连接数
        worker_connections 65535;
        # 将 aio 与 epoll 连接处理方法一起使用时，为单个工作进程设置未完成异步 I/O 操作的最大数量。
        worker_aio_requests 10240;
    }
}
```

### ulimit

> 我们可以用 `ulimit -a` 来查看所有限制值：

```shell
[root@Debian10 sites]# ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 40
file size               (blocks, -f) unlimited
pending signals                 (-i) 8041
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1024
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 8041
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited
```

> 其中：`open files (-n) 1024` 是 Linux 操作系统对一个进程打开的文件句柄数量的限制(也包含打开的 SOCKET 数量，可影响 MySQL 的并发连接数目)。

1. 使用 `cat /proc/sys/fs/file-max` 可以查看系统总限制；

2. 在 `/etc/security/limits.conf` 文件里可以修改它（在 windows 分发中没有毛用）：

   > 在最底部加上两句即可：

   ```conf
   * soft  nofile  65535
   * hard  nofile  65535
   ```

   > 也可以仅针对单个用户：

   ```conf
   @nginx soft  nofile  65535
   @nginx hard  nofile  65535
   ```

   > 提示：修改后立即生效，无需重启，只要重新链接下

## Nginx 配置站点

> 下面是一组针对 ThinkPHP 写的站点配置文件：

| 配置文件         | 描述                                                   |
| ---------------- | ------------------------------------------------------ |
| fastcgi 公用配置 | [fastcgi-tp.conf](./../Nginx/source/fastcgi-tp.conf)   |
| 站点配置         | [qyadmin.com.conf](./../Nginx/source/qyadmin.com.conf) |

- 最简单的 php-fpm 站点配置：

```nginx
server {
    listen 80;
    server_name qyadmin.com www.qyadmin.com;
    root /mnt/c/wamp/web/www/qyadmin/public;

    access_log /logs/nginx/access_log/qyadmin.com.log;
    error_log /logs/nginx/error_log/qyadmin.com.log;
    index index.html index.php;

    location / {
        try_files $uri $uri/ /index.php$uri?$query_string;
    }

    location ~ \.php {
        fastcgi_pass  unix:/var/run/php73-fpm.sock;
        fastcgi_index index.php;
        fastcgi_split_path_info  ^(.+\.php)(.*)$;

        include fastcgi-tp.conf;
    }
}
```

> 更多 Nginx 内容请查阅 [man-nginx](../Nginx/README.md)
