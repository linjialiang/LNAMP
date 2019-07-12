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
