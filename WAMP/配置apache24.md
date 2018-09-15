# 配置apache24

- `httpd.conf` 是apache24的主配置文件，基本上我们都会在该文件上完成配置
- 注意：apache24下只有正斜杆 `/` 没有反斜杠 `\` （路径都要替换成正斜杆的方式）

## apache24主配置文件 `httpd.conf`

> httpd.conf路径

位数 | 路径
-- | ----------------------------------
32 | `C:/wamp/32/httpd/conf/httpd.conf`
64 | `C:/wamp/64/httpd/conf/httpd.conf`

> 提示： `c:\wamp` 是wamp开发环境的根目录，如果想要更改wamp所在目录只需将其改成真实路径即可，以后不再重复该说明（php、mariadb也是同理的）！

### httpd.conf下配置apache24正确路径

- 描述：默认情况下apache24路径是 `c:/Apache2.4` ，需要修改成apache24当前所在目录
- 注意：新版本开始引入了 `Define` 变量定义，所以我们只需要修改一个位置

位数 | 替换前                            | 替换后
-- | ------------------------------ | --------------------------------------
32 | `Define SRVROOT "c:/Apache24"` | `Define SRVROOT "c:/wamp/32/apache24"`
64 | `Define SRVROOT "c:/Apache24"` | `Define SRVROOT "c:/wamp/64/apache24"`

### httpd.conf下设置路径变量

- 描述：新版apache24推荐使用 `Define` 来定义变量，让配置环境更加清晰、直观！
- 定义格式： `Define 变量名 变量值`
- 使用格式： `${变量名}`

> 定义变量：wamp开发环境根目录变量（ `${WAMPROOT}` ）

位数 | 设置变量
-- | ---------------------------
32 | `Define WAMPROOT "c:/wamp"`
64 | `Define WAMPROOT "c:/wamp"`

> 定义变量：版本目录变量（ `${BITPATH}` ）

位数 | 设置变量
-- | ---------------------------------
32 | `Define BITPATH "${WAMPROOT}/32"`
64 | `Define BITPATH "${WAMPROOT}/64"`

- 说明：如不需要，尽量不要定义变量
- 注意：至少要保证变量 `${WAMPROOT}` `${BITPATH}` 是第一次出现，这是符合逻辑的定义方式！
- 提示：由于 `Define` 是apache24自带的，并不需要模块支持，所以允许定义到配置文件最顶部！

### httpd.conf下为apache24增加子配置文件

- 描述：apache24支持定义子孙配置文件，支持相对路径和绝对路径，我们这里会用到绝对路径
- 格式： `Include 自配置文件路径`

```shell
<IfModule include_module>
    Include "${WAMPROOT}/conf/apache24.conf"
</IfModule>
```

- 警告：由于 `Include` 需要模块 `include_module` 支持，所以我们需要在模块定义之后添加
- 注意：由于自定义的apache24.conf文件会有各种配置，我们建议在模块定义后第一个出现就是该配置文件，这是符合逻辑的定义方式

### 删除httpd.conf多余配置项目

- 删除1：文件里所有注释的行都可以被删除掉
- 删除2：由于apache24支持相对路径，因此 `定义模块之后的内容` 都可以删除或转移到apache24.conf
- 福利：为了能更直观理解apache24配置，我会将模块往后的内容全部挪移到apache24.conf这个子配置文件里

> 兼容版 httpd.conf 内容

```shell
Define WAMPROOT "c:/wamp"
Define BITPATH "${WAMPROOT}/32"
Define SRVROOT "${BITPATH}/apache24"
Define PHPVERSION "php5"

ServerRoot "${SRVROOT}"

Listen 80

LoadModule access_compat_module modules/mod_access_compat.so
LoadModule actions_module modules/mod_actions.so
LoadModule alias_module modules/mod_alias.so
LoadModule allowmethods_module modules/mod_allowmethods.so
LoadModule asis_module modules/mod_asis.so
LoadModule auth_basic_module modules/mod_auth_basic.so
LoadModule authn_core_module modules/mod_authn_core.so
LoadModule authn_file_module modules/mod_authn_file.so
LoadModule authz_core_module modules/mod_authz_core.so
LoadModule authz_groupfile_module modules/mod_authz_groupfile.so
LoadModule authz_host_module modules/mod_authz_host.so
LoadModule authz_user_module modules/mod_authz_user.so
LoadModule autoindex_module modules/mod_autoindex.so
LoadModule cgi_module modules/mod_cgi.so
LoadModule dir_module modules/mod_dir.so
LoadModule env_module modules/mod_env.so
LoadModule include_module modules/mod_include.so
LoadModule isapi_module modules/mod_isapi.so
LoadModule log_config_module modules/mod_log_config.so
LoadModule mime_module modules/mod_mime.so
LoadModule negotiation_module modules/mod_negotiation.so
LoadModule setenvif_module modules/mod_setenvif.so

<IfModule include_module>
    Include "${WAMPROOT}/conf/apache24.conf"
</IfModule>
```

> 推荐版 httpd.conf 内容

```shell
Define WAMPROOT "c:/wamp"
Define BITPATH "${WAMPROOT}/64"
Define SRVROOT "${BITPATH}/apache24"
Define PHPVERSION "php7"

ServerRoot "${SRVROOT}"

Listen 80

LoadModule access_compat_module modules/mod_access_compat.so
LoadModule actions_module modules/mod_actions.so
LoadModule alias_module modules/mod_alias.so
LoadModule allowmethods_module modules/mod_allowmethods.so
LoadModule asis_module modules/mod_asis.so
LoadModule auth_basic_module modules/mod_auth_basic.so
LoadModule authn_core_module modules/mod_authn_core.so
LoadModule authn_file_module modules/mod_authn_file.so
LoadModule authz_core_module modules/mod_authz_core.so
LoadModule authz_groupfile_module modules/mod_authz_groupfile.so
LoadModule authz_host_module modules/mod_authz_host.so
LoadModule authz_user_module modules/mod_authz_user.so
LoadModule autoindex_module modules/mod_autoindex.so
LoadModule cgi_module modules/mod_cgi.so
LoadModule dir_module modules/mod_dir.so
LoadModule env_module modules/mod_env.so
LoadModule include_module modules/mod_include.so
LoadModule isapi_module modules/mod_isapi.so
LoadModule log_config_module modules/mod_log_config.so
LoadModule mime_module modules/mod_mime.so
LoadModule negotiation_module modules/mod_negotiation.so
LoadModule setenvif_module modules/mod_setenvif.so

<IfModule include_module>
    Include "${WAMPROOT}/conf/apache24.conf"
</IfModule>
```

## 配置apache24的子配置文件 `apache24.conf`

> apache24.conf路径

位数 | 路径
-- | ----------------------------
32 | `C:/wamp/conf/apache24.conf`
64 | `C:/wamp/conf/apache24.conf`

### 一、加载必要模块

> 默认并没有将模块全部开启，需要的模块在apache24.conf下加载即可，下面是我经常使用的模块

模块名           | 加载模块
------------- | ----------------------------------------------------------
`mod_alias`   | `LoadModule vhost_alias_module modules/mod_vhost_alias.so`
`mod_rewrite` | `LoadModule rewrite_module modules/mod_rewrite.so`

> 加载模块格式 `LoadModule 模块标识符 模块路径（支持相对路径和绝对路径）`

### 二、为apache24绑定php

> 绑定php需要分两步操作：1）加载php模块；2）获取php配置文件所在目录

#### 解决：php版本差异（配置文件：httpd.conf）

> 由于推荐版和兼容版php版本差异，导致模块标识符不一致，需要通过设置变量来解决

位数 | 设置变量
-- | --------------------------
32 | `Define PHPVERSION "php5"`
64 | `Define PHPVERSION "php7"`

1. 加载php模块

  ```shell
  LoadModule ${PHPVERSION}_module ${BITPATH}/php/${PHPVERSION}apache2_4.dll
  ```

2. 获取php配置文件所在目录（php.ini）

  ```shell
  <IfModule ${PHPVERSION}_module>
  PHPINIDir "${BITPATH}/php"
  </IfModule>
  ```

### ~~题外话： `mod_unixd` 模块~~

> ~~这是Unix系列平台的基本（必需）安全性模块，类unix下属于必须配置项（windows不需要这个）~~

~~属性~~           | ~~描述~~
---------------- | -------------------
~~`User 用户名`~~   | ~~指定apache24的用户~~
~~`Group 用户组名`~~ | ~~指定apache24的用户群组~~

> ~~代码案例~~

```shell
# <IfModule unixd_module>
#     User www
#     Group www
# </IfModule>
```

### 三、设置apache24站点默认配置

> 任何未由virtualhost定义处理的请求都会由该配置响应。这些值会为稍后在文件中定义的任何虚拟主机容器提供缺省值。

1. 设置默认邮箱地址

  > 这个地址出现在一些服务器生成的页面上，比如错误文档。

  ```shell
  ServerAdmin admin@example.com
  ```

2. ~~设置全局主机名~~

  > ~~一般情况下这个不需要配置，除非个人有特殊需要~~

  ```shell
  # ServerName www.example.com:80
  ```

3. 拒绝访问整个服务器的文件系统

  > 如果是服务器这个必须配置，否则整个服务器文件系统都将对访问者开放

  ```shell
  <Directory />
  AllowOverride none
  Require all denied
  </Directory>
  ```

4. 为apache24指定站点缺省位置

  > - apache24未配置VirtualHost的域名会访问第一个VirtualHost配置下的站点目录
  > - `DocumentRoot` 是会被探针识别为站点目录的，安全起见不应该与其它站点设置在同一个根目录下

  ```shell
  DocumentRoot "${WAMPROOT}/www-default"
  ```

  > 为站点缺省位置配置访问权限（不配置会禁止所有人访问--继承于 `<Directory />` 的配置，）

  ```shell
  <Directory "${WAMPROOT}/www-default">
  Options FollowSymLinks
  AllowOverride None
  Require all granted
  </Directory>
  ```

  > 由于apache24的第一个 `<VirtualHost>` 设置的站点目录为 `${WAMPROOT}/www-default` ，因此缺省站点都会访问该目录！

  ```shell
  <VirtualHost *:80>
  DocumentRoot "${WAMPROOT}/www-default"
  </VirtualHost>
  ```

5. 特定区块开放访问权限

  > 通俗讲：指定一个位置，允许访问者访问

  ```shell
  <Directory "${WAMPROOT}/www">
  Options Indexes FollowSymLinks
  AllowOverride All
  Require all granted
  </Directory>
  ```

  > 提示：一般情况下，我们会指定1个存放所有站点的根目录

#### 本节附录：

> `Options` 部分属性值

Options属性值       | 描述        | 服务器建议
---------------- | --------- | -----
`Indexes`        | 允许展示目录式列表 | 关闭
`FollowSymLinks` | 允许访问url链接 | 开启

> `AllowOverride` 部分属性值

AllowOverride属性值 | 描述               | 考虑与建议
---------------- | ---------------- | -----
`None`           | 不允许任何.htaccess规则 | 更安全
`All`            | 允许任何.htaccess规则  | 更方便

### 四、设置apache24在请求目录时将服务的文件

> 我们经常说的，默认文件就是这个这个了

```shell
<IfModule dir_module>
DirectoryIndex index.html index.htm index.php
</IfModule>
```

> 提示：配置多个默认文件，会从左往右索引文件，直到找到为止。无法找到页面将无法显示或输出文件列表

### 五、阻止客户端查看特殊文件

> 一般情况下我们需要阻止 `.htaccess` 和 `.htpasswd` 文件被Web客户端查看

```shell
<Files ".ht*">
Require all denied
</Files>
```

### 六、apache24日志

> 为了有效地管理Web服务器，有必要获得有关服务器的活动和性能以及可能发生的任何问题的反馈。 `Apache HTTP Server` 提供了非常全面和灵活的日志记录功能。

#### apache24日志概论

> `Apache HTTP Server` 提供了各种不同的机制，用于记录服务器上发生的所有事情，从初始请求到URL映射过程，再到连接的最终解决方案，包括流程中可能发生的任何错误。除此之外，第三方模块可以提供日志记录功能，或者将条目注入到现有日志文件中，并且诸如CGI程序或PHP脚本或其他处理程序之类的应用程序可以向服务器错误日志发送消息。

#### 错误日志

> 服务器错误日志（其名称和位置由ErrorLog指令设置） 是最重要的日志文件。这是Apache httpd将发送诊断信息并记录它在处理请求时遇到的任何错误的地方。当启动服务器或服务器操作出现问题时，它是第一个查看的地方，因为它通常包含错误的详细信息以及如何修复它。

所属模块 | 指令             | 描述
---- | -------------- | --------------------------
core | ErrorLog       | 记录错误日志的文件存放路径（支持绝对路径和相对路径）
core | LogLevel       | 控制ErrorLog的详细程度（附录表格）
core | ErrorLogFormat | 错误日志写入的格式（附录表格）

1. ErrorLog，为了统一兼容版和推荐版的错误日志，我们使用绝对路径指定

  > 所有的错误日志写在一个文件内

  ```shell
  ErrorLog "${WAMPROOT}/logs/apache24/error/error.log"
  ```

  > 错误日志超过5M会截断一次，并且按截断时间来命名

  ```shell
  ErrorLog "|${BITPATH}/apache24/bin/rotatelogs.exe -t ${WAMPROOT}/logs/apache24/error/error_log.%Y-%m-%d-%H_%M_%S 5M 480"
  ```

2. LogLevel 大众设置，老手都应该按需来调节它

  ```shell
  LogLevel warn
  ```

3. ErrorLogFormat，按需设置（很多时候都不需要设置它）

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

#### 本小节附录：

> LogLevel 格式（至少需要指定一个全局的错误日志级别）

```shell
LogLevel [模块标识符:]级别 [模块标识符:级别] ...
```

> LogLevel调整错误日志中记录的消息的详细程度。共有以下级别可用，按重要性递减顺序：

级别字符串  | 描述
------ | --------------
emerg  | 紧急情况 - 系统无法使用。
alert  | 必须立即采取行动。
crit   | 关键条件。
error  | 错误条件。
warn   | 警告条件。
notice | 正常但重要的情况。
info   | 信息化。
debug  | 调试级消息
trace1 | 跟踪消息
trace2 | 跟踪消息
trace3 | 跟踪消息
trace4 | 跟踪消息
trace5 | 跟踪消息
trace6 | 跟踪消息
trace7 | 跟踪消息，转储大量数据
trace8 | 跟踪消息，转储大量数据

> ErrorLogFormat 格式

```shell
ErrorLogFormat [connection|request] [格式1] [格式2] ...
```

格式字符串                 | 描述
--------------------- | --------------------------------------
`%%`                  | 百分号
`%a`                  | 客户端IP地址和请求的端口
`%{c}a`               | 底层对等IP地址和连接端口（参见 mod_remoteip模块）
`%A`                  | 本地IP地址和端口
`%{name}e`            | 请求环境变量名称
`%E`                  | APR / OS错误状态代码和字符串
`%F`                  | 源文件名和日志调用的行号
`%{name}i`            | 请求标题名称
`%k`                  | 此连接上的保持活动请求数
`%l`                  | Loglevel的消息
`%L`                  | 请求的日志ID
`%{c}L`               | 连接的日志ID
`%{C}L`               | 如果在连接范围中使用，则为连接的日志ID，否则为空
`%m`                  | 记录消息的模块的名称
`%M`                  | 实际的日志消息
`%{name}n`            | 请求备注名称
`%P`                  | 当前进程的进程ID
`%T`                  | 当前线程的线程ID
`%{g}T`               | 当前线程的系统唯一线程ID（与例如显示的ID相同top;仅限当前Linux）
`%t`                  | 现在的时间
`%{u}t`               | 当前时间包括微秒
`%{cu}t`              | 紧凑型ISO 8601格式的当前时间，包括微秒
`%v`                  | ServerName 当前服务器的规范。
`%V`                  | 根据UseCanonicalName 设置提供请求的服务器的服务器名称 。
`\ (backslash space)` | 非字段分隔空间
`% (percent space)`   | 字段分隔符（无输出）

#### 访问日志

> 服务器访问日志记录服务器处理的所有请求。访问日志的位置和内容由CustomLog 指令控制。该LogFormat 指令可用于简化日志内容的选择。

所属模块           | 指令        | 描述
-------------- | --------- | -------------------------
mod_log_config | CustomLog | 控制访问日志的位置和内容（支持绝对路径和相对路径）
mod_setenvif   | LogFormat | 设置日志文件的文件名和格式
mod_setenvif   | SetEnvIf  | 根据请求的属性设置环境变量，用于限制日志输出内容

> 访问日志的典型配置可能如下所示：

```shell
LogFormat "%h %l %u %t \"%r\" %>s %b" common
CustomLog ${WAMPROOT}/logs/apache24/access/access_log common
```

> 默认的访问日志配置代码

```shell
<IfModule log_config_module>
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
    LogFormat "%h %l %u %t \"%r\" %>s %b" common

    <IfModule logio_module>
      LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio
    </IfModule>

    CustomLog "${WAMPROOT}/logs/apache24/access/access_log" common
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

    CustomLog "${WAMPROOT}/logs/apache24/access/access_log" newlogformat
</IfModule>
```

> 1. 调用 `newlogformat` 模板为访问日志输出格式
> 2. 创建 `access_log` 访问日志文件并每天截断一次文件（由于每次截断的文件名一致，因此永远只能保留一天的日志）

```shell
<IfModule log_config_module>
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
    LogFormat "%h %l %u %t \"%r\" %>s %b" common
    LogFormat "%h-%v-%V %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" newlogformat

    <IfModule logio_module>
      LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio
    </IfModule>

    CustomLog "|${BITPATH}/apache24/bin/rotatelogs.exe -t ${WAMPROOT}/logs/apache24/access/access_log 86400 480" newlogformat
</IfModule>
```

> 1. 调用 `newlogformat` 模板为访问日志输出格式；
> 2. 创建 `access_log` 访问日志文件并每天截断一次文件（由于文件名根据时间来创建，因此每天都有一个日志文件被保留）；

```shell
<IfModule log_config_module>
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
    LogFormat "%h %l %u %t \"%r\" %>s %b" common
    LogFormat "%h-%v-%V %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" newlogformat

    <IfModule logio_module>
      LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio
    </IfModule>

    CustomLog "|${BITPATH}/apache24/bin/rotatelogs.exe -t ${WAMPROOT}/logs/apache24/access/access_log.%Y-%m-%d 86400 480" newlogformat
</IfModule>
```

> 1. 调用 `newlogformat` 模板为访问日志输出格式；
> 2. 创建 `access_log` 访问日志文件并每天截断一次文件（由于文件名根据时间来创建，因此每天都有一个日志文件被保留）；
> 3. 限制图片js等文件写入日志；

```shell
<IfModule log_config_module>
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
    LogFormat "%h %l %u %t \"%r\" %>s %b" common
    LogFormat "%h-%v-%V %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" newlogformat

    <IfModule logio_module>
      LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio
    </IfModule>

    SetEnvIf Request_URI "\.(ico|gif|jpg|png|bmp|swf|css|js)$" dontlog

    CustomLog "|${BITPATH}/apache24/bin/rotatelogs.exe -t ${WAMPROOT}/logs/apache24/access/access_log.%Y-%m-%d 86400 480" newlogformat env=!dontlog
</IfModule>
```

> 访问日志格式字符串

格式字符串           | 描述
--------------- | -------------------------------------------------------------------------------------------------------------------------------------
`%%`            | 百分号。
`%a`            | 请求的客户端IP地址（请参阅 mod_remoteip模块）。
`%{c}a`         | 连接的基础对等IP地址（请参阅 mod_remoteip模块）。
`%A`            | 本地IP地址。
`%B`            | 响应大小（以字节为单位），不包括HTTP头。
`%b`            | 响应大小（以字节为单位），不包括HTTP头。在CLF格式中，即-没有发送字节时 的' '而不是0。
`%{VARNAME}C`   | 发送到服务器的请求中的cookie VARNAME的内容。仅完全支持版本0 cookie。
`%D`            | 服务请求所需的时间，以微秒为单位。
`%{VARNAME}e`   | 环境变量VARNAME的内容 。
`%f`            | 文件名。
`%h`            | 远程主机名。如果HostnameLookups设置为 Off，将记录IP地址，这是默认值。如果它仅记录少数主机的主机名，则可能具有按名称提及它们的访问控制指令。请参阅Require主机文档。
`%H`            | 请求协议。
`%{VARNAME}i`   | VARNAME:发送到服务器的请求中标题行的内容。其他模块（例如mod_headers）所做的更改会影响这一点。如果您对大多数模块修改它之前请求标头的内容感兴趣，请使用mod_setenvif 将标头复制到内部环境变量中并使用上述描述该值。%{VARNAME}e
`%k`            | 此连接上处理的keepalive请求数。有趣的KeepAlive是，如果 正在使用，那么，例如，'1'表示在初始一个之后的第一个keepalive请求，'2'表示第二个，等等; 否则这始终为0（表示初始请求）。
`%l`            | 远程日志名称（来自identd，如果提供）。除非mod_ident存在并且IdentityCheck已设置， 否则这将返回破折号On。
`%L`            | 来自错误日志的请求日志ID（如果没有将任何内容记录到此请求的错误日志中，则为" - "）。查找匹配的错误日志行以查看哪些请求导致了什么错误。
`%m`            | 请求方法。
`%{VARNAME}n`   | 来自另一个模块的note VARNAME的内容。
`%{VARNAME}o`   | VARNAME:回复中标题行的内容。
`%p`            | 服务请求的服务器的规范端口。
`%{format}p`    | 服务请求的服务器的规范端口，服务器的实际端口或客户端的实际端口。有效的格式canonical，local或remote。
`%P`            | 为请求提供服务的子进程ID。
`%{format}P`    | 为请求提供服务的子进程ID或线程ID。有效的格式是pid，tid和hextid。 hextid要求APR 1.2.0或更高。
`%q`            | 查询字符串（?如果查询字符串存在则前缀，否则为空字符串）。
`%r`            | 第一行请求。
`%R`            | 生成响应的处理程序（如果有）。
`%s`            | 状态。对于已内部重定向的请求，这是原始请求的状态。使用%>s 的最终状态。
`%t`            | 收到请求的时间，格式为[18/Sep/2011:19:18:28 -0400]。最后一个数字表示与GMT的时区偏移量
`%{format}t`    | 时间，以格式给出的形式，应该是扩展strftime(3)格式（可能是本地化的）。如果格式以begin:（默认）开头，则在请求处理开始时进行。如果以它开始， end:则是写入日志条目的时间，接近请求处理的结束。除支持的格式外strftime(3)，还支持以下格式标记：
`%T`            | 服务请求所需的时间，以秒为单位。
`%{UNIT}T`      | 服务请求所用的时间，以时间单位给出 UNIT。有效单位ms为毫秒， us微秒和s秒。使用s与%T 没有任何格式的结果相同; 使用us给出相同的结果%D。%T2.4.13及更高版本中提供了与单元的组合。
`%u`            | 远程用户，如果请求已通过身份验证。如果返回状态（%s）为401（未经授权），则可能是伪造的。
`%U`            | 请求的URL路径，不包括任何查询字符串。
`%v`            | ServerName 服务请求的服务器的规范。
`%V`            | 服务器名称根据UseCanonicalName设置。
`%X`            | 响应完成时的连接状态：
`%I`            | 收到的字节数，包括请求和标题。不能为零。您需要启用mod_logio此功能。
`%O`            | 发送的字节数，包括标题。在极少数情况下可能为零，例如在发送响应之前请求被中止。您需要启用mod_logio此功能。
`%S`            | 传输（接收和发送）的字节（包括请求和标头）不能为零。这是％I和％O的组合。您需要启用mod_logio此功能。
`%{VARNAME}^ti` | VARNAME:发送到服务器的请求中的预告片行的内容。
`%{VARNAME}^to` | VARNAME:从服务器发送的响应中的预告片行的内容。

### 七、3组不需要特别修改的默认配置

> 这几组都是默认配置，我们将配置移除掉了

```shell
<IfModule alias_module>
    ScriptAlias /cgi-bin/ "${SRVROOT}/cgi-bin/"
</IfModule>

<Directory "${SRVROOT}/cgi-bin">
    AllowOverride None
    Options None
    Require all granted
</Directory>

<IfModule headers_module>
    RequestHeader unset Proxy early
</IfModule>
```

### 八、为php关联扩展名（支持多个扩展名）

> 操作：在 `<IfModule mime_module>` 内新增一行代码

```shell
<IfModule mime_module>
    TypesConfig conf/mime.types

    AddType application/x-compress .Z
    AddType application/x-gzip .gz .tgz
    AddType application/x-httpd-php .php
</IfModule>
```

> 格式： `AddType application/x-httpd-php [.扩展名1] [.扩展名2] ...`

### 九、2组不需要特别修改的默认配置

```shell
<IfModule proxy_html_module>
    Include conf/extra/proxy-html.conf
</IfModule>

<IfModule ssl_module>
    SSLRandomSeed startup builtin
    SSLRandomSeed connect builtin
</IfModule>
```

### 十、为apache24虚拟主机配置文件指定存放目录

> 说明：虚拟主机配置文件其实就是，apache24的子孙配置文件

```shell
<IfModule include_module>
    Include "${WAMPROOT}/sites/*.conf"
</IfModule>
```

> 提示：Include 支持简单的正则表达式

### apache24.conf内容

> 兼容版和推荐版用的都是同一个apache24.conf配置文件

```shell
# 见配置文件 c:/wamp/conf/apache24.conf
```

## 虚拟主机相关配置

> 这里我主要讲解2个内容：1）别名配置；2）虚拟主机配置

### 一、别名配置

> 站点配置目录下新建文件 `phpmyadmin.conf` ，下面直接贴代码：

```shell
Alias /phpmyadmin ${WAMPROOT}/phpmyadmin
<Directory ${WAMPROOT}/phpmyadmin>
    Options FollowSymLinks
    DirectoryIndex index.php
    <RequireAll>
        Require local
    </RequireAll>
</Directory>
<Directory ${WAMPROOT}/phpmyadmin/libraries>
    Require all denied
</Directory>
<Directory ${WAMPROOT}/phpmyadmin/setup/lib>
    Require all denied
</Directory>
```

### 二、配置虚拟主机

> 站点配置目录下新建 `.conf` 扩展的文件，下面直接贴代码：

```shell
<VirtualHost *:80>
    ServerAdmin admin@example.com
    DocumentRoot "${WAMPROOT}/www/www_test_com"
    ServerName www.test1.com
    ServerAlias www.test1.com test1.com www.test2.com test2.com
    ErrorDocument 404 /Error.html

    ErrorLog "${WAMP}/logs/apache24/域名1-error.log"
    CustomLog "${WAMP}/logs/apache24/域名1-access.log" common

    RewriteEngine on
    RewriteCond %{HTTP_HOST} ^test1.com$ [NC]
    RewriteRule ^(.*)$ http://www.%{HTTP_HOST}$1 [R=301,L]
    RewriteCond %{HTTP_HOST} ^test2.com$ [NC]
    RewriteRule ^(.*)$ http://www.%{HTTP_HOST}$1 [R=301,L]
</VirtualHost>
```

> 最简洁虚拟主机配置

```shell
<VirtualHost *:80>
    DocumentRoot "${WAMPROOT}/www/www_test_com"
    ServerName www.test1.com
</VirtualHost>
```

> ssl版配置

```shell
<VirtualHost *:80>
    ServerName www.test.com
    ServerAlias test.com www.test.com
    DocumentRoot "${WAMPROOT}/www/www_test_com"

    RewriteEngine on
    RewriteCond %{SERVER_PORT} 80 [NC]
    RewriteRule ^(.*)$ https://%{HTTP_HOST}$1 [R=301,L]
</VirtualHost>

<virtualhost *:443>
    ServerName www.test.com
    ServerAlias test.com www.test.com
    DocumentRoot "${WAMPROOT}/www/www_test_com"

    RewriteEngine on
    RewriteCond %{HTTP_HOST} ^test.com$ [NC]
    RewriteRule ^(.*)$ https://www.%{HTTP_HOST}$1 [R=301,L]

    SSLEngine on
    SSLCertificateFile 路径/2_www.test.com.crt
    SSLCertificateKeyFile 路径/3_www.test.com.key
    SSLCertificateChainFile 路径/1_root_bundle.crt
</virtualhost>
```

### 三、将域名绑定到本地

> windows开发环境只有在系统文件 `hosts` 下加入指定的域名，网站才能正常访问！

```hosts
# 在底部新增几行内容
127.0.0.1 test.com www.test.com
127.0.0.1 test1.com www.test1.com
127.0.0.1 test2.com www.test2.com
```

> 文件路径： `c:\Windows\System32\drivers\etc\hosts`

## 新版apache24访问控制

> 我们常用到的主要集中于 `Require` `<RequireAll>` `<RequireAny>` `<RequireNone>` 这四种指令的相互结合

command         | 所属          | 描述
--------------- | ----------- | ----------------------------------------
`Require`       | 访问授权指令      | 写入授权容器内的规则
`<RequireAll>`  | 访问授权指令组合的容器 | 用于包含一组授权指令，并且必须全部是否定的，
`<RequireAny>`  | 访问授权指令组合的容器 | 用于包含一组授权指令，其中一个必须成功才能使`<requireany>`指令成功
`<RequireNone>` | 访问授权指令组合的容器 | 在此元素中包含的规则，所有规则取反

### 访问授权指令 `Require`

> 指令格式：`Require [not] entity-name [entity-name] ...`

访问授权指令        | 功能
------------- | --------
`Require`     | 允许访问授权指令
`Require not` | 拒绝访问授权指令

> `Require not` 是 `Require` 的反操作指令，`Require` 是允许访问授权 `Require not` 就是拒绝访问授权，因此 `Require not` 不再举例！下面是Require的使用区块：

数量 | 使用区块
-- | --------------------------------------------------------------------
单条 | 允许现在 `<Directory>` `<Files>` `<Location>` 3个区块以及 `.htaccess` 文件内
组合 | 组合指令必须写入 `<RequireAll>` `<RequireAny>` `<RequireNone>` 这3个授权指令组合的容器中

> 常用的 `Require` 访问授权指令列表：

Require command                                   | 描述
------------------------------------------------- | -------------------------------------------------
`Require all granted`                             | 无条件允许访问
`Require all denied`                              | 无条件拒绝访问
`Require local`                                   | 允许匹配源自本地主机的连接
`Require method {method1 [method2] [method3]...}` | 仅允许对给定的HTTP方法进行访问
`Require env env-var [env-var] ...`               | 仅当设置了一个给定的环境变量时才允许访问
`Require expr expression`                         | 如果expression的计算结果为true，则允许访问
`Require user userid [userid] ...`                | 只有指定的用户才能访问该资源
`Require group group-name [group-name] ...`       | 只有命名组中的用户才能访问该资源
`Require valid-user`                              | 所有有效用户都可以访问该资源
`Require host .net example.edu`                   | 顶级域名是 `.net` 的所有域名， `example.edu` 自身及子孙域名都可以访问该资源
`Require forward-dns host-name`                   | 根据主机名来判断该ip是否允许访问资源（这个有点复杂）

> `Require ip` 访问授权指令列表：

Require ip command                         | 描述
------------------------------------------ | --------------------
`Require ip ip-address1 [ip-address2] ...` | Require ip 指令格式
`Require ip 1.2.3.0`                       | 指定IP地址范围内的客户端可以访问该资源
`Require ip 1.2.3.10 1.2.3.11`             | 指定多个ip地址对应的客户端访问该资源
`Require ip 10 172.20 192.168.2`           | 指定部分ip地址对应的客户端访问该资源
`Require ip 10.1.0.0/255.255.0.0`          | 指定网络/网络掩码对的客户端访问该资源。
`Require ip 10.1.0.0/16`                   | 指定IP段内的客户端访问该资源。
`Require ip 2001:db8::a00:20ff:fea7:ccea`  | 可以指定IPv6地址和IPv6子网
`Require ip 2001:db8:1:1::a`               | 可以指定IPv6地址和IPv6子网
`Require ip 2001:db8:2:1::/64`             | 可以指定IPv6地址和IPv6子网
`Require ip 2001:db8:3::/48`               | 可以指定IPv6地址和IPv6子网

### 访问授权指令组合的容器

> 访问授权指令组合的容器格式

```shell
## 基本格式，支持容器嵌套
<RequireAll>
    ...
    <RequireAny>
        <RequireNone>
            ...
        </RequireNone>
        ...
    </RequireAny>
</RequireAll>

## <VirtualHost> 区块下需要封装进 `<Location>` 容器
<Location>
    <RequireAll>
        ...
    </RequireAll>
</Location>
```

> 访问授权指令组合的容器使用区块

容器              | 使用区块
--------------- | --------------------
`<RequireAll>`  | directory, .htaccess
`<RequireAny>`  | directory, .htaccess
`<RequireNone>` | directory, .htaccess

> 访问授权指令组合的存放容器有3个： `<RequireAll>` `<RequireAny>` `<RequireNone>` ，允许彼此结合并通过 `Require` 访问授权指令来表达复杂的授权逻辑。

访问授权指令组合的容器     | `Require not`支持情况 | 优先 | 允许访问              | 拒绝访问              | 无效
--------------- | ----------------- | -- | ----------------- | ----------------- | -----------
`<RequireAll>`  | 支持                | 拒绝 | 没有匹配到拒绝，至少匹配到1条允许 | 至少匹配到1条拒绝         | 拒绝和允许都没有匹配到
`<RequireAny>`  | 不支持               | 成功 | 匹配到1条允许           | 没有匹配到允许，至少匹配到1条拒绝 | 拒绝和允许都没有匹配到
`<RequireNone>` | 不支持               | 拒绝 | 全部条件允许            | 全部条件只要一条没有匹配到     | 只有拒绝访问，没有无效

## apache24附录表：

> apache24指令合法区块说明

区块（Context）     | 说明
--------------- | -----------------------------------------------------------------------------
`server config` | 只支持配置在主配置文件和子孙配置文件内！不允许： 1） `<VirtualHost> <Directory>` 区域内；2） `.htaccess` 文件
`virtual host`  | 指令可以出现在 `<VirtualHost>` 容器中
`directory`     | 指令允许出现在后面这些容器中： `<Directory> <Location> <Files> <If> <Proxy>`
`.htaccess`     | 指令允许出现在每个站点目录下的 `.htaccess` 文件

> 常用容器的合法区块汇总列表：

容器                 | 区块（Context）
------------------ | -------------------------------------------------
`<Directory>`      | server config, virtual host
`<DirectoryMatch>` | server config, virtual host
`<Files>`          | server config, virtual host, directory, .htaccess
`<FilesMatch>`     | server config, virtual host, directory, .htaccess
`<If>`             | server config, virtual host, directory, .htaccess
`<IfDefine>`       | server config, virtual host, directory, .htaccess
`<IfModule>`       | server config, virtual host, directory, .htaccess
`<IfVersion>`      | server config, virtual host, directory, .htaccess
`<Location>`       | server config, virtual host
`<LocationMatch>`  | server config, virtual host
`<MDomainSet>`     | server config
`<Proxy>`          | server config, virtual host
`<ProxyMatch>`     | server config, virtual host
`<VirtualHost>`    | server config

## 结束语

> 关于apache24的配置讲解到此就为止，想要深入学习，建议去[apache24官网查看手册](https://httpd.apache.org/docs/2.4/)！
