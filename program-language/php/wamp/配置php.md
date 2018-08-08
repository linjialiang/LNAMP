# 配置php

> 开发环境只需要对php做简单配置

## 关于php配置文件 `php.ini`

> php根目录下有两个配置文件模板，我们复制其中1个并重命名为 `php.ini` 即可！

配置文件模板                | 描述
--------------------- | --------
`php.ini-development` | 开发环境推荐模板
`php.ini-production`  | 部署环境推荐模板

> 由于我们是开发环境，所以选择复制php.ini-development并重命名为php.ini（我们基本都在这个文件上修改）！

## php绑定apache24服务器

> 该节内容已经在 <配置apache24.md> 上说明过，这里不再重复

## 关于php模块

> php里的模块一节，需要通过我们配置才能正常运行

### 为php模块默认目录配置正确路径

> Windows系统默认情况下php扩展的默认存放目录是 `c:\php\etc`，我们需要修改成正确的目录路径

位数 | 所在行  | 修改前                       | 修改后
-- | ---- | ------------------------- | --------------------------------------
32 | 734行 | `; extension_dir = "ext"` | `extension_dir = "c:\wamp\32\php\etc"`
64 | 732行 | `; extension_dir = "ext"` | `extension_dir = "c:\wamp\64\php\etc"`

### 开启几个默认的并且重要的php扩展

> 那些重要的php官方扩展都在etc存放着，并且php.ini都已经写入了，只是默认都被注释掉，我们只需要将备注去掉即可，下面是一些常用扩展：

常用扩展                | 说明
------------------- | ------------------------------------------------------
`php_gd2.dll`       | php对图像处理的扩展
`php_mbstring.dll`  | php对多字节的支持（多国语言并存就意味着多字节）
`php_exif.dll`      | 让php可以操作图像元数据
`php_mysqli.dll`    | php对mysql的mysqli语法支持
`php_openssl.dll`   | php开启对openssl支持
`php_pdo_mysql.dll` | php对mysql支持pdo语法支持
`php_tidy.dll`      | php内置的html格式化/美化tidy函数
`php_xdebug.dll`    | php开发环境下的报错美化扩展，需去[xdebug官网](https://xdebug.org)下载对应版本

> php扩展写入php.ini格式

扩展文件名               | 格式1                             | 格式2
------------------- | ------------------------------- | -----------------------
`php_别名.dll`        | `extension=php_别名.dll`          | `extension=别名`
`php_mbstring.dll`  | `extension=php_mbstring.dll`    | `extension=mbstring`
`php_mysqli.dll`    | `extension=php_mysqli.dll`      | `extension=mysqli`
`php_pdo_mysql.dll` | `extension=php_pdo_mysql.dll`   | `extension=pdo_mysql`
`php_xdebug.dll`    | `zend_extension=php_xdebug.dll` | `zend_extension=xdebug`

> 由于xdebug的驱动程序与其它官方自带扩展不同，我们建议将其写在 php.ini 最下方，写法如下：

```shell
[xdebug]
zend_extension=xdebug
...
# 这里是一些xdebug的配置信息，具体查看相关说明
...
```

> 提示：php重要的扩展远不止这些，只有需要用到我们再开启它们。

## wamp开发环境下的php其它设置

> 虽然php.ini-development模板对开发环境做了推荐配置，但是有些时候我们需要灵活的测试，这就需要我们对一些配置有些了解

### php错误提示

> php.ini通过对display_errors的设置控制是否对php语法错误进行提示，默认开启错误提示

指令                   | 错误提示
-------------------- | ------
`display_errors=On`  | 开启错误提示
`display_errors=Off` | 关闭错误提示

### php错误提示级别

> php通过error_reporting的设置控制错误提示级别，格式如下：

```shell
; php.ini配置文件内格式
error_reporting=错误级别别名

; .php扩展文件内格式
error_reporting(错误级别别名与位运算符组合);
```

> [错误级别一览表](http://php.net/manual/zh/errorfunc.constants.php)

error-id | error-name          | 描述
-------- | ------------------- | -------------------------------------
1        | E_ERROR             | 致命的运行时错误
2        | E_WARNING           | 运行时警告
4        | E_PARSE             | 编译时语法解析错误
8        | E_NOTICE            | 运行时通知
16       | E_CORE_ERROR        | 在PHP初始化启动过程中发生的致命错误
32       | E_CORE_WARNING      | PHP初始化启动过程中发生的警告
64       | E_COMPILE_ERROR     | 致命编译时错误。
128      | E_COMPILE_WARNING   | 编译时警告
256      | E_USER_ERROR        | 用户产生的错误信息。
512      | E_USER_WARNING      | 用户产生的警告信息。
1024     | E_USER_NOTICE       | 用户产生的通知信息。
2048     | E_STRICT            | 启用 PHP 对代码的修改建议。
4096     | E_RECOVERABLE_ERROR | 可被捕捉的致命错误。
8192     | E_DEPRECATED        | 运行时通知
16384    | E_USER_DEPRECATED   | 用户产少的警告信息。
30719    | E_ALL               | 支持的所有错误和警告，但PHP 5.4.0之前的级别E_STRICT除外。

> 可以使用 [php位运算符规则](http://php.net/manual/zh/language.operators.bitwise.php) 来组合这些值或者屏蔽某些类型的错误

command    | alias_name      | 结果
---------- | --------------- | ----------------------------------
`$a & $b`  | And（按位与）        | 将把 $a 和 $b 中都为 1 的位设为 1。
`$a 1 $b`  | Or（按位或）         | 将把 $a 和 $b 中任何一个为 1 的位设为 1。
`$a ^ $b`  | Xor（按位异或）       | 将把 $a 和 $b 中一个为 1 另一个为 0 的位设为 1。
`~ $a`     | Not（按位取反）       | 将 $a 中为 0 的位设为 1，反之亦然。
`$a << $b` | Shift left（左移）  | 将 $a 中的位向左移动 $b 次（每一次移动都表示"乘以 2"）。
`$a >> $b` | Shift right（右移） | 将 $a 中的位向右移动 $b 次（每一次移动都表示"除以 2"）。

> 提示：在php.ini配置文件里，只支持 `|` `~` `!` `^` `&` 这5个位运算符

1. php.ini配置文件版

  > 说明：错误达到指定的错误级别才会提示错误报告，下面是案例：

  ```shell
  # 报告所有php错误
  error_reporting = E_ALL

  # 报告所有php错误，但是忽略：1）运行时通知；2）PHP对代码的修改建议
  E_ALL & ~E_DEPRECATED & ~E_STRICT
  ```

  > 注意：只能一个设置生效，所以php.ini文件里不要出现多个

2. `.php`扩展文件内格式

  > 运用场景：一般是某个.php扩展文件执行时遇到问题，针对当前文件开启调试功能，下面是案例：

  ```php
  // <?php
  // 关闭错误报告
  error_reporting(0);

  // 报告 runtime 错误
  error_reporting(E_ERROR | E_WARNING | E_PARSE);

  // 报告所有错误
  error_reporting(E_ALL);

  // 等同 error_reporting(E_ALL);
  ini_set("error_reporting", E_ALL);

  // 报告 E_NOTICE 之外的所有错误
  error_reporting(E_ALL & ~E_NOTICE);
  ```

  > 允许覆盖php.ini对应配置，只能一个设置生效，并且需要放在最靠近 `<?php` 的位置！

## `php.ini` 文件其它配置附录

> 文件上传相关配置列表：

command                    | 描述
-------------------------- | ---------------------------------
`file_uploads = On`        | 允许HTTP文件上传
`file_uploads = Off`       | 禁止HTTP文件上传
`upload_tmp_dir = 指令目录`    | 用于HTTP上载文件的临时目录（如果没有指定的话，将使用系统默认）
`upload_max_filesize = 2M` | 上传文件的最大允许大小为2M
`max_file_uploads = 20`    | 可以通过单个请求上传的最大文件数量
`post_max_size = 8M`       | PHP将接受的POST数据的最大大小。

> php执行脚本相关

command                   | 描述
------------------------- | -------------------------------------------------------------------
`max_execution_time = 30` | 每个脚本的最大执行时间，以秒为单位（30秒）
`max_input_time = 60`     | 每个脚本可能花费解析请求数据的最长时间，以秒为单位（60秒）。为了消除意外的长时间运行脚本，将这段时间限制在生产服务器上是一个好主意。
`memory_limit = 128M`     | 脚本可能消耗的最大内存数量（128 MB）

## 删除 `php.ini` 多余的配置

> 主要就是删除php.ini文件下的备注行，下面展示php.ini文件的所有内容

1. 32位php的php.ini文件内容

```shell
[PHP]
engine = On
short_open_tag = Off
asp_tags = Off
precision = 14
output_buffering = 4096
zlib.output_compression = Off
implicit_flush = Off
unserialize_callback_func =
serialize_precision = 17
disable_functions =
disable_classes =
zend.enable_gc = On
expose_php = On
max_execution_time = 30
max_input_time = 60
memory_limit = 128M
error_reporting = E_ALL
display_errors = On
display_startup_errors = On
log_errors = On
log_errors_max_len = 1024
ignore_repeated_errors = Off
ignore_repeated_source = Off
report_memleaks = On
track_errors = On
html_errors = On
variables_order = "GPCS"
request_order = "GP"
register_argc_argv = Off
auto_globals_jit = On
post_max_size = 8M
auto_prepend_file =
auto_append_file =
default_mimetype = "text/html"
default_charset = "UTF-8"
doc_root =
user_dir =
extension_dir = "c:\wamp\32\php\ext"
enable_dl = Off
extension=mbstring
extension=mysqli
extension=pdo_mysql
file_uploads = On
upload_max_filesize = 2M
max_file_uploads = 20
allow_url_fopen = On
allow_url_include = Off
default_socket_timeout = 60

[CLI Server]
cli_server.color = On

[Date]

[filter]

[iconv]

[intl]

[sqlite3]

[Pcre]

[Pdo]

[Pdo_mysql]
pdo_mysql.cache_size = 2000
pdo_mysql.default_socket=

[Phar]

[mail function]
SMTP = localhost
smtp_port = 25
mail.add_x_header = On

[SQL]
sql.safe_mode = Off

[ODBC]
odbc.allow_persistent = On
odbc.check_persistent = On
odbc.max_persistent = -1
odbc.max_links = -1
odbc.defaultlrl = 4096
odbc.defaultbinmode = 1

[Interbase]
ibase.allow_persistent = 1
ibase.max_persistent = -1
ibase.max_links = -1
ibase.timestampformat = "%Y-%m-%d %H:%M:%S"
ibase.dateformat = "%Y-%m-%d"
ibase.timeformat = "%H:%M:%S"

[MySQL]
mysql.allow_local_infile = On
mysql.allow_persistent = On
mysql.cache_size = 2000
mysql.max_persistent = -1
mysql.max_links = -1
mysql.default_port =
mysql.default_socket =
mysql.default_host =
mysql.default_user =
mysql.default_password =
mysql.connect_timeout = 60
mysql.trace_mode = Off

[MySQLi]
mysqli.max_persistent = -1
mysqli.allow_persistent = On
mysqli.max_links = -1
mysqli.cache_size = 2000
mysqli.default_port = 3306
mysqli.default_socket =
mysqli.default_host =
mysqli.default_user =
mysqli.default_pw =
mysqli.reconnect = Off

[mysqlnd]
mysqlnd.collect_statistics = On
mysqlnd.collect_memory_statistics = On

[OCI8]

[PostgreSQL]
pgsql.allow_persistent = On
pgsql.auto_reset_persistent = Off
pgsql.max_persistent = -1
pgsql.max_links = -1
pgsql.ignore_notice = 0
pgsql.log_notice = 0

[Sybase-CT]
sybct.allow_persistent = On
sybct.max_persistent = -1
sybct.max_links = -1
sybct.min_server_severity = 10
sybct.min_client_severity = 10

[bcmath]
bcmath.scale = 0

[browscap]

[Session]
session.save_handler = files
session.use_strict_mode = 0
session.use_cookies = 1
session.use_only_cookies = 1
session.name = PHPSESSID
session.auto_start = 0
session.cookie_lifetime = 0
session.cookie_path = /
session.cookie_domain =
session.cookie_httponly =
session.serialize_handler = php
session.gc_probability = 1
session.gc_divisor = 1000
session.gc_maxlifetime = 1440
session.referer_check =
session.cache_limiter = nocache
session.cache_expire = 180
session.use_trans_sid = 0
session.hash_function = 0
session.hash_bits_per_character = 5
url_rewriter.tags = "a=href,area=href,frame=src,input=src,form=fakeentry"

[MSSQL]
mssql.allow_persistent = On
mssql.max_persistent = -1
mssql.max_links = -1
mssql.min_error_severity = 10
mssql.min_message_severity = 10
mssql.compatibility_mode = Off
mssql.secure_connection = Off

[Assertion]

[COM]

[mbstring]

[gd]

[exif]

[Tidy]
tidy.clean_output = Off

[soap]
soap.wsdl_cache_enabled=1
soap.wsdl_cache_dir="/tmp"
soap.wsdl_cache_ttl=86400
soap.wsdl_cache_limit = 5

[sysvshm]

[ldap]
ldap.max_links = -1

[mcrypt]

[dba]

[opcache]

[curl]

[openssl]

[xdebug]
zend_extension=xdebug
```

2. 64位php的php.ini文件内容

```shell
[PHP]
engine = On
short_open_tag = Off
precision = 14
output_buffering = 4096
zlib.output_compression = Off
implicit_flush = Off
unserialize_callback_func =
serialize_precision = -1
disable_functions =
disable_classes =
zend.enable_gc = On
expose_php = On
max_execution_time = 30
max_input_time = 60
memory_limit = 128M
error_reporting = E_ALL
display_errors = On
display_startup_errors = On
log_errors = On
log_errors_max_len = 1024
ignore_repeated_errors = Off
ignore_repeated_source = Off
report_memleaks = On
html_errors = On
variables_order = "GPCS"
request_order = "GP"
register_argc_argv = Off
auto_globals_jit = On
post_max_size = 8M
auto_prepend_file =
auto_append_file =
default_mimetype = "text/html"
default_charset = "UTF-8"
doc_root =
user_dir =
extension_dir = "c:/wamp/64/php/ext"
enable_dl = Off
extension=mbstring
extension=mysqli
extension=pdo_mysql
file_uploads = On
upload_max_filesize = 2M
max_file_uploads = 20
allow_url_fopen = On
allow_url_include = Off
default_socket_timeout = 60

[CLI Server]
cli_server.color = On

[Date]

[filter]

[iconv]

[intl]

[sqlite3]

[Pcre]

[Pdo]

[Pdo_mysql]
pdo_mysql.cache_size = 2000
pdo_mysql.default_socket=

[Phar]

[mail function]
SMTP = localhost
smtp_port = 25
mail.add_x_header = Off

[ODBC]
odbc.allow_persistent = On
odbc.check_persistent = On
odbc.max_persistent = -1
odbc.max_links = -1
odbc.defaultlrl = 4096
odbc.defaultbinmode = 1

[Interbase]
ibase.allow_persistent = 1
ibase.max_persistent = -1
ibase.max_links = -1
ibase.timestampformat = "%Y-%m-%d %H:%M:%S"
ibase.dateformat = "%Y-%m-%d"
ibase.timeformat = "%H:%M:%S"

[MySQLi]
mysqli.max_persistent = -1
mysqli.allow_persistent = On
mysqli.max_links = -1
mysqli.cache_size = 2000
mysqli.default_port = 3306
mysqli.default_socket =
mysqli.default_host =
mysqli.default_user =
mysqli.default_pw =
mysqli.reconnect = Off

[mysqlnd]
mysqlnd.collect_statistics = On
mysqlnd.collect_memory_statistics = On

[OCI8]

[PostgreSQL]
pgsql.allow_persistent = On
pgsql.auto_reset_persistent = Off
pgsql.max_persistent = -1
pgsql.max_links = -1
pgsql.ignore_notice = 0
pgsql.log_notice = 0

[bcmath]
bcmath.scale = 0

[browscap]

[Session]
session.save_handler = files
session.use_strict_mode = 0
session.use_cookies = 1
session.use_only_cookies = 1
session.name = PHPSESSID
session.auto_start = 0
session.cookie_lifetime = 0
session.cookie_path = /
session.cookie_domain =
session.cookie_httponly =
session.serialize_handler = php
session.gc_probability = 1
session.gc_divisor = 1000
session.gc_maxlifetime = 1440
session.referer_check =
session.cache_limiter = nocache
session.cache_expire = 180
session.use_trans_sid = 0
session.sid_length = 26
session.trans_sid_tags = "a=href,area=href,frame=src,form="
session.sid_bits_per_character = 5

[Assertion]
zend.assertions = 1

[COM]

[mbstring]

[gd]

[exif]

[Tidy]
tidy.clean_output = Off

[soap]
soap.wsdl_cache_enabled=1
soap.wsdl_cache_dir="/tmp"
soap.wsdl_cache_ttl=86400
soap.wsdl_cache_limit = 5

[sysvshm]

[ldap]
ldap.max_links = -1

[dba]

[opcache]

[curl]

[openssl]

[xdebug]
zend_extension=xdebug
```

## 结束语

> 关于php的配置事实上会比apache24更多，由于它是一门使用广泛的高级语言，所以php的相关内容重点会放在php语言学习中...
