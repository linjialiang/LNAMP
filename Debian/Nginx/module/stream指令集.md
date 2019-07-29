# stream 指令集

> 处理网络通信中的 第 4 层协议（TCP/UDP），如：4 层代理、4 层反向代理、4 层负载均衡。

| stream 模块                     | 描述                                                                                                                                 |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| ngx_stream_core_module          | stream 核心模块                                                                                                                      |
| ngx_stream_access_module        | 允许限制对某些客户机地址的访问                                                                                                       |
| ngx_stream_geo_module           | 根据客户机 IP 地址创建具有值的变量。                                                                                                 |
| ngx_stream_geoip_module         | 使用预编译的 MaxMind 数据库创建变量，其值取决于客户机 IP 地址。                                                                      |
| ~~ngx_stream_js_module~~        | 实现 njs (JavaScript 语言的子集)中的处理程序。                                                                                       |
| ngx_stream_keyval_module        | 使用 API 管理的键值对中的值创建变量。                                                                                                |
| ngx_stream_limit_conn_module    | 用于限制每个定义键的连接数，特别是来自单个 IP 地址的连接数。                                                                         |
| ngx_stream_log_module           | 以指定的格式写入会话日志。                                                                                                           |
| ngx_stream_map_module           | 创建其值依赖于其他变量值的变量。                                                                                                     |
| ngx_stream_proxy_module         | 允许在 TCP、UDP(1.9.13)和 unix 域套接字上代理数据流。                                                                                |
| ngx_stream_realip_module        | 将客户机地址和端口更改为在代理协议头(1.11.4)中发送的地址和端口。代理协议之前必须通过在 listen 指令中设置 proxy_protocol 参数来启用。 |
| ngx_stream_return_module        | 允许向客户端发送指定值，然后关闭连接。                                                                                               |
| ngx_stream_split_clients_module | 创建适合 A/B 测试的变量，也称为分割测试。                                                                                            |
| ngx_stream_ssl_module           | 为使用 SSL/TLS 协议的 stream 代理服务器提供必要的支持。                                                                              |
| ngx_stream_ssl_preread_module   | 允许在不终止 SSL/TLS 的情况下从 ClientHello 消息中提取信息，                                                                         |
| ngx_stream_upstream_module      | 用于定义可以由 proxy_pass 指令引用的服务器组。                                                                                       |
| ngx_stream_upstream_hc_module   | 允许对组中的服务器进行定期健康检查。服务器组必须驻留在共享内存中。                                                                   |
| ngx_stream_zone_sync_module     | 为在集群节点之间同步共享内存区域的内容提供必要的支持。                                                                               |
