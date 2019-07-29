# Nginx 平滑升级

> nginx 支持在不允许客户端正常访问的情况下，升级 nginx 版本，下面我们就来具体操作下：

## 准备工作

> 在升级 Nginx 前，我们需要作如下准备：

| 准备工作                  | 描述                                                                   |
| ------------------------- | ---------------------------------------------------------------------- |
| 备份旧版 Nginx 可执行文件 | 如果升级出了状况，我们可以回滚到就版本                                 |
| 旧版 Nginx 的构建选项     | `nginx -V`                                                             |
| 下载 Nginx 新版本         | [`nginx-1.17.1.tar.gz`](http://nginx.org/download/nginx-1.17.1.tar.gz) |

### 几点注意事项：

1. 新版的构建选项与旧版的构建选项基本保持一致，不过有些路径就需要自己重新指定到正确的位置；
2. 新版本我们只处理到编译部分，不能安装，否则就无法做到平滑升级，之前的配置都会被覆盖掉。

### 具体操作

> 准备工作的具体操作：

1. 备份 Nginx 可执行文件

   ```sehll
   $ mv /server/nginx/sbin/nginx{,.bak}
   ```

2. 查看旧版 Nginx 的构建选项

   ```shell
   $ /server/nginx/sbin/nginx -V
   nginx version: nginx/1.16.0
   built by gcc 8.3.0 (Debian 8.3.0-6)
   built with OpenSSL 1.1.1c  28 May 2019
   TLS SNI support enabled
   configure arguments: --prefix=/server/nginx --builddir=/data/nginx-1.16.0/nginx_bulid --with-threads --with-file-aio --with-http_ssl_module --with-http_v2_module --with-http_realip_module --with-http_image_filter_module --with-http_geoip_module --with-http_dav_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_auth_request_module --with-http_secure_link_module --with-http_degradation_module --with-http_slice_module --with-http_stub_status_module --without-http_ssi_module --without-http_uwsgi_module --without-http_scgi_module --without-http_grpc_module --with-mail --with-mail_ssl_module --with-stream --with-stream_ssl_module --with-stream_realip_module --with-stream_geoip_module --with-stream_ssl_preread_module --with-pcre=/data/pcre-8.43 --with-pcre-jit --with-zlib=/data/zlib-1.2.11 --with-openssl=/data/openssl-1.1.1c --with-debug
   ```

   > 其中，需要指定正确路径的选项：

   | 选项              | 正确路径                         |
   | ----------------- | -------------------------------- |
   | `--builddir=`     | `/data/nginx-1.17.1/nginx_bulid` |
   | `--with-pcre=`    | 路径要指向当前正确路径           |
   | `--with-zlib=`    | 路径要指向当前正确路径           |
   | `--with-openssl=` | 路径要指向当前正确路径           |

3. 下载并解压新版 Nginx

   ```shell
   $ cd /data
   $ wget http://nginx.org/download/nginx-1.17.1.tar.gz
   $ tar -xzvf nginx-1.17.1.tar.gz
   ```

## 编译新版本

> 下面开始编译 Nginx 新版本（只编译，不安装）：

```shell
$ mkdir /data/nginx-1.17.1/nginx_bulid
$ cd /data/nginx-1.17.1
```

> 新版 Nginx 构建选项：

```shell
./configure --prefix=/server/nginx \
--builddir=/data/nginx-1.17.1/nginx_bulid \
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
--with-openssl=/data/openssl-1.1.1c \
--with-debug
```

> 编译新版 Nginx

```shell
$ make -j4
```

## 升级 Nginx 版本

> 将刚刚编译后产生的文件，拷贝到 `/server/nginx/sbin` 下：

```shell
$ cp -p -r /data/nginx-1.17.1/nginx_bulid/nginx /server/nginx/sbin/
```

> 查看当前的Nginx版本：

```shell
$ /server/nginx/sbin/nginx -v
nginx version: nginx/1.17.1
```

## 信号控制平滑升级

> 使用信号控制 Nginx 平滑升级

### 主进程信号：

> Nginx 主进程支持的 kill 信号：

| 信号      | 描述                                                                                                          |
| --------- | ------------------------------------------------------------------------------------------------------------- |
| TERM, INT | 快速关机                                                                                                      |
| QUIT      | 优雅的关机                                                                                                    |
| HUP       | 更改配置，跟上更改的时区（仅适用于 FreeBSD 和 Linux），使用新配置启动新的 worker 进程，正常关闭旧 worker 进程 |
| USR1      | 重新打开日志文件                                                                                              |
| USR2      | 升级可执行文件                                                                                                |
| WINCH     | 正常关闭 Nginx 主进程                                                                                         |

> Nginx `worker 进程`支持的 kill 信号：

| 信号      | 描述                 |
| --------- | -------------------- |
| TERM, INT | 快速关机             |
| QUIT      | 优雅的关机           |
| USR1      | 重新打开日志文件     |
| WINCH     | 正常关闭 worker 进程 |

### 升级可执行文件

> 使用 `kill -USR2 <pid>` 来升级 Nginx 可执行文件

1. 直接使用 cat 读取 nginx.pid 的值

   ```shell
   $ kill -USR2 `cat /server/nginx/logs/nginx.pid`
   ```

2. 使用 ps 查看 Nginx 的主进程 id：

   ```shell
   $ ps -ef|grep nginx
   root      4337     1  0 14:12 ?        00:00:00 nginx: master process /server/nginx/sbin/nginx
   nobody    4338  4337  0 14:12 ?        00:00:00 nginx: worker process
   root     21404   622  0 15:54 pts/0    00:00:00 grep nginx
   $ kill -USR2 4337
   ```

3. 升级可执行文件后的效果：

   > 发下现在有两个 Nginx 主进程，旧版 Nginx 主进程依然还在：

   ```shell
   $ ps -ef|grep nginx
   root      4337     1  0 14:12 ?        00:00:00 nginx: master process /server/nginx/sbin/nginx
   nobody    4338  4337  0 14:12 ?        00:00:00 nginx: worker process
   root     21409  4337  0 16:05 ?        00:00:00 nginx: master process /server/nginx/sbin/nginx
   nobody   21410 21409  0 16:05 ?        00:00:00 nginx: worker process
   root     21412   622  0 16:05 pts/0    00:00:00 grep nginx
   ```

   > 查看下 nginx.pid 下记录的 pid 值：

   ```shell
   $ cat /server/nginx/logs/nginx.pid
   21409
   ```

   > 这里可以清晰的告诉我们，主进程的 pid 已经是新版 Nginx 的了

### 关闭旧的主进程

> 使用 `kill -WINCH <pid>` 来正常关闭旧版 Nginx 的主进程

```shell
$ kill -WINCH 4337
```
