# http 默认不安装的构建选项

> http 块指令自带选项，但默认情况下不会 i 自动构建，构建时需要指定选项

1. `--with-http_ssl_module`

   > 启用 ngx_http_ssl_module 模块

   - 将 HTTPS 协议支持添加到 HTTP 服务器，默认情况下不构建此模块。并且，构建和运行此模块都需要 OpenSSL 库支持。

2. `--with-http_v2_module`

   > 启用 ngx_http_v2_module 模块，默认情况下不构建此模块

   - 该模块为 HTTP/2 提供支持，暂时只支持开启了 https 的网站。

3. `--with-http_realip_module`

   > 启用构建 ngx_http_realip_module 模块，该模块将客户端地址更改为，在指定的头字段中发送的地址。默认情况下不构建此模块。

   - 构建该模块的意义在于能够使得后台服务器记录客户端的原始 IP 地址。

4. `--with-http_addition_module`

   > 启用构建 ngx_http_addition_module 模块，该模块在响应之前和之后添加文本。默认情况下不构建此模块。

   - 该模块需要使用 [libgd 库](https://libgd.github.io/) 。建议使用库的最新可用版本。

5. `--with-http_xslt_module`

   > 启用构建 ngx_http_xslt_module 模块，该模块使用一个或多个 XSLT 样式表转换 XML 响应。默认情况下不构建此模块。

   - 构建和运行此模块需要 libxml2 和 libxslt 库
   - 使用 `--with-http_xslt_module=dynamic` 允许动态构建 `ngx_http_xslt_module` 模块

6. `--with-http_image_filter_module`

   > 支持构建 ngx_http_image_filter_module 模块，该模块转换 JPEG、GIF、PNG 和 WebP 格式的图像。默认情况下不构建此模块

   - 使用 `--with-http_image_filter_module=dynamic` 允许动态构建 `ngx_http_xslt_module` 模块
   - 该模块需要使用 [libgd 库](https://libgd.github.io/) 。建议使用库的最新可用版本。

7. `--with-http_geoip_module`

   > 启用构建 ngx_http_geoip_module 模块，默认情况下不构建此模块，这个模块需要 MaxMind GeoIP 库。

   - 该模块根据客户端 IP 地址和预编译的 MaxMind 数据库创建变量。
   - 使用 `--with-http_geoip_module=dynamic` 允许动态构建 `ngx_http_geoip_module` 模块

8. `--with-http_sub_module`

   > 启用构建 ngx_http_sub_module 模块，默认情况下不构建此模块。

   - 该模块让客户端看到的内容是我们修改过后的，它可以直接将一个字符串替换为另一个字符串。

9. `--with-http_dav_module`

   > 启用构建 ngx_http_dav_module 模块，该模块通过 WebDAV 协议提供文件管理自动化。默认情况下不构建此模块。

   - 让 Nginx 除了 GET、POST、HEAD 方法以外，增加了处理 WebDAV 部分方法（PUT、DELETE、MKCOL、COPY 和 MOVE）的能力

10. `--with-http_flv_module`

    > 启用构建 ngx_http_flv_module 模块，该模块为 Flash Video（FLV）文件提供伪流服务器端支持。默认情况下不构建此模块。

11. `--with-http_mp4_module`

    > 启用构建 ngx_http_mp4_module 模块，该模块为 MP4 文件提供伪流服务器端支持。默认情况下不构建此模块。

12. `--with-http_gunzip_module`

    > 启用构建 ngx_http_gunzip_module 模块，默认情况下不构建此模块。

    - 该模块使用 `Content-Encoding: gzip` 解压缩响应，以用于不支持 `gzip` 解压编码方法的客户端。
    - 提示：`gunzip` 这个程序可以解压 `.gz` 格式的压缩文件

13. `--with-http_gzip_static_module`

    > 启用构建 ngx_http_gzip_static_module 模块，默认情况下不构建此模块。

    - 该模块允许使用 `.gz` 文件扩展名而不是常规文件发送预压缩文件。
    - 比如：我们要访问 a.php，如果在同级目录下有一个 a.php.gz 的压缩文件；
      - nginx 会直接向客户端传输 a.php.gz，而不需要在客户端访问时，实时压缩，这样可以减轻当前 cpu 的工作量

14. `--with-http_auth_request_module`

    > 启用构建 ngx_http_auth_request_module 模块，默认情况下不构建此模块。

    ```text
    - 该模块基于子请求（如：php）的结果实现客户机授权：
        1. 如果子请求返回2xx响应代码，则允许访问。
        2. 如果返回401或403，则使用相应的错误代码拒绝访问。
        3. 子请求返回的任何其他响应代码都被认为是错误。
    ```

15. `--with-http_random_index_module`

    > 启用构建 ngx_http_random_index_module 模块，默认情况下不构建此模块。

    - 该模块处理以斜杠字符（'/'）结尾的请求，并选择目录中的随机文件作为索引文件。

16. `--with-http_secure_link_module`

    > 启用构建 ngx_http_secure_link_module 模块，默认情况下不构建此模块。

    - 制定并允许检查请求的链接的真实性以及保护资源免遭未经授权的访问；
    - 限制链接生效周期。

17. `--with-http_degradation_module`

    > 启用构建 ngx_http_degradation_module 模块。默认情况下不构建此模块。

    - 该模块允许在内存不足的情况下返回 204 或 444 给客户端。

18. `--with-http_slice_module`

    > 启用构建 ngx_http_slice_module 模块，默认情况下不构建此模块。

    - 该模块将请求拆分为子请求，每个模块都返回一定范围的响应，为 Nginx 提供了更有效的大响应缓存。
    - 该模块适用于在 proxy_cache 大文件的场景，将大文件切片缓存

19. `--with-http_stub_status_module`

    > 启用构建 ngx_http_stub_status_module 模块，默认情况下不构建此模块。

    - 该模块提供对基本状态信息的访问，使用 curl 指令可以查看，如：

      > 配置文件：

      ```conf
      location /nginx_status {
          stub_status on;
      }
      ```

      > 终端指令：

      ```shell
      $ curl  127.0.0.1/nginx_status
      Active connections: 1
      server accepts handled requests
       655 655 1985
      Reading: 0 Writing: 1 Waiting: 0
      ```
