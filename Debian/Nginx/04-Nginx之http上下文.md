# Nginx 之 http 上下文

> 官方手册上对 http 上下文写出了 58 个模块，具体如下：

| 模块                          | 描述                                                                                                                       |
| ----------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| ngx_http_core_module          | http 基础模块，默认安装                                                                                                    |
| ngx_http_access_module        | 限制对某些客户端地址的访问，默认安装                                                                                       |
| ngx_http_addition_module      | 过滤器模块，使用 `--with-http_addition_module` 构建 Nginx                                                                  |
| ngx_http_api_module           | 提供 REST API 访问的各种状态信息，默认安装                                                                                 |
| ngx_http_auth_basic_module    | 限制对资源的访问，默认安装                                                                                                 |
| ngx_http_auth_jwt_module      | 验证客户端，默认安装                                                                                                       |
| ngx_http_auth_request_module  | 基于子请求的结果来对客户端授权，使用 `--with-http_auth_request_module` 构建 Nginx                                          |
| ngx_http_autoindex_module     | 处理以斜杠字符（'/'）结尾的请求，并生成目录列表，默认安装 ，默认安装                                                       |
| ngx_http_browser_module       | 用于声明浏览器类型，默认安装                                                                                               |
| ngx_http_charset_module       | 该模块可以将数据从一个字符集转换为另一个字符集，但有一些限制                                                               |
| ngx_http_dav_module           | 处理 HTTP 和 WebDAV 的部分方法，使用 `--with-http_dav_module` 构建 Nginx                                                   |
| ngx_http_empty_gif_module     | 默认安装                                                                                                                   |
| ngx_http_f4f_module           | 为 Adobe HTTP 动态流（HDS）提供服务器端支持，默认安装                                                                      |
| ngx_http_fastcgi_module       | 允许将请求传递给 FastCGI 服务器，默认安装                                                                                  |
| ngx_http_flv_module           | 为 Flash Video（FLV）文件提供伪流服务器端支持，使用 `--with-http_flv_module` 构建 Nginx                                    |
| ngx_http_geo_module           | 根据客户机 IP 地址的值创建的变量，默认安装                                                                                 |
| ngx_http_geoip_module         | 根据客户端 IP 地址的值创建的变量，使用 `--with-http_geoip_module` 构建 Nginx                                               |
| ngx_http_grpc_module          | 允许将请求传递给 gRPC 服务器                                                                                               |
| ngx_http_gunzip_module        | 是一个过滤器，使用 `--with-http_gunzip_module` 构建 Nginx                                                                  |
| ngx_http_gzip_module          | 是一个使用“gzip”方法压缩响应的过滤器，默认安装                                                                             |
| ngx_http_gzip_static_module   | 允许使用“.gz”文件扩展名而不是常规文件发送预压缩文件，使用 `--with-http_gzip_static_module` 构建 Nginx                      |
| ngx_http_headers_module       | 允许将“Expires”和“Cache-Control”头字段以及任意字段添加到响应头，默认安装                                                   |
| ngx_http_hls_module           | 为 MP4 和 MOV 媒体文件提供 HTTP 实时流（HLS）服务器端支持，默认安装                                                        |
| ngx_http_image_filter_module  | 是一个过滤器，可以转换 JPEG，GIF，PNG 和 WebP 格式的图像，使用 `--with-http_image_filter_module` 构建 Nginx                |
| ngx_http_index_module         | 也是处理以斜杠字符（'/'）结尾的请求，默认安装                                                                              |
| ngx_http_js_module            | 用于在 njs 中实现位置和变量处理程序，需要另外安装                                                                          |
| ngx_http_keyval_module        | 创建的变量的值取自 API 管理的键值对，默认安装                                                                              |
| ngx_http_limit_conn_module    | 用于限制每个定义密钥的连接数，默认安装                                                                                     |
| ngx_http_limit_req_module     | 用于限制每一个定义的密钥的请求的处理速率，默认安装                                                                         |
| ngx_http_log_module           | 以指定的格式写入请求日志，默认安装                                                                                         |
| ngx_http_map_module           | 创建的变量的值取决于其他变量的值，默认安装                                                                                 |
| ngx_http_memcached_module     | 用于从 memcached 服务器获取响应，默认安装                                                                                  |
| ngx_http_mirror_module        | 通过创建后台镜像子请求来实现原始请求的镜像，忽略对镜像子请求的响应，默认安装                                               |
| ngx_http_mp4_module           | 为 MP4 文件提供伪流服务器端支持，默认安装                                                                                  |
| ngx_http_perl_module          | 用于在 Perl 中实现位置和变量处理程序，并将 Perl 调用插入到 SSI 中。使用 `--with-http_perl_module` 构建 Nginx               |
| ngx_http_proxy_module         | 允许将请求传递到另一台服务器，默认安装                                                                                     |
| ngx_http_random_index_module  | 处理以斜杠字符（'/'）结尾的请求，并在目录中选择一个随机文件作为索引文件，使用 `--with-http_random_index_module` 构建 Nginx |
| ngx_http_realip_module        | 用于将客户端地址和可选端口更改为在指定的头字段中发送的端口，使用 `--with-http_realip_module` 构建 Nginx                    |
| ngx_http_referer_module       | 用于阻止对“Referer”头字段中具有无效值的请求访问站点，默认安装                                                              |
| ngx_http_rewrite_module       | 用于使用 PCRE 正则表达式更改请求 URI，返回重定向，并有条件地选择配置，默认安装                                             |
| ngx_http_scgi_module          | 允许将请求传递给 SCGI 服务器，默认安装                                                                                     |
| ngx_http_secure_link_module   | 用于检查请求链路的真实性，保护资源免受未经授权的访问，以及限制链路生存期，默认安装                                         |
| ngx_http_session_log_module   | 启用日志记录会话（即多个 HTTP 请求的聚合），而不是单个 HTTP 请求，默认安装                                                 |
| ngx_http_slice_module         | 一个过滤器，它将请求拆分为子请求，每个子请求都返回一定范围的响应，使用 `--with-http_slice_module` 构建 Nginx               |
| ngx_http_spdy_module          | 为 SPDY 提供实验支持，使用 `--with-http_spdy_module` 构建 Nginx                                                            |
| ngx_http_split_clients_module | 创建适合 A/B 测试的变量，也称为分割测试，默认安装                                                                          |
| ngx_http_ssi_module           | 是一个过滤器，用于处理通过它的响应中的 SSI（服务器端包含）命令，默认安装                                                   |
| ngx_http_ssl_module           | 为 HTTPS 提供必要的支持，使用 `--with-http_ssl_module` 构建 Nginx                                                          |
| ngx_http_status_module        | 提供对各种状态信息的访问。默认安装                                                                                         |
| ngx_http_stub_status_module   | 提供对基本状态信息的访问。 使用 `--with-http_stub_status_module` 构建 Nginx                                                |
| ngx_http_sub_module           | 一个过滤器，它通过将一个指定的字符串替换为另一个来修改响应。使用 `--with-http_sub_module` 构建 Nginx                       |
| ngx_http_upstream_module      |
| ngx_http_upstream_conf_module |
| ngx_http_upstream_hc_module   |
| ngx_http_userid_module        |
| ngx_http_uwsgi_module         |
| ngx_http_v2_module            |
| ngx_http_xslt_module          |

> 备注：

```text
WEBDAV：
    - WebDAV 是一种基于 HTTP 1.1协议的通信协议；
    - 这里的WebDAV方法指的是 PUT、DELETE、MKCOL、COPY和MOVE
```
