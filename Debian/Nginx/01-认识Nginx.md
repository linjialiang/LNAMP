# Nginx 是什么？

> nginx 是一个 HTTP 和反向代理服务器，一个邮件代理服务器和一个通用的 TCP/UDP 代理服务器。

## 基本的 HTTP 服务器功能

1. 处理静态文件，索引文件以及自动索引，并对打开的“文件描述符”进行缓存;

2. 简单的负载均衡和容错；

   ```text
   - 支持通过缓存来加速反向代理;
   - 支持通过缓存来加速 FastCGI、uwsgi、SCGI 和 memcached 服务器。
   ```

3. 模块化架构

   ```text
   - 过滤器包括， gzipping、字节范围、分块响应、XSLT、SSI和图像转换过滤器。
   - 如果由代理或 FastCGI/uwsgi/SCGI 服务器处理，则可以并行处理单个页面中的多个SSI（支持 SSL 和 TLS SNI ）;
   ```

4. 支持 HTTP/2， 具有加权和基于依赖性的优先级。
