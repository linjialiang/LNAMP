# http 核心模块

> http 核心模块的指令都算是处理 http 请求最基本的指令，一点要掌握好

1. `absolute_redirect`

   > 如果禁用，nginx 发出的重定向将是相对的。

   | 语法   | `absolute_redirect on | off;` |
   | ------ | ----------------------------- |
   | 默认值 | absolute_redirect on;         |
   | 上下文 | http, server, location        |

2. `aio`

   > 在 FreeBSD 和 Linux 上启用或禁用异步文件 I/O (AIO):

   | Syntax  | `aio on | off | threads[=pool];` |
   | ------- | -------------------------------- |
   | Default | aio off;                         |
   | Context | http, server, location           |

3. `aio_write`

   > 如果启用 aio，指定它是否用于编写文件。

   - 目前，这仅适用于使用 aio 线程，并且仅限于使用代理服务器接收的数据编写临时文件。


    | Syntax  | ` 	aio_write on | off;` |
    | ------- | -------------------------------- |
    | Default | aio_write off;                        |
    | Context | http, server, location           |

4. `alias`

   > 替换指定位置的

   | Syntax  | alias path; |
   | ------- | ----------- |
   | Default | —           |
   | Context | location    |

5. `chunked_transfer_encoding`

   > 允许禁用 HTTP/1.1 中的块传输编码。

   - 当使用不支持分块编码的软件(尽管有标准的要求)时，它可能会派上用场。

   | Syntax  | `chunked_transfer_encoding on | off;` |
   | ------- | ------------------------------------- |
   | Default | chunked_transfer_encoding on;         |
   | Context | http, server, location                |

6. `client_body_buffer_size`

   > 设置读取客户端请求体的缓冲区大小。默认情况下，缓冲区大小等于两个内存页(x86 平台 8k，x64 平台 16k)。

   - 如果请求主体大于缓冲区，则将整个主体或仅其部分写入临时文件。

   | Syntax  | `client_body_buffer_size size;`   |
   | ------- | --------------------------------- |
   | Default | `client_body_buffer_size 8k|16k;` |
   | Context | http, server, location            |

7) `client_body_in_file_only`

   > 确定 nginx 是否应该将整个客户机请求体保存到一个文件中。

   | Syntax  | `client_body_in_file_only on | clean | off;` |
   | ------- | -------------------------------------------- |
   | Default | client_body_in_file_only off;                |
   | Context | http, server, location                       |

8) `client_body_in_single_buffer`

   > 确定 nginx 是否应该将整个客户机请求体保存在一个缓冲区中

   | Syntax  | client_body_in_single_buffer on   | off; |
   | ------- | --------------------------------- | ---- |
   | Default | client_body_in_single_buffer off; |
   | Context | http, server, location            |

9) `client_body_temp_path`

   > 定义用于存储包含客户端请求主体的临时文件的目录。

   | Syntax  | client_body_temp_path path [level1 [level2 [level3]]]; |
   | ------- | ------------------------------------------------------ |
   | Default | client_body_temp_path client_body_temp;                |
   | Context | http, server, location                                 |

10) `client_body_timeout`

    > 定义读取客户端请求主体的超时。

    | Syntax  | client_body_timeout time; |
    | ------- | ------------------------- |
    | Default | client_body_timeout 60s;  |
    | Context | http, server, location    |

11) `client_header_buffer_size`

    > 设置读取客户端请求头的缓冲区大小。

    | Syntax  | client_header_buffer_size size; |
    | ------- | ------------------------------- |
    | Default | client_header_buffer_size 1k;   |
    | Context | http, server                    |

12) `client_header_timeout`

    > 定义读取客户端请求头的超时。

    | Syntax  | client_header_timeout time; |
    | ------- | --------------------------- |
    | Default | client_header_timeout 60s;  |
    | Context | http, server                |

13) `client_max_body_size`

    > 设置客户端请求主体的最大允许大小，在“Content-Length”请求头字段中指定。

    - 如果请求中的大小超过配置的值，则将 413(请求实体太大)错误返回给客户机。
    - 请注意浏览器无法正确显示此错误。
    - 将大小设置为 0 将禁用对客户机请求体大小的检查。

    | Syntax  | client_max_body_size size; |
    | ------- | -------------------------- |
    | Default | client_max_body_size 1m;   |
    | Context | http, server, location     |

14) `connection_pool_size`

    > 允许精确地调优每个连接的内存分配。这个指令对性能的影响很小，一般默认即可。


    | Syntax  | connection_pool_size size;      |
    | ------- | ------------------------------- |
    | Default | `connection_pool_size 256|512;` |
    | Context | http, server                    |

    >提示： 32位平台为256byte（字节），64位平台为512byte（字节）

15. `default_type`

    > 定义响应的默认 MIME 类型。

    - 文件名扩展名到 MIME 类型的映射可以使用 `types` 指令设置。

    | Syntax  | `default_type mime-type;`  |
    | ------- | -------------------------- |
    | Default | `default_type text/plain;` |
    | Context | http, server, location     |

16. `directio`

    > 该指令将 `aio` 和 `sendfile` 有优点集中起来

    | Syntax  | `directio size | off;` |
    | ------- | ---------------------- |
    | Default | directio off;          |
    | Context | http, server, location |

    - 案例说明：

    ```conf
    http{
        ...
        sendfile on
        location /data{
            aio on;
            directio 4m;
        }
    }
    ```

    - 默认情况下，nginx 使用 sendfile() 进行传输；
    - 在 data 目录下并且文件小于 4M,使用 sendfile() 进行传输；
    - 在 data 目录下并且文件大于 4M,使用 aio() 异步的方式进行传输；

17. `directio_alignment`

    > 设置 `directio` 的对齐，跟格式化磁盘时那个 4K 对其一样的概念！

    - 在大多数情况下，512 字节的对齐就足够了。但是，在 Linux 下使用 XFS 时，需要将其增加到 4K

    | Syntax  | directio_alignment size; |
    | ------- | ------------------------ |
    | Default | directio_alignment 512;  |
    | Context | http, server, location   |

18. `disable_symlinks`

    > 打开文件时应如何处理符号链接（如：软连接），默认即可

    | Syntax  | disable_symlinks off;                      |
    | ------- | ------------------------------------------ |
    | Syntax  | disable_symlinks on [from=part];           |
    | Syntax  | disable_symlinks if_not_owner [from=part]; |
    | Default | disable_symlinks off;                      |
    | Context | http, server, location                     |

    | 参数         | 描述                                                                                     |
    | ------------ | ---------------------------------------------------------------------------------------- |
    | off          | 允许并且不检查路径名中的符号链接。这是默认行为。                                         |
    | on           | 如果路径名的任何组件是符号链接，则拒绝访问文件。                                         |
    | if_not_owner | 如果路径名的任何组件是符号链接，并且链接指向具有不同所有者的链接和对象，则拒绝访问文件。 |

19. `error_page`

    > 如何响应错误页面。

    | Syntax  | `error_page code ... [=[response]] uri;` |
    | ------- | ---------------------------------------- |
    | Default | —                                        |
    | Context | http, server, location, if in location   |

    - 例 1：响应代码为 404 时，内部重定向到 `/404.html` 页面，并且在客户端输出 404：

      ```conf
      error_page 404 /404.html;
      ```

    - 例 2：响应代码为 404 时，内部重定向到 `/404.html` 页面，并且在客户端输出 200：

      ```conf
      error_page 404 =200 /404.html;
      ```

    - 例 3：php 后端程序响应代码为 404 时，Nginx 拦截 php 的 404 错误，并且内部重定向到 `/404.html` 页面,在客户端输出 404

      ```conf
      error_page 404 = /404.html;
      ```

20. `etag`

    > 为静态资源启用或禁用自动生成“ETag”响应标头字段。默认即可

    | Syntax  | `etag on | off;`       |
    | ------- | ---------------------- |
    | Default | etag on;               |
    | Context | http, server, location |

21. `http`

    > 提供指定 HTTP 服务器指令的配置文件上下文。

22. `if_modified_since`

    > 把客户端缓存页面的最后修改时间与服务器上实际文件的最后修改时间进行比较。

    | Syntax  | `if_modified_since off | exact | before;` |
    | ------- | ----------------------------------------- |
    | Default | if_modified_since exact;                  |
    | Context | http, server, location                    |

    | 参数   | 描述                                                              |
    | ------ | ----------------------------------------------------------------- |
    | off    | 忽略 `If-Modified-Since` 请求头字段                               |
    | exact  | 完全匹配                                                          |
    | before | 响应的修改时间小于或等于 `If-Modified-Since` 请求头字段中的时间。 |

23. `ignore_invalid_headers`

    > 控制是否应忽略具有无效名称的标头字段。

    - 有效名称由英文字母，数字，连字符和可能的下划线组成（由 underscores_in_headers 指令控制）。
    - 如果在 server 上下文内指定了该指令，则仅在服务器是默认服务器时使用其值。指定的值也适用于侦听同一地址和端口的所有虚拟服务器。

    | Syntax  | `ignore_invalid_headers on | off;` |
    | ------- | ---------------------------------- |
    | Default | ignore_invalid_headers on;         |
    | Context | http, server                       |

24. `internal`

    > 建立一个仅内部可用的 location。

    - 即：internal 指令用于指定只允许来自本地 Nginx 的内部调用，来自外部的访问会直接返回 `404 not found` 状态。

    | Syntax  | internal; |
    | ------- | --------- |
    | Default | —         |
    | Context | location  |

    - 内部要求如下:

      ```text
      1. 由 error_page, index, random_index 和 try_files，重定向的请求；
      2. 由 “X-Accel-Redirect” 响应头字段从上游服务器重定向的请求;
      3. 请求被 rewrite 指令更改。
      4. 由ngx_http_addition_module模块指令、auth_request指令以及 mirror指令 组成的子请求;
      ```

25. `keepalive_disable`

    > 指定的浏览器，不使用 keepalive 这种长连接，默认禁用 IE6 浏览器;

    | Syntax  | `keepalive_disable none | browser ...;` |
    | ------- | --------------------------------------- |
    | Default | keepalive_disable msie6;                |
    | Context | http, server, location                  |

26. `keepalive_requests`

    > 用于设置，一个 TCP 活动连接可通过的最大请求数。在发出最大请求数后，将关闭 TCP 连接。

    | Syntax  | keepalive_requests number; |
    | ------- | -------------------------- |
    | Default | keepalive_requests 100;    |
    | Context | http, server, location     |

27) `keepalive_timeout`

    | Syntax  | `keepalive_timeout timeout [header_timeout];` |
    | ------- | --------------------------------------------- |
    | Default | keepalive_timeout 75s;                        |
    | Context | http, server, location                        |

    - 第一个参数设置一个超时，在此期间保持活动的客户端连接将在服务器端保持打开状态。零值禁用保持活动的客户端连接。
    - 可选的第二个参数在“Keep-Alive: timeout=time”响应头字段中设置一个值。两个参数可能不同。

28) `large_client_header_buffers`

    | Syntax  | `large_client_header_buffers number size;` |
    | ------- | ------------------------------------------ |
    | Default | large_client_header_buffers 4 8k;          |
    | Context | http, server                               |

    ```text
    - 设置用于读取大客户机请求标头的最大缓冲区 number 和 size 。
    - 请求行不能超过一个缓冲区的大小，否则会将 414（Request-URI Too Large）错误返回给客户端。
    - 请求头字段也不能超过一个缓冲区的大小，或者 400（错误请求）错误返回给客户端。
    - 缓冲区仅按需分配。
    - 默认情况下，缓冲区大小等于 8K 字节。
    - 如果在请求处理结束后连接转换为保持活动状态，则释放这些缓冲区。
    ```

29. `limit_except`

    | Syntax  | limit_except method ... { ... } |
    | ------- | ------------------------------- |
    | Default | —                               |
    | Context | location                        |

    - 限制允许位置内的 HTTP 方法。

    - 所述 method 参数可以是下列之一：

      > GET, HEAD, POST, PUT, DELETE, MKCOL, COPY, MOVE, OPTIONS, PROPFIND, PROPPATCH, LOCK, UNLOCK 或 PATCH

    - 注意： GET 方法包括了 HEAD 方法。

    - 另外，也可以使用 ngx_http_access_module，ngx_http_auth_basic_module 和 ngx_http_auth_jwt_module 模块指令来限制其他情况的访问！

    | HTTP 方法 | 评估结果       | 建议     | 说明                                                                                                                                                                                                                                                                                   | 解决方案                         |
    | --------- | -------------- | -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------- |
    | HEAD      | 安全           | 无       | 除了服务器不能在响应中返回消息体，HEAD 方法与 GET 相同。HEAD 请求的响应中的 HTTP 头部中包含的元信息应该与 GET 请求发送的响应中的信息相同。该方法可用来获取请求暗示实体的元信息，而不需要传输实体本身。该方法常用来测试超文本链接的有效性、可用性和最近的修改。                         |
    | TRACE     | 危险           | 建议关闭 | TRACE 方法用于引起远程的，该请求消息的应用层回射。请求的最终接收者应该反射 200（OK）响应，并以该消息作为客户端回收消息的实体。                                                                                                                                                         | 将应用服务器中的 TRACE 谓词拒绝  |
    | GET       | 安全           | 无       | GET 方法即获取由 Request-URI 标识的任何信息（以实体的形式）。如果 Request-URI 引用某个数据处理过程，则应该以它产生的数据作为在响应中的实体，而不是该过程的源代码文本，除非该过程碰巧输出该文本。                                                                                       |
    | PUT       | 危险           | 建议关闭 | PUT 方法请求将封装的实体存储在指定的 Request-URI 下。如果 Request-URI 引用已存在的资源，该封装实体应该被认作最初服务器存储的修改版本。如果 Request-URI 没有指向已存在的资源，且该 URI 可以被请求的用户代理定义为新的资源，则最初服务器可以用该 URI 创建资源。                          | 将应用服务器中的 PUT 谓词拒绝    |
    | POST      | 安全           | 无       | POST 方法用来请求最初服务器接受请求中封装的实体作为从属于请求行中的 Request-URI 标识的附属。                                                                                                                                                                                           |
    | OPTIONS   | 安全（已关闭） | 无       | OPTIONS 方法表示在由 Request-URI 标识的请求/响应链上关于有效通讯选项信息的请求。该方法允许客户端判断与某个资源相关的选项和/或需求或者服务器的能力，而不需要采用资源行为或发起资源获取。                                                                                                |
    | DELETE    | 危险           | 建议关闭 | DELETE 方法请求最初服务器删除 Request-URI 标识的资源。最初服务器可在人为干涉下（或其它意思）屏蔽该方法。客户端不能确保该操作已提交，即使最初服务器发出的状态码表明动作已成功完成也如此。然而，在给出响应的时候，服务器不应该表示成功，除非它试图删除该资源或将它移动到不可访问的位置。 | 将应用服务器中的 DELETE 谓词拒绝 |

30. `limit_rate`

    > 限制向客户端传输的响应速率。rate 以 `xx字节/秒` 为单位，单位省略。零值禁用速率限制。根据请求设置限制，因此如果客户端同时打开两个连接，则总速率将是指定限制的两倍。

    | Syntax  | limit_rate rate;                       |
    | ------- | -------------------------------------- |
    | Default | limit_rate 0;                          |
    | Context | http, server, location, if in location |

31. `limit_rate_after`

    > 设置一个初始值，在此之后，将启动 limit 计数,用于限制对客户机的响应的进一步传输。

    - 如果小于此值则不限速

    | Syntax  | limit_rate_after size;                 |
    | ------- | -------------------------------------- |
    | Default | limit_rate_after 0;                    |
    | Context | http, server, location, if in location |

32. `lingering_close`

    | Syntax  | `lingering_close off | on | always;` |
    | ------- | ------------------------------------ |
    | Default | lingering_close on;                  |
    | Context | http, server, location               |

    > 控制 nginx 如何关闭客户端连接。在完全关闭连接之前：

    | 参数   | 描述                                                                                                 |
    | ------ | ---------------------------------------------------------------------------------------------------- |
    | on     | 指示 nginx 从客户端获取 wait for 和 process 附加数据，但仅当启发式表明客户端可能正在发送更多数据时。 |
    | always | 将导致 nginx 无条件地等待并处理其他客户端数据。                                                      |
    | off    | 告诉 nginx 永远不要等待更多数据并立即关闭连接。此行为会破坏协议，不应在正常情况下使用。              |

33. `lingering_time`

    > 当 lingering_close 生效时，该指令指定 nginx 处理(读取和忽略)来自客户机的附加数据的最大时间。之后，连接将被关闭，即使有更多的数据。

    | Syntax  | lingering_time time;   |
    | ------- | ---------------------- |
    | Default | lingering_time 30s;    |
    | Context | http, server, location |

34. `lingering_timeout`

    > 当 lingering_close 生效时，该指令指定更多客户机数据到达的最大等待时间。

    - 如果在此期间没有接收到数据，则关闭连接。
    - 否则，将读取和忽略数据，nginx 再次开始等待更多的数据。
    - “等待-读取-忽略”循环会重复，但不会超过 lingering_time 指令指定的时间。

    | Syntax  | lingering_timeout time; |
    | ------- | ----------------------- |
    | Default | lingering_timeout 5s;   |
    | Context | http, server, location  |

35. `listen`

    > 设置 IP 的地址和端口，或服务器将在其上接受请求的 unix 域套接字的路径。地址和端口都可以指定，或者只能指定地址或端口。

    | Syntax: | `listen address[:port] [default_server] [ssl] [http2 | spdy] [proxy_protocol] [setfib=number] [fastopen=number] [backlog=number] [rcvbuf=size] [sndbuf=size] [accept_filter=filter] [deferred] [bind] [ipv6only=on|off] [reuseport] [so_keepalive=on|off|[keepidle]:[keepintvl]:[keepcnt]]; listen port [default_server] [ssl] [http2 | spdy] [proxy_protocol] [setfib=number] [fastopen=number] [backlog=number] [rcvbuf=size] [sndbuf=size] [accept_filter=filter] [deferred] [bind] [ipv6only=on|off] [reuseport] [so_keepalive=on|off|[keepidle]:[keepintvl]:[keepcnt]]; listen unix:path [default_server] [ssl] [http2 | spdy] [proxy_protocol] [backlog=number] [rcvbuf=size] [sndbuf=size] [accept_filter=filter] [deferred] [bind] [so_keepalive=on|off|[keepidle]:[keepintvl]:[keepcnt]];` |
    | ------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
    | Default | `listen *:80 | *:8000;`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
    | Context | server                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |

    > 地址也可以是主机名，例如:

    ```conf
    listen 127.0.0.1:8000;
    listen 127.0.0.1;
    listen 8000;
    listen *:8000;
    listen localhost:8000;
    ```

36. `location`

    > 根据请求 URI 设置配置。

    | Syntax  | `location [ = | ~ | ~* | ^~ ] uri { ... }` |
    | ------- | ------------------------------------------ |
    | Syntax  | `location @name { ... }`                   |
    | Default | —                                          |
    | Context | server, location                           |

37. `log_not_found`

    > 在 error_log 中启用或禁用关于未找到文件的错误日志记录。

    | Syntax  | `log_not_found on| off;` |
    | ------- | ------------------------ |
    | Default | log_not_found on;        |
    | Context | http, server, location   |

38. `log_subrequest`

    > 启用或禁用将子请求记录到 access_log 中的功能。

    | Syntax  | `log_subrequest on | off;` |
    | ------- | -------------------------- |
    | Default | log_subrequest off;        |
    | Context | http, server, location     |

39. `max_ranges`

    > 限制字节范围请求中允许的最大范围数。默认情况下，范围的数量不受限制。零值完全禁用字节范围支持。

    -- 超过此限制的请求将被处理，就好像没有指定字节范围一样。

    | Syntax  | max_ranges number;     |
    | ------- | ---------------------- |
    | Default | —                      |
    | Context | http, server, location |

40. `merge_slashes`

    > 启用或禁用将 URI 中的两个或多个相邻斜杠压缩为单个斜杠。

    | Syntax  | `merge_slashes on | off;` |
    | ------- | ------------------------- |
    | Default | merge_slashes on;         |
    | Context | http, server              |

41. `msie_padding`

    > 启用或禁用，向状态大于 400 的 MSIE 客户端的响应添加注释，以将响应大小增加到 512 字节。

    | Syntax  | `msie_padding on | off;` |
    | ------- | ------------------------ |
    | Default | msie_padding on;         |
    | Context | http, server, location   |

42. `msie_refresh`

    > 为 MSIE 客户机启用或禁用发出刷新，而不是重定向。

    | Syntax  | `msie_refresh on | off;` |
    | ------- | ------------------------ |
    | Default | msie_refresh off;        |
    | Context | http, server, location   |

43. `open_file_cache`


    | Syntax  | open_file_cache off;                   |
    | ------- | -------------------------------------- |
    | Syntax  | open_file_cache max=N [inactive=time]; |
    | Default | open_file_cache off;                   |
    | Context | http, server, location                 |

    > 配置一个缓存，可以存储:

    - 打开文件描述符，它们的大小和修改时间;
    - 目录存在的资料;
    - 文件查找错误，如“文件未找到”、“没有读取权限”等。

    | 参数     | 描述                                                                       |
    | -------- | -------------------------------------------------------------------------- |
    | max      | 设置缓存中元素的最大数量;在缓存溢出时，删除最近最少使用的(LRU)元素;        |
    | inactive | 定义从缓存中删除元素的时间(如果在此期间没有访问该元素);默认情况下是 60 秒; |
    | off      | 禁用缓存                                                                   |

44. `open_file_cache_errors`

    > 通过 open_file_cache 启用或禁用文件查找错误的缓存。

    | Syntax  | `open_file_cache_errors on | off;` |
    | ------- | ---------------------------------- |
    | Default | open_file_cache_errors off;        |
    | Context | http, server, location             |

45. `open_file_cache_min_uses`

    > 设置由 open_file_cache 指令的非活动参数配置的期间内文件访问的最小数量，该参数是文件描述符在缓存中保持打开状态所必需的。

    | Syntax  | open_file_cache_min_uses number; |
    | ------- | -------------------------------- |
    | Default | open_file_cache_min_uses 1;      |
    | Context | http, server, location           |

46. `open_file_cache_valid`

    > 设置应验证 open_file_cache 元素的时间。

    | Syntax  | open_file_cache_valid time; |
    | ------- | --------------------------- |
    | Default | open_file_cache_valid 60s;  |
    | Context | http, server, location      |

47. `output_buffers`

    > 设置用于从磁盘读取响应的缓冲区的数量和大小。

    | Syntax  | output_buffers number size; |
    | ------- | --------------------------- |
    | Default | output_buffers 2 32k;       |
    | Context | http, server, location      |

48. `port_in_redirect`

    > 启用或禁用在 nginx 发出的绝对重定向中指定端口。

    | Syntax  | `port_in_redirect on | off;` |
    | ------- | ---------------------------- |
    | Default | port_in_redirect on;         |
    | Context | http, server, location       |

49. `postpone_output`

    > 如果可能，客户端数据的传输将推迟到 nginx 至少有大小字节的数据要发送。零值禁止延迟数据传输。

    | Syntax  | postpone_output size;  |
    | ------- | ---------------------- |
    | Default | postpone_output 1460;  |
    | Context | http, server, location |

50. `read_ahead`

    > 设置处理文件时内核的预读量。

    | Syntax  | read_ahead size;       |
    | ------- | ---------------------- |
    | Default | read_ahead 0;          |
    | Context | http, server, location |

51. `recursive_error_pages`

    > 启用或禁用使用 error_page 指令执行多个重定向。这种重定向的数量是有限的。

    | Syntax  | `recursive_error_pages on | off;` |
    | ------- | --------------------------------- |
    | Default | recursive_error_pages off;        |
    | Context | http, server, location            |

52. `request_pool_size`

    > 允许精确地调优每个请求的内存分配。这个指令对性能的影响很小，一般不应该使用。

    | Syntax  | request_pool_size size; |
    | ------- | ----------------------- |
    | Default | request_pool_size 4k;   |
    | Context | http, server            |

53. `reset_timedout_connection`

    > 启用或禁用重置超时连接和使用非标准代码 444 关闭的连接。

    | Syntax  | `reset_timedout_connection on | off;` |
    | ------- | ------------------------------------- |
    | Default | reset_timedout_connection off;        |
    | Context | http, server, location                |

54. `resolver`

    > 将用于解析上游服务器名称的名称服务器配置到地址中，一般不用理会

    | Syntax  | `resolver address ... [valid=time] [ipv6=on|off];` |
    | ------- | -------------------------------------------------- |
    | Default | —                                                  |
    | Context | http, server, location                             |

55. `resolver_timeout`

    > 设置名称解析超时

    | Syntax  | resolver_timeout time; |
    | ------- | ---------------------- |
    | Default | resolver_timeout 30s;  |
    | Context | http, server, location |

56. `root`

    > 设置请求的根目录。

    | Syntax  | root path;                             |
    | ------- | -------------------------------------- |
    | Default | root html;                             |
    | Context | http, server, location, if in location |

57. `satisfy`

    > 针对 4 大限制模块 `ngx_http_access_module`, `ngx_http_auth_basic_module`, `ngx_http_auth_request_module`, `ngx_http_auth_jwt_module`

    | Syntax  | `satisfy all | any;`   |
    | ------- | ---------------------- |
    | Default | satisfy all;           |
    | Context | http, server, location |

    | 参数 | 描述                                       |
    | ---- | ------------------------------------------ |
    | all  | 4 大模块全部允许访问，客户端才能访问       |
    | any  | 4 大模块其中一个允许访问，客户端就可以访问 |

58. `send_lowat`

    > 该指令在 linux、windows 上被忽略

    | Syntax  | send_lowat size;       |
    | ------- | ---------------------- |
    | Default | send_lowat 0;          |
    | Context | http, server, location |

59. `send_timeout`

    > 设置向客户端传输响应的超时，如果客户端在这段时间内没有收到任何东西，连接将被关闭。

    - 超时仅在两个连续的写操作之间设置，而不用于传输整个响应。

    | Syntax  | send_timeout time;     |
    | ------- | ---------------------- |
    | Default | send_timeout 60s;      |
    | Context | http, server, location |

60. `sendfile`

    > 启用或禁用 sendfile()。

    | Syntax  | `sendfile on | off;`                   |
    | ------- | -------------------------------------- |
    | Default | sendfile off;                          |
    | Context | http, server, location, if in location |

61. `sendfile_max_chunk`

    > 当设置为非零值时，限制可以在单个 sendfile()调用中传输的数据量。如果没有限制，一个快速连接可能会完全占用工作进程。

    | Syntax  | sendfile_max_chunk size; |
    | ------- | ------------------------ |
    | Default | sendfile_max_chunk 0;    |
    | Context | http, server, location   |

62. `server`

    > 设置虚拟服务器的配置。

    | Syntax  | server { ... } |
    | ------- | -------------- |
    | Default | —              |
    | Context | http           |

    - 基于 IP(基于 IP 地址)和基于名称(基于“Host”请求头字段)的虚拟服务器之间没有明显的区别。
    - 相反，listen 指令描述应该接受服务器连接的所有地址和端口，server_name 指令列出所有服务器名。

63. `server_name`

    > 设置虚拟服务器的名称，可以使用正则表达式

    | Syntax  | `server_name name ...;` |
    | ------- | ----------------------- |
    | Default | server_name "";         |
    | Context | server                  |

64. `server_name_in_redirect`

    > 在 nginx 发出的绝对重定向中启用或禁用主服务器名(由 server_name 指令指定)。

    - 当禁用主服务器名时，将使用“Host”请求头字段中的名称。如果不存在此字段，则使用服务器的 IP 地址。

    | Syntax  | server_name_in_redirect on   | off; |
    | ------- | ---------------------------- | ---- |
    | Default | server_name_in_redirect off; |
    | Context | http, server, location       |

65. `server_names_hash_bucket_size`

    > 设置服务器名称哈希表的存储桶大小，默认值取决于处理器缓存行的大小。

    | Syntax  | server_names_hash_bucket_size size;        |
    | ------- | ------------------------------------------ |
    | Default | `server_names_hash_bucket_size 32|64|128;` |
    | Context | http                                       |

66. `server_names_hash_max_size`

    > 设置服务器名称哈希表的最大大小。

67. `server_tokens`

    > 在错误页和“服务器”响应头字段中启用或禁用发出 nginx 版本。

    | Syntax  | `server_tokens on | off | build | string;` |
    | ------- | ------------------------------------------ |
    | Default | server_tokens on;                          |
    | Context | http, server, location                     |

68. `subrequest_output_buffer_size`

    > 设置用于存储子请求的响应体的缓冲区的大小。默认情况下，缓冲区大小等于一个内存页。这是 4K 或 8K，取决于平台。然而，它可以做得更小。

    | Syntax  | subrequest_output_buffer_size size;    |
    | ------- | -------------------------------------- |
    | Default | `subrequest_output_buffer_size 4k|8k;` |
    | Context | http, server, location                 |

69. `tcp_nodelay`

    > 启用或禁用 TCP_NODELAY 选项。当连接转换为 keep-alive 状态时，将启用该选项。此外，它在 SSL 连接上启用，用于非缓冲代理和 WebSocket 代理。

    | Syntax  | `tcp_nodelay on | off;` |
    | ------- | ----------------------- |
    | Default | tcp_nodelay on;         |
    | Context | http, server, location  |

70. `tcp_nopush`

    > 在 Linux 上启用或禁用 TCP_CORK 套接字选项。只有在使用 sendfile 时才启用这些选项。

    | Syntax  | try_files file ... uri;   |
    | ------- | ------------------------- |
    | Syntax  | try_files file ... =code; |
    | Default | —                         |
    | Context | server, location          |

    > 启用该选项允许：
    >
    > - 在 Linux 上以一个包的形式发送响应头和文件开头;
    > - 以完整的包发送文件。

71. `try_files`

    > 按指定顺序检查文件是否存在，并使用第一个找到的文件进行请求处理;处理是在当前上下文中执行的。

    | Syntax  | try_files file ... uri;   |
    | ------- | ------------------------- |
    | Syntax  | try_files file ... =code; |
    | Default | —                         |
    | Context | server, location          |

72. `types`

    > 将文件名扩展名映射到响应的 MIME 类型。扩展是不区分大小写的。多个扩展可以映射到一个类型，例如:

    ```text
    Syntax: 	types { ... }
    Default:
        types {
            text/html  html;
            image/gif  gif;
            image/jpeg jpg;
        }
    Context: 	http, server, location
    ```

73. `types_hash_bucket_size`

    > 设置哈希表类型的桶大小。

    | Syntax  | types_hash_bucket_size size; |
    | ------- | ---------------------------- |
    | Default | types_hash_bucket_size 64;   |
    | Context | http, server, location       |

74. `types_hash_max_size`

    > 设置类型哈希表的最大值

    | Syntax  | types_hash_max_size size; |
    | ------- | ------------------------- |
    | Default | types_hash_max_size 1024; |
    | Context | http, server, location    |

75. `underscores_in_headers`

    > 在客户端请求头字段中启用或禁用下划线。禁用下划线时，名称包含下划线的请求头字段将被标记为无效，并受 ignore_invalid_headers 指令的约束。

    | Syntax  | `underscores_in_headers on | off;` |
    | ------- | ---------------------------------- |
    | Default | underscores_in_headers off;        |
    | Context | http, server                       |

76. `variables_hash_bucket_size`

    > 设置变量哈希表的桶大小。

    | Syntax  | variables_hash_bucket_size size; |
    | ------- | -------------------------------- |
    | Default | variables_hash_bucket_size 64;   |
    | Context | http                             |

77. `variables_hash_max_size`

    > 设置变量哈希表的最大大小

    | Syntax  | variables_hash_max_size size; |
    | ------- | ----------------------------- |
    | Default | variables_hash_max_size 1024; |
    | Context | http                          |

## 嵌入式变量

> ngx_http_core_module 模块支持具有与 Apache 服务器变量匹配的名称的嵌入式变量。

- 首先，这些变量表示客户机请求头字段，如$http_user_agent、$http_cookie 等。
- 还有其他变量:

| 参数                   | 说明                                                                                                                  |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `$arg_name`            | 请求行中的参数名                                                                                                      |
| `$args`                | 请求行中的参数                                                                                                        |
| `$binary_remote_addr`  | 在二进制形式的客户端地址中，值的长度总是 IPv4 地址的 4 字节或 IPv6 地址的 16 字节                                     |
| `$body_bytes_sent`     | 发送到客户端的字节数，不包括响应头;这个变量与 mod_log_config Apache 模块的“%B”参数兼容                                |
| `$bytes_sent`          | 客户端发送的字节数                                                                                                    |
| `$connection`          | 连接序列号 `Content-Length`                                                                                           |
| `$connection_requests` | 通过连接发出的当前请求数                                                                                              |
| `$content_length`      | 请求头字段                                                                                                            |
| `$content_type`        | 请求头字段 `Content-Type`                                                                                             |
| `$cookie_name`         | cookie 名称                                                                                                           |
| `$document_root`       | 当前请求的根或别名指令的值                                                                                            |
| `$document_uri`        | 和 `$url` 一样                                                                                                        |
| `$host`                | 按照这个优先顺序:请求行中的主机名，或者“host”请求头字段中的主机名，或者匹配请求的服务器名                             |
| `$hostname`            | 主机名                                                                                                                |
| `$http_name`           | 任意请求头字段;变量名的最后一部分是转换为小写的字段名，用下划线替换破折号                                             |
| `$https`               | 如果连接在 SSL 模式下运行，则为“on”，否则为空字符串                                                                   |
| `$is_args`             | 如果“?”请求行有参数，或者空字符串                                                                                     |
| `$limit_rate`          | 设置此变量可以限制响应速度;看到 limit_rate                                                                            |
| `$msec`                | 当前时间(秒)，分辨率为毫秒                                                                                            |
| `$nginx_version`       | nginx 版本号                                                                                                          |
| `$pid`                 | 工作进程的 pid                                                                                                        |
| `$pipe`                | 如果请求是流水线的则为 `p`，否则为 `.`                                                                                |
| `$proxy_protocol_addr` | 代理协议头中的客户端地址，或者空字符串                                                                                |
| `$proxy_protocol_port` | 代理协议头中的客户端端口，或者空字符串                                                                                |
| `$query_string`        | 和 `$args` 一样                                                                                                       |
| `$realpath_root`       | 与当前请求的根或别名指令值对应的绝对路径名，所有符号链接都解析为实际路径                                              |
| `$remote_addr`         | 客户端地址                                                                                                            |
| `$remote_port`         | 客户端端口                                                                                                            |
| `$remote_user`         | 提供基本身份验证的用户名                                                                                              |
| `$request`             | 完整的原始请求行                                                                                                      |
| `$request_body`        | 当将请求体读入内存缓冲区时，变量的值在 proxy_pass、fastcgi_pass、uwsgi_pass 和 scgi_pass 指令处理的位置可用。         |
| `$request_body_file`   | 在处理结束时，需要删除具有请求主体的临时文件的名称。                                                                  |
| `$request_completion`  | 如果请求已完成，则为“OK”，否则为空字符串                                                                              |
| `$request_filename`    | 基于根或别名指令和请求 URI 的当前请求的文件路径                                                                       |
| `$request_id`          | 由 16 个随机字节生成的惟一请求标识符，以十六进制表示                                                                  |
| `$request_length`      | 请求长度(包括请求行、头和请求体)                                                                                      |
| `$request_method`      | 请求方法，通常是“GET”或“POST”                                                                                         |
| `$request_time`        | 请求处理时间(以秒为单位，分辨率为毫秒);从客户端读取第一个字节以来的时间                                               |
| `$request_uri`         | 完整的原始请求 URI(带有参数)                                                                                          |
| `$scheme`              | 查询计划，“http”或“https”                                                                                             |
| `$sent_http_name`      | 任意响应报头字段;变量名的最后一部分是转换为小写的字段名，用下划线替换破折号                                           |
| `$sent_trailer_name`   | 响应结束时发送的任意字段;变量名的最后一部分是转换为小写的字段名，用下划线替换破折号                                   |
| `$server_addr`         | 接受请求的服务器地址(计算此变量的值)通常需要一个系统调用。为了避免系统调用，listen 指令必须指定地址并使用 bind 参数。 |
| `$server_name`         | 接受请求的服务器的名称                                                                                                |
| `$server_port`         | 接收请求的服务器端口                                                                                                  |
| `$server_protocol`     | 请求协议 `HTTP/1.0` `HTTP/1.1` `HTTP/2.0`                                                                             |
| `$status`              | 响应状态                                                                                                              |
| `$tcpinfo_rtt`         | 关于客户端 TCP 连接的信息;在支持 TCP_INFO 套接字选项的系统上可用                                                      |
| `$tcpinfo_rttvar`      | 关于客户端 TCP 连接的信息;在支持 TCP_INFO 套接字选项的系统上可用                                                      |
| `$tcpinfo_snd_cwnd`    | 关于客户端 TCP 连接的信息;在支持 TCP_INFO 套接字选项的系统上可用                                                      |
| `$tcpinfo_rcv_space`   | 关于客户端 TCP 连接的信息;在支持 TCP_INFO 套接字选项的系统上可用                                                      |
| `$time_iso8601`        | 本地时间 ISO 8601 标准格式                                                                                            |
| `$time_local`          | 通用日志格式的本地时间                                                                                                |
| `$uri`                 | 请求中的当前 URI，在请求处理期间`$URI`的值可能会发生变化，例如在执行内部重定向时，或者在使用索引文件时。              |
