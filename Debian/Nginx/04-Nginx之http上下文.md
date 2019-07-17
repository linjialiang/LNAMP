# Nginx 之 http 上下文

> 官方手册上对 http 上下文写出了 58 个模块，具体如下：

| 模块                          | 描述                                                        |
| ----------------------------- | ----------------------------------------------------------- |
| ngx_http_core_module          | http 核心功能模块，默认安装                                 |
| ngx_http_access_module        | 访问限制模块，默认安装                                      |
| ngx_http_addition_module      | 过滤器模块，构建 Nginx 需添加 `--with-http_addition_module` |
| ngx_http_api_module           |
| ngx_http_auth_basic_module    |
| ngx_http_auth_jwt_module      |
| ngx_http_auth_request_module  |
| ngx_http_autoindex_module     |
| ngx_http_browser_module       |
| ngx_http_charset_module       |
| ngx_http_dav_module           |
| ngx_http_empty_gif_module     |
| ngx_http_f4f_module           |
| ngx_http_fastcgi_module       |
| ngx_http_flv_module           |
| ngx_http_geo_module           |
| ngx_http_geoip_module         |
| ngx_http_grpc_module          |
| ngx_http_gunzip_module        |
| ngx_http_gzip_module          |
| ngx_http_gzip_static_module   |
| ngx_http_headers_module       |
| ngx_http_hls_module           |
| ngx_http_image_filter_module  |
| ngx_http_index_module         |
| ngx_http_js_module            |
| ngx_http_keyval_module        |
| ngx_http_limit_conn_module    |
| ngx_http_limit_req_module     |
| ngx_http_log_module           |
| ngx_http_map_module           |
| ngx_http_memcached_module     |
| ngx_http_mirror_module        |
| ngx_http_mp4_module           |
| ngx_http_perl_module          |
| ngx_http_proxy_module         |
| ngx_http_random_index_module  |
| ngx_http_realip_module        |
| ngx_http_referer_module       |
| ngx_http_rewrite_module       |
| ngx_http_scgi_module          |
| ngx_http_secure_link_module   |
| ngx_http_session_log_module   |
| ngx_http_slice_module         |
| ngx_http_spdy_module          |
| ngx_http_split_clients_module |
| ngx_http_ssi_module           |
| ngx_http_ssl_module           |
| ngx_http_status_module        |
| ngx_http_stub_status_module   |
| ngx_http_sub_module           |
| ngx_http_upstream_module      |
| ngx_http_upstream_conf_module |
| ngx_http_upstream_hc_module   |
| ngx_http_userid_module        |
| ngx_http_uwsgi_module         |
| ngx_http_v2_module            |
| ngx_http_xslt_module          |
