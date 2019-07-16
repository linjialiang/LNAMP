# 认识 Nginx

> Nginx 是一个 HTTP 和反向代理服务器，另外也可以作为邮件代理服务器和通用的 TCP/UDP 代理服务器，最初由 Igor Sysoev 编写。

```text
- 很长一段时间以来，它一直在许多负载很重的俄罗斯网站上运行，包括 Yandex， Mail.Ru， VK 和 Rambler。
- 据Netcraft称，nginx 在2019年6月服务或代理了 26.34％最繁忙的网站。
```

## nginx 能做什么？

> Nginx 的具体应用场景以及功能简述如下：

1. 基本的 HTTP 服务器功能

   ```text
   - 处理静态文件、索引文件以及自动索引；打开文件描述符缓存；
   - 使用缓存加速反向代理；简单负载均衡以及容错；
   - 远程FastCGI，uwsgi，SCGI，和memcached服务的缓存加速支持；简单的负载均衡以及容错；
   - 模块化的架构。过滤器包括gzip压缩、ranges支持、chunked响应、XSLT，SSI以及图像缩放；
        - 在SSI 过滤器中，一个包含多个SSI的页面，如果经由FastCGI或反向代理处理，可被并行处理。
   - 支持SSL，TLS SNI；
   - 支持HTTP/2的加权和基于依赖的优先级。
   ```

2. 其他的 HTTP 服务器特性

   ```text
   - 基于名字和 IP 的虚拟主机；
   - Keep-alive 和 pipelined 连接支持；
   - 灵活的配置，如:访问日志格式、缓冲日志写入、快速日志轮转和 syslog 日志记录；
   - 重新加载配置以及在线升级时，不需要中断正在处理的请求；
   - 3xx-5xx 错误代码重定向;
   - 重写（rewrite）模块：使用正则表达式改变 URI；
   - 根据客户端地址执行不同的功能；
   - 基于客户端 IP 地址、密码（HTTP 基本身份验证）以及 子请求结果的访问控制;
   - 支持验证 HTTP referer；
   - 支持 PUT、DELETE、MKCOL、COPY 以及 MOVE 方法；
   - 支持 FLV 流和 MP4 流；
   - 响应速度限制;
   - 限制来自一个地址的同时连接 或 同时请求的数量;
   - 嵌入式 Perl 语言；
   - 基于 IP 的地理定位;
   - A/B 测试;
   - 请求镜像;
   - njs 脚本语言。
   ```

3. 邮件代理服务器功能

   ```text
   - 使用外部 HTTP 认证服务器，重定向用户到 IMAP/POP3 服务器；
   - 使用外部 HTTP 认证服务器，对用户身份进行验证，验证用户后将连接重定向连接到内部 SMTP 服务器；
   - 支持的认证方式：
     - POP3: USER/PASS, APOP, AUTH LOGIN/PLAIN/CRAM-MD5;
     - IMAP: LOGIN, AUTH LOGIN/PLAIN/CRAM-MD5;
     - SMTP: AUTH LOGIN/PLAIN/CRAM-MD5;
   - SSL 支持；
   - STARTTLS 和 STLS 支持。
   ```

4. TCP/UDP 代理服务器功能

   ```text
   - TCP和UDP的通用代理;
   - SSL和TLS SNI支持TCP;
   - 负载均衡和容错;
   - 基于客户端地址的访问控制;
   - 根据客户端地址执行不同的功能;
   - 限制来自一个地址的同时连接 或 同时请求的数量;
   - 灵活的配置，如:访问日志格式、缓冲日志写入、快速日志轮转和 syslog 日志记录；
   - 基于 IP 的地理定位;
   - A/B 测试 ;
   - njs 脚本语言。
   ```

5. 架构和可扩展性
