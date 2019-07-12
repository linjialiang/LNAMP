# apt 安装 Nginx

> 从第六版开始我们推荐使用 Nginx 作为服务器 Web 服务，喜欢 httpd 的可以参考 [WAMP 章节](./../../WAMP/README.md)

## 安装 Nginx

> apt 源自带的几个 Nginx 相关包说明：

| 包名         | 描述                 |
| ------------ | -------------------- |
| nginx        | nginx 安装包         |
| nginx-common | nginx 指令集         |
| nginx-doc    | nginx 文档           |
| nginx-full   | 标准插件（默认安装） |
| nginx-extras | 更多插件             |
| nginx-light  | 更少插件             |

> 安装指令如下：

```shell
$ apt install nginx nginx-doc
```

## 测试 Nginx

> 我们可以通过 curl 来测试是否启动成功

```shell
$ curl -I 127.0.0.1
```

> 终端出现如下类似输出，则说明启动成功：

```text
HTTP/1.1 200 OK
Server: nginx/1.14.2
Date: Fri, 12 Jul 2019 06:37:51 GMT
Content-Type: text/html
Content-Length: 612
Last-Modified: Fri, 12 Jul 2019 06:26:14 GMT
Connection: keep-alive
ETag: "5d282806-264"
Accept-Ranges: bytes
```

## 管理 Nginx 服务

> 使用 apt 安装的 Nginx 默认支持 3 种管理方式：

1. 要停止 Nginx 服务，请运行：

   ```shell
   $ systemctl stop nginx
   $ service nginx stop
   $ /etc/init.d/nginx stop
   ```

2. 要再次启动它，请键入：

   ```shell
   $ systemctl start nginx
   $ service nginx start
   $ /etc/init.d/nginx start
   ```

3. 重启 Nginx 服务:

   ```shell
   $ systemctl restart nginx
   $ service nginx restart
   $ /etc/init.d/nginx restart
   ```

4. 在配置更改后重新加载 Nginx 服务：

   ```shell
   $ systemctl reload nginx
   $ service nginx reload
   $ /etc/init.d/nginx reload
   ```

5. 查看 Nginx 服务当前状态：

   ```shell
   $ systemctl status nginx
   $ service nginx status
   $ /etc/init.d/nginx status
   ```

6. 禁用 Nginx 服务在启动时启动：

   ```shell
   $ systemctl disable nginx
   ```

7. 启用 Nginx 服务在启动时启动：

   ```shell
   $ systemctl enable nginx
   ```

## 配置 Nginx

> Nginx 的配置也是比较简单的，与 httpd 相比，方便很多

### 配置文件

> Nginx 具体的配置文件及其的作用，如下表：

| Nginx 配置                           | 描述                       |
| ------------------------------------ | -------------------------- |
| /etc/nginx                           | 配置文件存储目录           |
| /etc/nginx/nginx.conf                | 主配置文件                 |
| /etc/nginx/mime.types                | 静态资源文件格式列表       |
| /etc/nginx/modules-enabled           | 被加载的模块               |
| /etc/nginx/sites-enabled             | 被加载的站点配置           |
| /etc/nginx/snippets/fastcgi-php.conf | 适用于 php 的 fastcgi 配置 |
