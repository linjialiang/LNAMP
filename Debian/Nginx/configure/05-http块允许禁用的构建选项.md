# http 允许禁用的构建选项

> http 块指令，默认会自动安装上，如果不需要允许使用禁用选项来禁用它们

1. `--without-http_charset_module`

   > 禁用构建 ngx_http_charset_module 模块，该模块将指定的字符集添加到“Content-Type”响应头字段，并且还可以将数据从一个字符集转换为另一个字符集。

   - 这个模块可以将服务器发出的HTTP响应重编码

2. `--without-http_gzip_module`

   > 禁用构建 HTTP 服务器 compresses responses 的模块。 zlib 库是构建和运行此模块所必需的。

3. `--without-http_ssi_module`

   > 禁用构建 ngx_http_ssi_module 模块。

   - 该模块可以在向用户返回的 HTTP 响应包体中加入特定的内容，如 HTML 文件中固定的页头和页尾

4. `--without-http_userid_module`

   > 禁用构建 ngx_http_userid_module 模块，该模块设置适合客户端识别的 cookie。

5. `--without-http_access_module`

   > 禁用构建 ngx_http_access_module 模块，该模块允许限制对某些客户端地址的访问。

6. `--without-http_auth_basic_module`

   > 禁用构建 ngx_http_auth_basic_module 模块，该模块允许通过使用“HTTP 基本身份验证”协议验证用户名和密码来限制对资源的访问。

7. `--without-http_mirror_module`

   > 禁用构建 ngx_http_mirror_module 模块，该模块通过创建后台镜像子请求来实现原始请求的镜像。

8. `--without-http_autoindex_module`

   > 禁用构建 ngx_http_autoindex_module 模块

   - 该模块处理以斜杠字符 / 结尾的请求的，并在 ngx_http_index_module 模块找不到索引文件的情况下生成目录列表。

   - 在部署模式下可以禁用 ngx_http_index_module 模块

9. `--without-http_geo_module`

   > 禁用构建 ngx_http_geo_module 模块，该模块使用取决于客户端 IP 地址的值创建变量。

10. `--without-http_map_module`

    > 禁用构建 ngx_http_map_module 模块，该模块使用取决于其他变量的值来创建变量。

11. `--without-http_split_clients_module`

    > 禁用构建 ngx_http_split_clients_module 模块，该模块为 A/B 测试创建变量。

12. `--without-http_referer_module`

    > 禁用构建 ngx_http_referer_module 模块，该模块可以阻止对“Referer”头字段中具有无效值的请求访问站点。

13. `--without-http_rewrite_module`

    > 禁用构建一个模块（该模块允许 HTTP 服务器重定向请求和更改请求 URI），构建和运行此模块需要 PCRE 库。

14. `--without-http_proxy_module`

    > 禁用构建 HTTP 服务器代理模块。

15. `--without-http_fastcgi_module`

    > 禁用生成 ngx_http_fastcgi_module 模块，该模块允许将请求传递给 FastCGI 服务器。

16. `--without-http_uwsgi_module`

    > 禁用构建 ngx_http_uwsgi_module 模块，该模块允许将请求传递给 uwsgi 服务器。

17. `--without-http_scgi_module`

    > 禁用构建 ngx_http_scgi_module 模块，该模块允许将请求传递给 SCGI 服务器。

18. `--without-http_grpc_module`

    > 禁用构建 ngx_http_grpc_module 模块，该模块允许将请求传递给 gRPC 服务器。

19. `--without-http_memcached_module`

    > 禁用构建 ngx_http_memcached_module 模块，该模块从 memcached 服务器获取响应。

20. `--without-http_limit_conn_module`

    > 禁用构建 ngx_http_limit_conn_module 模块，该模块限制每个密钥的连接数，例如，来自单个 IP 地址的连接数。

21. `--without-http_limit_req_module`

    > 禁用构建 ngx_http_limit_req_module 模块，该模块限制每个密钥的请求处理速率的，例如，来自单个 IP 地址的请求的处理速率。

22. `--without-http_empty_gif_module`

    > 禁用构建 ngx_http_empty_gif_module 模块。

23. `--without-http_browser_module`

    > 禁用构建 ngx_http_browser_module 模块，用于声明浏览器类型，其值取决于“User-Agent”请求标头字段值。

24. `--without-http_upstream_hash_module`

    > 禁用构建 ngx_http_upstream_module 模块下的 hash 方法。

    - 该方法指定服务器组的负载均衡方式，其中客户机-服务器映射基于散列键值。

25. `--without-http_upstream_ip_hash_module`

    > 禁用构建 ngx_http_upstream_module 模块下的 ip_hash 方法。

    - 该方法指定服务器组的负载均衡方式，其中请求基于客户机 IP 地址分布在服务器之间。

26. `--without-http_upstream_least_conn_module`

    > 禁用构建 ngx_http_upstream_module 模块下的 least_conn 方法。

    - 该方法指定服务器组的负载均衡方式，使用加权循环平衡方法，将请求传递给活 2. 动连接最少的服务器。

27. `--without-http_upstream_random_module`

    > 禁用构建 ngx_http_upstream_module 模块下的 random 方法。

    - 该方法允许指定 7 层负载均衡方式。

28. `--without-http_upstream_keepalive_module`

    > 禁用构建 ngx_http_upstream_module 模块下的 keepalive 方法。

    - 该方法激活连接到上游服务器的缓存。

29. `--without-http_upstream_zone_module`

    > 禁用构建 ngx_http_upstream_module 模块下的 zone 方法。

    - 该方法定义共享内存区域的 名称 和 大小 ，以保持组工作进程之间共享的组配置和运行时状态 2. 。
