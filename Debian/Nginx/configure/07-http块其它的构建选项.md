# http 块其它的构建选项

1. `--http-log-path=PATH`

   > 设置 HTTP 访问日志文件的路径及名称。默认情况下，该文件名为 prefix/logs/access.log

   - 安装后，始终可以使用 access_log 指令在配置文件(nginx.conf)中更改文件名：

   ```conf
   access_log /logs/nginx/access.log;
   ```

2. `--http-client-body-temp-path=PATH`

   > 定义存储路径，用于保存 http 客户端请求主体的临时文件。默认情况下，该目录名为 prefix/client_body_temp 。

   - 安装后，始终可以使用 client_body_temp_path 指令在配置文件(nginx.conf)中更改目录：

   ```conf
   client_body_temp_path /data/nginx/client_temp 1 2;
   ```

3. `--http-proxy-temp-path=PATH`

   > 定义存储路径，用于保存 http 从代理服务器接收的数据的临时文件。默认情况下，该目录名为 prefix/proxy_temp 。

   - 安装后，始终可以使用 proxy_temp_path 指令在 nginx.conf 配置文件中更改目录：

   ```conf
   proxy_temp_path /data/nginx/proxy_temp 1 2;
   ```

4. `--http-fastcgi-temp-path=PATH`

   > 定义存储路径，用于保存 http 从 FastCGI 服务器接收的数据的临时文件。默认情况下，该目录名为 prefix/fastcgi_temp 。

   - 安装后，始终可以使用 fastcgi_temp_path 指令在 nginx.conf 配置文件中更改目录：

   ```conf
   fastcgi_temp_path /data/nginx/fastcgi_temp 1 2;
   ```

5. `--http-uwsgi-temp-path=PATH`

   > 定义存储路径，用于保存 http 从 uwsgi 服务器接收的数据的临时文件。默认情况下，该目录名为 prefix/uwsgi_temp 。

   - 安装后，始终可以使用 uwsgi_temp_path 指令在 nginx.conf 配置文件中更改目录：

   ```conf
   uwsgi_temp_path /data/nginx/uwsgi_temp 1 2;
   ```

6. `--http-scgi-temp-path=PATH`

   > 定义存储路径，用于保存 http 从 scgi 服务器接收的数据的临时文件。默认情况下，该目录名为 prefix/scgi_temp 。

   - 安装后，始终可以使用 scgi_temp_path 指令在 nginx.conf 配置文件中更改目录：

   ```conf
   uwsgi_temp_path /data/nginx/uwsgi_temp 1 2;
   ```
