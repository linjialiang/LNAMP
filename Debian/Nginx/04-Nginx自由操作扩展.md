# Nginx 自由操作扩展

> 安装成功的 Nginx，后期我们可以自由的对扩展进行扩充和禁用，操作跟 Nginx 平滑升级基本是一致的：：

1. 操作原理解释：

   > 对于默认不安装的扩展：

   | 开启扩展 | 在构建时将`--with_扩展名`添加即可   |
   | -------- | ----------------------------------- |
   | 禁用扩展 | 在构建时将 `--with_扩展名` 移除即可 |

   > 对于默认会安装的扩展：

   | 开启扩展 | 在构建时将`--without_扩展名`移除即可   |
   | -------- | -------------------------------------- |
   | 禁用扩展 | 在构建时将 `--without_扩展名` 添加即可 |

   > 对于第三方扩展：

   | 开启扩展 | 在 `--add-module=<第三方扩展目录>` 指定的目录中将该扩展源码移除即可 |
   | -------- | ------------------------------------------------------------------- |
   | 禁用扩展 | 在 `--add-module=<第三方扩展目录>` 指定的目录中将该扩展源码增加即可 |

2. 确认哪些扩展需要启用，哪些扩展需要禁用：

   | 扩展                 | 是否开启             |
   | -------------------- | -------------------- |
   | ngx_http_v2_module   | 需要从开启状态禁用掉 |
   | ngx_http_scgi_module | 需要从禁用状态开启   |

3. 接下来的操作跟 Nginx 平滑升级没有什么区别

## 构建选项

```shell
$ ./configure --prefix=/server/nginx \
--builddir=/data/nginx-1.17.1/nginx_bulid \
--with-threads \
--with-file-aio \
--with-http_ssl_module \
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

## 编译

> 记住：只编译，不安装

```shell
$ make -j4
```

## 平滑升级

> 具体操作查看 [Nginx 平滑升级](./03-Nginx平滑升级.md)
