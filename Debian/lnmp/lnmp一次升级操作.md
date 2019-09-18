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
