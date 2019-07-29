# Nginx 之 http 块指令

> 官方手册上对 http 块指令写出了 58 个模块，具体如下：

1. 默认安装的模块

   > 这些模块在编译 Nginx 时就会自动安装的：

   | 模块                                                                     | 描述                                                                                                                 |
   | ------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------- |
   | [ngx_http_core_module](./http/ngx_http_core_module.md)                   | http 块指令基础模块                                                                                                  |
   | [ngx_http_access_module](./http/ngx_http_access_module.md)               | 限制对某些客户端地址的访问                                                                                           |
   | [ngx_http_api_module](./http/ngx_http_api_module.md)                     | 提供 REST API 访问的各种状态信息                                                                                     |
   | [ngx_http_auth_basic_module](./http/ngx_http_auth_basic_module).md       | 限制对资源的访问                                                                                                     |
   | [ngx_http_auth_jwt_module](./http/ngx_http_auth_jwt_module).md           | 验证客户端                                                                                                           |
   | [ngx_http_autoindex_module](./http/ngx_http_autoindex_module).md         | 处理以斜杠字符（'/'）结尾的请求，并生成目录列表                                                                      |
   | [ngx_http_browser_module](./http/ngx_http_browser_module).md             | 用于声明浏览器类型                                                                                                   |
   | [ngx_http_charset_module](./http/ngx_http_charset_module).md             | 该模块可以将数据从一个字符集转换为另一个字符集，但有一些限制                                                         |
   | [ngx_http_empty_gif_module](./http/ngx_http_empty_gif_module).md         | 默认安装                                                                                                             |
   | ~~ngx_http_f4f_module~~                                                  | 为 Adobe HTTP 动态流（HDS）提供服务器端支持                                                                          |
   | [ngx_http_fastcgi_module](./http/ngx_http_fastcgi_module).md             | 允许将请求传递给 FastCGI 服务器                                                                                      |
   | [ngx_http_geo_module](./http/ngx_http_geo_module).md                     | 根据客户机 IP 地址的值创建的变量                                                                                     |
   | ~~ngx_http_grpc_module~~                                                 | 允许将请求传递给 gRPC 服务器                                                                                         |
   | [ngx_http_gzip_module](./http/ngx_http_gzip_module).md                   | 是一个使用“gzip”方法压缩响应的过滤器                                                                                 |
   | [ngx_http_headers_module](./http/ngx_http_headers_module).md             | 允许将“Expires”和“Cache-Control”头字段以及任意字段添加到响应头                                                       |
   | ~~ngx_http_hls_module~~                                                  | 为 MP4 和 MOV 媒体文件提供 HTTP 实时流（HLS）服务器端支持                                                            |
   | [ngx_http_index_module](./http/ngx_http_index_module).md                 | 也是处理以斜杠字符（'/'）结尾的请求                                                                                  |
   | [ngx_http_keyval_module](./http/ngx_http_keyval_module).md               | 创建的变量的值取自 API 管理的键值对                                                                                  |
   | [ngx_http_limit_conn_module](./http/ngx_http_limit_conn_module).md       | 用于限制每个定义密钥的连接数                                                                                         |
   | [ngx_http_limit_req_module](./http/ngx_http_limit_req_module).md         | 用于限制每一个定义的密钥的请求的处理速率                                                                             |
   | [ngx_http_log_module](./http/ngx_http_log_module).md                     | 以指定的格式写入请求日志                                                                                             |
   | [ngx_http_map_module](./http/ngx_http_map_module).md                     | 创建的变量的值取决于其他变量的值                                                                                     |
   | [ngx_http_memcached_module](./http/ngx_http_memcached_module).md         | 用于从 memcached 服务器获取响应                                                                                      |
   | [ngx_http_mirror_module](./http/ngx_http_mirror_module).md               | 通过创建后台镜像子请求来实现原始请求的镜像，忽略对镜像子请求的响应                                                   |
   | ~~ngx_http_mp4_module~~                                                  | 为 MP4 文件提供伪流服务器端支持                                                                                      |
   | [ngx_http_proxy_module](./http/ngx_http_proxy_module).md                 | 允许将请求传递到另一台服务器                                                                                         |
   | [ngx_http_referer_module](./http/ngx_http_referer_module).md             | 用于阻止对“Referer”头字段中具有无效值的请求访问站点                                                                  |
   | [ngx_http_rewrite_module](./http/ngx_http_rewrite_module).md             | 用于使用 PCRE 正则表达式更改请求 URI，返回重定向，并有条件地选择配置                                                 |
   | ~~ngx_http_scgi_module~~                                                 | 允许将请求传递给 SCGI 服务器                                                                                         |
   | [ngx_http_secure_link_module](./http/ngx_http_secure_link_module).md     | 用于检查请求链路的真实性，保护资源免受未经授权的访问，以及限制链路生存期                                             |
   | [ngx_http_session_log_module](./http/ngx_http_session_log_module).md     | 启用日志记录会话（即多个 HTTP 请求的聚合），而不是单个 HTTP 请求                                                     |
   | [ngx_http_split_clients_module](./http/ngx_http_split_clients_module).md | 创建适合 A/B 测试的变量，也称为分割测试                                                                              |
   | ~~ngx_http_ssi_module~~                                                  | 是一个过滤器，用于处理通过它的响应中的 SSI（服务器端包含）命令                                                       |
   | [ngx_http_upstream_module](./http/ngx_http_upstream_module).md           | 用于定义可由 proxy_pass ， fastcgi_pass ， uwsgi_pass ， scgi_pass ， memcached_pass 和 grpc_pass 指令引用的服务器组 |
   | [ngx_http_upstream_hc_module](./http/ngx_http_upstream_hc_module).md     | 允许对周围位置引用的 group 中的服务器启用定期运行状况检查。默认安装                                                  |
   | [ngx_http_userid_module](./http/ngx_http_userid_module).md               | 设置适合客户识别的 cookie                                                                                            |
   | ~~ngx_http_uwsgi_module~~                                                | 允许将请求传递给 uwsgi 服务器                                                                                        |

2. 支持构建的模块

   > 这部分模块并不会随着 Nginx 自动安装，但是已经存在于 Nginx 源码中，Nginx 加上选项即可安装

   | 模块                                                                   | 构建选项                          | 描述                                                                      |
   | ---------------------------------------------------------------------- | --------------------------------- | ------------------------------------------------------------------------- |
   | ~~[ngx_http_addition_module](./http/ngx_http_addition_module).md~~     | `--with-http_addition_module`     | 过滤器模块                                                                |
   | [ngx_http_auth_request_module](./http/ngx_http_auth_request_module).md | `--with-http_auth_request_module` | 基于子请求的结果来对客户端授权                                            |
   | [ngx_http_dav_module](./http/ngx_http_dav_module).md                   | `--with-http_dav_module`          | 处理 HTTP、处理 WebDAV 部分方法（PUT、DELETE、MKCOL、COPY 和 MOVE）       |
   | ~~ngx_http_flv_module~~                                                | `--with-http_flv_module`          | 为 Flash Video（FLV）文件提供伪流服务器端支持，                           |
   | [ngx_http_geoip_module](./http/ngx_http_geoip_module).md               | `--with-http_geoip_module`        | 根据客户端 IP 地址的值创建的变量，                                        |
   | [ngx_http_gunzip_module](./http/ngx_http_gunzip_module).md             | `--with-http_gunzip_module`       | 是一个过滤器 Nginx                                                        |
   | [ngx_http_gzip_static_module](./http/ngx_http_gzip_static_module).md   | `--with-http_gzip_static_module`  | 允许使用“.gz”文件扩展名而不是常规文件发送预压缩文件，                     |
   | [ngx_http_image_filter_module](./http/ngx_http_image_filter_module).md | `--with-http_image_filter_module` | 是一个过滤器，可以转换 JPEG，GIF，PNG 和 WebP 格式的图像，                |
   | [ngx_http_perl_module](./http/ngx_http_perl_module).md                 | `--with-http_perl_module`         | 用于在 Perl 中实现位置和变量处理程序，并将 Perl 调用插入到 SSI 中。       |
   | [ngx_http_random_index_module](./http/ngx_http_random_index_module).md | `--with-http_random_index_module` | 处理以斜杠字符（'/'）结尾的请求，并在目录中选择一个随机文件作为索引文件， |
   | [ngx_http_realip_module](./http/ngx_http_realip_module).md             | `--with-http_realip_module`       | 用于将客户端地址和可选端口更改为在指定的头字段中发送的端口，              |
   | [ngx_http_slice_module](./http/ngx_http_slice_module).md               | `--with-http_slice_module`        | 一个过滤器，它将请求拆分为子请求，每个子请求都返回一定范围的响应，        |
   | [ngx_http_ssl_module](./http/ngx_http_ssl_module).md                   | `--with-http_ssl_module`          | 为 HTTPS 提供必要的支持，                                                 |
   | [ngx_http_stub_status_module](./http/ngx_http_stub_status_module).md   | `--with-http_stub_status_module`  | 提供对基本状态信息的访问。                                                |
   | [ngx_http_sub_module](./http/ngx_http_sub_module).md                   | `--with-http_sub_module`          | 一个过滤器，它通过将一个指定的字符串替换为另一个来修改响应。              |
   | [ngx_http_v2_module](./http/ngx_http_v2_module).md                     | `--with-http_v2_module`           | 支持 HTTP/2 并取代 ngx_http_spdy_module 模块                              |
   | ~~ngx_http_xslt_module~~                                               | `--with-http_xslt_module`         | 是一个过滤器，使用一个或多个 XSLT 样式表转换 XML 响应。                   |

3. 需要自行安装

   > 这部分模块，在 Nginx 找不到对应源码，需要去官网下载源码包，然后编译

   | 模块                   | 描述                                              |
   | ---------------------- | ------------------------------------------------- |
   | ~~ngx_http_js_module~~ | 用于在 njs 中实现位置和变量处理程序，需要另外安装 |

4. 被替代的模块

   > 通常这些模块已经被新模块替代，因为新模块比它们更加优秀

   | 模块                              | 构建选项                                 | 描述                                             |
   | --------------------------------- | ---------------------------------------- | ------------------------------------------------ |
   | ~~ngx_http_spdy_module~~          | 1.9.5 版本后被`ngx_http_v2_module`取代   | 为 SPDY 提供实验支持                             |
   | ~~ngx_http_upstream_conf_module~~ | 1.13.3 版本后被`ngx_http_api_module`取代 | 模块允许通过简单的 HTTP 接口即时配置上游服务器组 |
   | ~~ngx_http_status_module~~        | 1.13.3 版本后被`ngx_http_api_module`取代 | 提供对各种状态信息的访问                         |
