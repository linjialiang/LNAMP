# httpd 日志

> 为了有效地管理 Web 服务器，有必要获得有关服务器的活动和性能以及可能发生的任何问题的反馈。 `Apache HTTP Server` 提供了非常全面和灵活的日志记录功能。

## httpd 日志概论

> `Apache HTTP Server` 提供了各种不同的机制，用于记录服务器上发生的所有事情，从初始请求到 URL 映射过程，再到连接的最终解决方案，包括流程中可能发生的任何错误。除此之外，第三方模块可以提供日志记录功能，或者将条目注入到现有日志文件中，并且诸如 CGI 程序或 PHP 脚本或其他处理程序之类的应用程序可以向服务器错误日志发送消息。

## 错误日志

> 服务器错误日志（其名称和位置由 ErrorLog 指令设置） 是最重要的日志文件。这是 httpd 将发送诊断信息并记录它在处理请求时遇到的任何错误的地方。当启动服务器或服务器操作出现问题时，它是第一个查看的地方，因为它通常包含错误的详细信息以及如何修复它。

| 所属模块 | 指令           | 描述                                                 |
| -------- | -------------- | ---------------------------------------------------- |
| core     | ErrorLog       | 记录错误日志的文件存放路径（支持绝对路径和相对路径） |
| core     | LogLevel       | 控制 ErrorLog 的详细程度（附录表格）                 |
| core     | ErrorLogFormat | 错误日志写入的格式（附录表格）                       |

1.  ErrorLog，为了统一兼容版和推荐版的错误日志，我们使用绝对路径指定（个别版本仅有推荐版）

    > 所有的错误日志写在一个文件内

    ```shell
    ErrorLog "${HTLOGS}/error/error.log"
    ```

    > 错误日志超过 5M 会截断一次，并且按截断时间来命名

    ```shell
    ErrorLog "|${SRVROOT}/bin/rotatelogs.exe -t ${HTLOGS}/error/error_log.%Y-%m-%d-%H_%M_%S 5M 480"
    ```

2.  LogLevel 大众设置，老手都应该按需来调节它

    ```shell
    LogLevel warn
    ```

3.  ErrorLogFormat，按需设置（很多时候都不需要设置它）

    ```shell
    #Simple example
    ErrorLogFormat "[%t] [%l] [pid %P] %F: %E: [client %a] %M"
    ```

    ```shell
    #Example (default format for threaded MPMs)
    ErrorLogFormat "[%{u}t] [%-m:%l] [pid %P:tid %T] %7F: %E: [client\ %a] %M% ,\ referer\ %{Referer}i"
    ```

    ```shell
    #Example (similar to the 2.2.x format)
    ErrorLogFormat "[%t] [%l] %7F: %E: [client\ %a] %M% ,\ referer\ %{Referer}i"
    ```

    ```shell
    #Advanced example with request/connection log IDs
    ErrorLogFormat "[%{uc}t] [%-m:%-l] [R:%L] [C:%{C}L] %7F: %E: %M"
    ErrorLogFormat request "[%{uc}t] [R:%L] Request %k on C:%{c}L pid:%P tid:%T"
    ErrorLogFormat request "[%{uc}t] [R:%L] UA:'%+{User-Agent}i'"
    ErrorLogFormat request "[%{uc}t] [R:%L] Referer:'%+{Referer}i'"
    ErrorLogFormat connection "[%{uc}t] [C:%{c}L] local\ %a remote\ %A"
    ```

## 本小节附录：

> LogLevel 格式（至少需要指定一个全局的错误日志级别）

```shell
LogLevel [模块标识符:]级别 [模块标识符:级别] ...
```

> LogLevel 调整错误日志中记录的消息的详细程度。共有以下级别可用，按重要性递减顺序：

| 级别字符串 | 描述                      |
| ---------- | ------------------------- |
| emerg      | 紧急情况 - 系统无法使用。 |
| alert      | 必须立即采取行动。        |
| crit       | 关键条件。                |
| error      | 错误条件。                |
| warn       | 警告条件。                |
| notice     | 正常但重要的情况。        |
| info       | 信息化。                  |
| debug      | 调试级消息                |
| trace1     | 跟踪消息                  |
| trace2     | 跟踪消息                  |
| trace3     | 跟踪消息                  |
| trace4     | 跟踪消息                  |
| trace5     | 跟踪消息                  |
| trace6     | 跟踪消息                  |
| trace7     | 跟踪消息，转储大量数据    |
| trace8     | 跟踪消息，转储大量数据    |

> ErrorLogFormat 格式

```shell
ErrorLogFormat [connection|request] [格式1] [格式2] ...
```

| 格式字符串            | 描述                                                                 |
| --------------------- | -------------------------------------------------------------------- |
| `%%`                  | 百分号                                                               |
| `%a`                  | 客户端 IP 地址和请求的端口                                           |
| `%{c}a`               | 底层对等 IP 地址和连接端口（参见 mod_remoteip 模块）                 |
| `%A`                  | 本地 IP 地址和端口                                                   |
| `%{name}e`            | 请求环境变量名称                                                     |
| `%E`                  | APR / OS 错误状态代码和字符串                                        |
| `%F`                  | 源文件名和日志调用的行号                                             |
| `%{name}i`            | 请求标题名称                                                         |
| `%k`                  | 此连接上的保持活动请求数                                             |
| `%l`                  | Loglevel 的消息                                                      |
| `%L`                  | 请求的日志 ID                                                        |
| `%{c}L`               | 连接的日志 ID                                                        |
| `%{C}L`               | 如果在连接范围中使用，则为连接的日志 ID，否则为空                    |
| `%m`                  | 记录消息的模块的名称                                                 |
| `%M`                  | 实际的日志消息                                                       |
| `%{name}n`            | 请求备注名称                                                         |
| `%P`                  | 当前进程的进程 ID                                                    |
| `%T`                  | 当前线程的线程 ID                                                    |
| `%{g}T`               | 当前线程的系统唯一线程 ID（与例如显示的 ID 相同 top;仅限当前 Linux） |
| `%t`                  | 现在的时间                                                           |
| `%{u}t`               | 当前时间包括微秒                                                     |
| `%{cu}t`              | 紧凑型 ISO 8601 格式的当前时间，包括微秒                             |
| `%v`                  | ServerName 当前服务器的规范。                                        |
| `%V`                  | 根据 UseCanonicalName 设置提供请求的服务器的服务器名称 。            |
| `\ (backslash space)` | 非字段分隔空间                                                       |
| `% (percent space)`   | 字段分隔符（无输出）                                                 |

## 访问日志

> 服务器访问日志记录服务器处理的所有请求。访问日志的位置和内容由 CustomLog 指令控制。该 LogFormat 指令可用于简化日志内容的选择。

| 所属模块       | 指令      | 描述                                               |
| -------------- | --------- | -------------------------------------------------- |
| mod_log_config | CustomLog | 控制访问日志的位置和内容（支持绝对路径和相对路径） |
| mod_setenvif   | LogFormat | 设置日志文件的文件名和格式                         |
| mod_setenvif   | SetEnvIf  | 根据请求的属性设置环境变量，用于限制日志输出内容   |

> 访问日志的典型配置可能如下所示：

```shell
LogFormat "%h %l %u %t \"%r\" %>s %b" common
CustomLog ${BASE_ROOT}/logs/apache24/access/access_log common
```

> 默认的访问日志配置代码

```shell
<IfModule log_config_module>
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
    LogFormat "%h %l %u %t \"%r\" %>s %b" common

    <IfModule logio_module>
      LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio
    </IfModule>

    CustomLog "${BASE_ROOT}/logs/apache24/access/access_log" common
</IfModule>
```

> 新增访问日志格式模板，命名为 `newlogformat` 并调用该模板为访问日志输出格式

```shell
<IfModule log_config_module>
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
    LogFormat "%h %l %u %t \"%r\" %>s %b" common
    LogFormat "%h-%v-%V %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" newlogformat

    <IfModule logio_module>
      LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio
    </IfModule>

    CustomLog "${BASE_ROOT}/logs/apache24/access/access_log" newlogformat
</IfModule>
```

> 1.  调用 `newlogformat` 模板为访问日志输出格式
> 2.  创建 `access_log` 访问日志文件并每天截断一次文件（由于每次截断的文件名一致，因此永远只能保留一天的日志）

```shell
<IfModule log_config_module>
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
    LogFormat "%h %l %u %t \"%r\" %>s %b" common
    LogFormat "%h-%v-%V %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" newlogformat

    <IfModule logio_module>
      LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio
    </IfModule>

    CustomLog "|${SRVROOT}/bin/rotatelogs.exe -t ${BASE_ROOT}/logs/apache24/access/access_log 86400 480" newlogformat
</IfModule>
```

> 1.  调用 `newlogformat` 模板为访问日志输出格式；
> 2.  创建 `access_log` 访问日志文件并每天截断一次文件（由于文件名根据时间来创建，因此每天都有一个日志文件被保留）；

```shell
<IfModule log_config_module>
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
    LogFormat "%h %l %u %t \"%r\" %>s %b" common
    LogFormat "%h-%v-%V %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" newlogformat

    <IfModule logio_module>
      LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio
    </IfModule>

    CustomLog "|${SRVROOT}/bin/rotatelogs.exe -t ${BASE_ROOT}/logs/apache24/access/access_log.%Y-%m-%d 86400 480" newlogformat
</IfModule>
```

> 1.  调用 `newlogformat` 模板为访问日志输出格式；
> 2.  创建 `access_log` 访问日志文件并每天截断一次文件（由于文件名根据时间来创建，因此每天都有一个日志文件被保留）；
> 3.  限制图片 js 等文件写入日志；

```shell
<IfModule log_config_module>
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
    LogFormat "%h %l %u %t \"%r\" %>s %b" common
    LogFormat "%h-%v-%V %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" newlogformat

    <IfModule logio_module>
      LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio
    </IfModule>

    SetEnvIf Request_URI "\.(ico|gif|jpg|png|bmp|swf|css|js)$" dontlog

    CustomLog "|${SRVROOT}/bin/rotatelogs.exe -t ${BASE_ROOT}/logs/apache24/access/access_log.%Y-%m-%d 86400 480" newlogformat env=!dontlog
</IfModule>
```

> 访问日志格式字符串

| 格式字符串      | 描述                                                                                                                                                                                                                                         |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `%%`            | 百分号。                                                                                                                                                                                                                                     |
| `%a`            | 请求的客户端 IP 地址（请参阅 mod_remoteip 模块）。                                                                                                                                                                                           |
| `%{c}a`         | 连接的基础对等 IP 地址（请参阅 mod_remoteip 模块）。                                                                                                                                                                                         |
| `%A`            | 本地 IP 地址。                                                                                                                                                                                                                               |
| `%B`            | 响应大小（以字节为单位），不包括 HTTP 头。                                                                                                                                                                                                   |
| `%b`            | 响应大小（以字节为单位），不包括 HTTP 头。在 CLF 格式中，即-没有发送字节时 的' '而不是 0。                                                                                                                                                   |
| `%{VARNAME}C`   | 发送到服务器的请求中的 cookie VARNAME 的内容。仅完全支持版本 0 cookie。                                                                                                                                                                      |
| `%D`            | 服务请求所需的时间，以微秒为单位。                                                                                                                                                                                                           |
| `%{VARNAME}e`   | 环境变量 VARNAME 的内容 。                                                                                                                                                                                                                   |
| `%f`            | 文件名。                                                                                                                                                                                                                                     |
| `%h`            | 远程主机名。如果 HostnameLookups 设置为 Off，将记录 IP 地址，这是默认值。如果它仅记录少数主机的主机名，则可能具有按名称提及它们的访问控制指令。请参阅 Require 主机文档。                                                                     |
| `%H`            | 请求协议。                                                                                                                                                                                                                                   |
| `%{VARNAME}i`   | VARNAME:发送到服务器的请求中标题行的内容。其他模块（例如 mod_headers）所做的更改会影响这一点。如果您对大多数模块修改它之前请求标头的内容感兴趣，请使用 mod_setenvif 将标头复制到内部环境变量中并使用上述描述该值。%{VARNAME}e                |
| `%k`            | 此连接上处理的 keepalive 请求数。有趣的 KeepAlive 是，如果 正在使用，那么，例如，'1'表示在初始一个之后的第一个 keepalive 请求，'2'表示第二个，等等; 否则这始终为 0（表示初始请求）。                                                         |
| `%l`            | 远程日志名称（来自 identd，如果提供）。除非 mod_ident 存在并且 IdentityCheck 已设置， 否则这将返回破折号 On。                                                                                                                                |
| `%L`            | 来自错误日志的请求日志 ID（如果没有将任何内容记录到此请求的错误日志中，则为" - "）。查找匹配的错误日志行以查看哪些请求导致了什么错误。                                                                                                       |
| `%m`            | 请求方法。                                                                                                                                                                                                                                   |
| `%{VARNAME}n`   | 来自另一个模块的 note VARNAME 的内容。                                                                                                                                                                                                       |
| `%{VARNAME}o`   | VARNAME:回复中标题行的内容。                                                                                                                                                                                                                 |
| `%p`            | 服务请求的服务器的规范端口。                                                                                                                                                                                                                 |
| `%{format}p`    | 服务请求的服务器的规范端口，服务器的实际端口或客户端的实际端口。有效的格式 canonical，local 或 remote。                                                                                                                                      |
| `%P`            | 为请求提供服务的子进程 ID。                                                                                                                                                                                                                  |
| `%{format}P`    | 为请求提供服务的子进程 ID 或线程 ID。有效的格式是 pid，tid 和 hextid。 hextid 要求 APR 1.2.0 或更高。                                                                                                                                        |
| `%q`            | 查询字符串（?如果查询字符串存在则前缀，否则为空字符串）。                                                                                                                                                                                    |
| `%r`            | 第一行请求。                                                                                                                                                                                                                                 |
| `%R`            | 生成响应的处理程序（如果有）。                                                                                                                                                                                                               |
| `%s`            | 状态。对于已内部重定向的请求，这是原始请求的状态。使用%>s 的最终状态。                                                                                                                                                                       |
| `%t`            | 收到请求的时间，格式为[18/Sep/2011:19:18:28 -0400]。最后一个数字表示与 GMT 的时区偏移量                                                                                                                                                      |
| `%{format}t`    | 时间，以格式给出的形式，应该是扩展 strftime(3)格式（可能是本地化的）。如果格式以 begin:（默认）开头，则在请求处理开始时进行。如果以它开始， end:则是写入日志条目的时间，接近请求处理的结束。除支持的格式外 strftime(3)，还支持以下格式标记： |
| `%T`            | 服务请求所需的时间，以秒为单位。                                                                                                                                                                                                             |
| `%{UNIT}T`      | 服务请求所用的时间，以时间单位给出 UNIT。有效单位 ms 为毫秒， us 微秒和 s 秒。使用 s 与%T 没有任何格式的结果相同; 使用 us 给出相同的结果%D。%T2.4.13 及更高版本中提供了与单元的组合。                                                        |
| `%u`            | 远程用户，如果请求已通过身份验证。如果返回状态（%s）为 401（未经授权），则可能是伪造的。                                                                                                                                                     |
| `%U`            | 请求的 URL 路径，不包括任何查询字符串。                                                                                                                                                                                                      |
| `%v`            | ServerName 服务请求的服务器的规范。                                                                                                                                                                                                          |
| `%V`            | 服务器名称根据 UseCanonicalName 设置。                                                                                                                                                                                                       |
| `%X`            | 响应完成时的连接状态：                                                                                                                                                                                                                       |
| `%I`            | 收到的字节数，包括请求和标题。不能为零。您需要启用 mod_logio 此功能。                                                                                                                                                                        |
| `%O`            | 发送的字节数，包括标题。在极少数情况下可能为零，例如在发送响应之前请求被中止。您需要启用 mod_logio 此功能。                                                                                                                                  |
| `%S`            | 传输（接收和发送）的字节（包括请求和标头）不能为零。这是％I 和％O 的组合。您需要启用 mod_logio 此功能。                                                                                                                                      |
| `%{VARNAME}^ti` | VARNAME:发送到服务器的请求中的预告片行的内容。                                                                                                                                                                                               |
| `%{VARNAME}^to` | VARNAME:从服务器发送的响应中的预告片行的内容。                                                                                                                                                                                               |
