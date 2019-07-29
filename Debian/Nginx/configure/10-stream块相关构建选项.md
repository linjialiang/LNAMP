# stream 块相关选项

1.  `--with-stream`

    > 启用构建 ngx_stream_core_module 模块，默认情况下不构建此模块。

    - 该模块可以实现 TCP/UDP 代理和 TCP/UDP 负载均衡
    - 使用 `--with-stream=dynamic` 允许动态构建 1. ngx_stream_core_module 模块

2.  `--with-stream_ssl_module`

    > 启用构建 ngx_stream_ssl_module 模块，为 stream 模块添加 SSL/TLS 协议支持。

3.  `--with-stream_realip_module`

    > 启用构建 ngx_stream_realip_module 模块，默认情况下不构建此模块。

    - 该模块将客户端地址更改为在代理协议头中发送的地址。

4.  `--with-stream_geoip_module`

    > 启用构建 ngx_stream_geoip_module 模块，默认情况下不构建此模块。

    - 该模块根据客户端 IP 地址和预编译的 MaxMind 数据库创建变量。
    - 使用 `--with-1. stream_geoip_module=dynamic` 允许动态构建 ngx_stream_core_module 模块

5.  `--with-stream_ssl_preread_module`

    > 启用构建 ngx_stream_ssl_preread_module 模块，默认情况下不构建此模块。

    - 该模块允许在不终止 SSL/TLS 的情况下从 ClientHello 消息中提取信息。

6.  `--without-stream_limit_conn_module`

    > 禁用构建 ngx_stream_limit_conn_module 模块，该模块限制每个键的连接数，例如，来自单个 IP 地址的连接数。

7.  `--without-stream_access_module`

    > 禁用生成 ngx_stream_access_module 模块，该模块允许限制对某些客户端地址的访问。

8.  `--without-stream_geo_module`

    > 禁用构建 ngx_stream_geo_module 模块，该模块会根据客户端 IP 地址来创建变量的值。

9.  `--without-stream_map_module`

    > 禁用构建 ngx_stream_map_module 模块，该模块创建的变量的值依赖于其他变量的值。

10. `--without-stream_split_clients_module`

    > 禁用构建 ngx_stream_split_clients_module 模块，该模块为 A/B 测试创建变量。

11. `--without-stream_return_module`

    > 禁用构建 ngx_stream_return_module 模块，该模块会在关闭连接前，向客户端发送一些指定信息。

12. `--without-stream_upstream_hash_module`

    > 禁用构建 ngx_stream_upstream_module 模块下的 hash 方法。

13. `--without-stream_upstream_least_conn_module`

    > 禁用构建 ngx_stream_upstream_module 模块下的 least_conn 方法。

14. `--without-stream_upstream_random_module`

    > 禁用构建 ngx_stream_upstream_module 模块下的 random 方法。

15. `--without-stream_upstream_zone_module`
    > 禁用构建 ngx_stream_upstream_module 模块下的 zone 方法。
