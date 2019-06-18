# cmake 调用语法

> 这里我们会列出 `Autotools命令` 与 `CMake命令` 一一对应的信息，通过本手册，也能了解 Autotools 的各个参数的作用！
>
> - 提示：Autotools 就是我们构建源码时的 `configure 命令`

## 命令调用语法

> 下表列出了常用编译工具的调用语法和等效的 CMake 命令。

| configure 命令     | CMake 命令                  |
| ------------------ | --------------------------- |
| ./configure        | cmake .                     |
| ./configure --help | `cmake . -LH` 或 `ccmake .` |

> 注意：`.` 表示你当前的工作目录路径，请根据你所在的目录，适当的替换掉 `路径 .`

### 重新构建

> 在重新配置或重新构建之前，需要先清除旧的对象文件和缓存信息，方法如下：

1. Autotools：

   ```shell
   $ make clean
   $ rm -f config.cache
   ```

2. CMake (Unix/Linux)：
   ```shell
   $ make clean
   $ rm -f CMakeCache.txt
   ```

## 安装参数选项

> 在下表中，`-CMAKE_INSTALL_PREFIX` 的值表示的是安装根目录，其他参数值的路径都是相对于根目录的，当然你也可以直接使用绝对路径，具体如下：

| 参数值说明           | configure 选项                           | CMak 选项                              |
| -------------------- | ---------------------------------------- | -------------------------------------- |
| 安装根目录           | --prefix=/usr                            | -DCMAKE_INSTALL_PREFIX=/usr            |
| mysqld 目录          | --libexecdir=/usr/sbin                   | -DINSTALL_SBINDIR=sbin                 |
| 数据存储目录         | --localstatedir=/var/lib/mysql           | -DMYSQL_DATADIR=/var/lib/mysql         |
| 配置文件(my.cnf)目录 | --sysconfdir=/etc/mysql                  | -DSYSCONFDIR=/etc/mysql                |
| 插件目录             | --with-plugindir=/usr/lib64/mysql/plugin | -DINSTALL_PLUGINDIR=lib64/mysql/plugin |
| 手册文件目录         | --mandir=/usr/share/man                  | -DINSTALL_MANDIR=share/man             |
| 共享数据目录         | --sharedstatedir=/usr/share/mysql        | -DINSTALL_SHAREDIR=share               |
| Library 库目录       | --libdir=/usr/lib64/mysql                | -DINSTALL_LIBDIR=lib64/mysql           |
| Header 安装目录      | --includedir=/usr/include/mysql          | -DINSTALL_INCLUDEDIR=include/mysql     |
| 信息文档目录         | --infodir=/usr/share/info                | -DINSTALL_INFODIR=share/info           |

## 存储引擎选项（mariadb 专辑）

> 存储引擎是以插件的形式存在的，所以，该选项可以控制插件的构建，比如指定使用某个特定的引擎。

```text
“--with-plugins” 配置选项接受两种形式的参数值，它没有对应的CMake配置参数：
    ① 以逗号(,)分隔的引擎名称列表；
    ② a "group name" value that is shorthand for a set of engines

在没有指定存储引擎的情况下，mariadb默认也会安装一些常用的存储引擎
```

> 更加详细的说明，请查阅资料！

## 库文件加载选项

> 该选项指明 Mysql 使用库的情况：

| 参数值说明  | 配置选项             | CMak 选项          |
| ----------- | -------------------- | ------------------ |
| readline 库 | --with-readline      | -DWITH_READLINE=1  |
| SSL 库      | --with-ssl=/usr      | -DWITH_SSL=system  |
| zlib 库     | --with-zlib-dir=/usr | -DWITH_ZLIB=system |
| libwrap 库  | --without-libwrap    | -DWITH_LIBWRAP=0   |

## 其他选项

> CMake 编译选项支持大部分之前版本的 MySQL 编译选项，新老编译选项的差别在于：之前的是小写，现在全部变成了大写，之前采用双横线，现在使用单横线，之前使用的破折号，现在取而代之的是使用下划线，例如：

```shell
--with-debug => WITH_DEBUG=1
--with-embedded-server => WITH_EMBEDDED_SERVER
```

> 下面是编译 MySQL 的新老参数对照表：

| 参数值说明             | 配置选项                                 | CMak 选项                           |
| ---------------------- | ---------------------------------------- | ----------------------------------- |
| TCP/IP 端口            | --with-tcp-port-=3306                    | -DMYSQL_TCP_PORT=3306               |
| UNIX socket 文件       | --with-unix-socket-path=/tmp/mysqld.sock | -DMYSQL_UNIX_ADDR=/tmp/mysqld.sock  |
| 启用加载本地数据       | --enable-local-infile                    | -DENABLED_LOCAL_INFILE=1            |
| 扩展字符支持           | --with-extra-charsets=all（默认：all）   | -DEXTRA_CHARSETS=all（默认：all）   |
| 默认字符集             | --with-charset=utf8                      | -DDEFAULT_CHARSET=utf8              |
| 默认字符校对           | --with-collation=utf8_general_ci         | -DDEFAULT_COLLATION=utf8_general_ci |
| Build the server       | --with-server                            | 无                                  |
| 嵌入式服务器           | --with-embedded-server                   | -DWITH_EMBEDDED_SERVER=1            |
| libmysqld 权限控制     | --with-embedded-privilege-control        | 无                                  |
| 安装文档               | --without-docs                           | 无                                  |
| Big tables 支持        | --with-big-tables, --without-big-tables  | 无                                  |
| mysqld 运行用户        | --with-mysqld-user=mysql                 | -DMYSQL_USER=mysql                  |
| 调试模式               | --without-debug（默认禁用）              | -DWITH_DEBUG=0（默认禁用）          |
| GIS 支持               | --with-geometry                          | 无                                  |
| 社区功能               | --enable-community-features              | 无                                  |
| Profiling              | --disable-profiling（默认启用）          | -DENABLE_PROFILING=0（默认启用）    |
| pstack                 | --without-pstack                         | 无（新版移除该功能）                |
| 汇编字符串函数         | --enable-assembler                       | 无                                  |
| 构建类型               | --build=x86_64-pc-linux-gnu              | 没有等效参数                        |
| 交叉编译主机           | --host=x86_64-pc-linux-gnu               | 没有等效参数                        |
| 客户端标志             | --with-client-ldflags=-lstdc++           | 无                                  |
| 线程安全标志           | --enable-thread-safe-client              | 无                                  |
| 注释存储类型           | --with-comment='string'                  | -DWITH_COMMENT='string'             |
| Shared/static binaries | --enable-shared --enable-static          | 无                                  |
| 内存使用控制           | --with-low-memory                        | 无                                  |

> cmake 构建 `mariadb 10.3.16` 后，可选项的值

```shell
$ cmake /data/source/mariadb/mariadb-10.3.16 -L
-- Running cmake version 3.7.2
-- MariaDB 10.3.16
== Configuring MariaDB Connector/C
CMake Warning at storage/tokudb/CMakeLists.txt:51 (MESSAGE):
  TokuDB is enabled, but jemalloc is not.  This configuration is not
  supported


-- Configuring done
-- Generating done
-- Build files have been written to: /data/build/mariadb-10.3.16
-- Cache values
BZIP2_DIR:PATH=BZIP2_DIR-NOTFOUND
CMAKE_BUILD_TYPE:STRING=RelWithDebInfo
CMAKE_INSTALL_PREFIX:PATH=/data/compile/mariadb-10.3.16
CONC_WITH_CURL:BOOL=OFF
CONC_WITH_DYNCOL:BOOL=ON
CONC_WITH_EXTERNAL_ZLIB:BOOL=ON
CONC_WITH_MYSQLCOMPAT:BOOL=ON
CONC_WITH_SSL:BOOL=OFF
CONC_WITH_UNIT_TESTS:BOOL=ON
CONNECT_WITH_JDBC:BOOL=ON
CONNECT_WITH_LIBXML2:BOOL=ON
CONNECT_WITH_MONGO:BOOL=ON
CONNECT_WITH_ODBC:BOOL=ON
CONNECT_WITH_VCT:BOOL=ON
CONNECT_WITH_XMAP:BOOL=ON
CONNECT_WITH_ZIP:BOOL=ON
DISABLE_SHARED:BOOL=OFF
ENABLED_PROFILING:BOOL=ON
ENABLE_GCOV:BOOL=OFF
GRN_DEFAULT_DB_KEY:STRING=auto
GRN_DEFAULT_DOCUMENT_ROOT:PATH=/data/compile/mariadb-10.3.16/share/groonga/html/admin
GRN_DEFAULT_DOCUMENT_ROOT_BASE:PATH=html/admin
GRN_DEFAULT_ENCODING:STRING=utf8
GRN_DEFAULT_MATCH_ESCALATION_THRESHOLD:STRING=0
GRN_DEFAULT_RELATIVE_DOCUMENT_ROOT:PATH=share/groonga/html/admin
GRN_EMBED:BOOL=ON
GRN_LOCK_TIMEOUT:STRING=900000
GRN_LOCK_WAIT_TIME_NANOSECOND:STRING=1000000
GRN_LOG_PATH:FILEPATH=/data/compile/mariadb-10.3.16/var/log/groonga/groonga.log
GRN_MECAB_CONFIG:FILEPATH=mecab-config
GRN_MECAB_CONFIG_ABSOLUTE_PATH:FILEPATH=GRN_MECAB_CONFIG_ABSOLUTE_PATH-NOTFOUND
GRN_STACK_SIZE:STRING=1024
GRN_WITH_BUNDLED_LZ4:BOOL=OFF
GRN_WITH_BUNDLED_MECAB:BOOL=OFF
GRN_WITH_BUNDLED_MESSAGE_PACK:BOOL=OFF
GRN_WITH_DEBUG:BOOL=OFF
GRN_WITH_KYTEA:STRING=auto
GRN_WITH_LIBEVENT:STRING=auto
GRN_WITH_LIBSTEMMER:STRING=auto
GRN_WITH_LZ4:STRING=auto
GRN_WITH_MECAB:STRING=auto
GRN_WITH_MESSAGE_PACK:STRING=auto
GRN_WITH_MRUBY:BOOL=OFF
GRN_WITH_NFKC:BOOL=ON
GRN_WITH_ZEROMQ:STRING=auto
GRN_WITH_ZLIB:STRING=auto
GROONGA_NORMALIZER_MYSQL_EMBED:BOOL=ON
INSTALL_LAYOUT:STRING=STANDALONE
MRN_BUILD_FOR_EMBEDDED_SERVER:BOOL=OFF
MRN_DEFAULT_PARSER:STRING=
MRN_DEFAULT_TOKENIZER:STRING=
MRN_GROONGA_EMBED:BOOL=ON
MRN_GROONGA_NORMALIZER_MYSQL_EMBED:BOOL=ON
MUTEXTYPE:STRING=event
MYSQL_DATADIR:PATH=/data/compile/mariadb-10.3.16/data
MYSQL_MAINTAINER_MODE:STRING=AUTO
NOT_FOR_DISTRIBUTION:BOOL=OFF
PCRE_PARENS_NEST_LIMIT:STRING=250
PCRE_SHOW_REPORT:BOOL=OFF
PLUGIN_ARCHIVE:STRING=DYNAMIC
PLUGIN_ARIA:STRING=STATIC
PLUGIN_AUDIT_NULL:STRING=DYNAMIC
PLUGIN_AUTH_0X0100:STRING=DYNAMIC
PLUGIN_AUTH_ED25519:STRING=DYNAMIC
PLUGIN_AUTH_SOCKET:STRING=DYNAMIC
PLUGIN_AUTH_TEST_PLUGIN:STRING=DYNAMIC
PLUGIN_BLACKHOLE:STRING=DYNAMIC
PLUGIN_CLIENT_ED25519:STRING=DYNAMIC
PLUGIN_CONNECT:STRING=DYNAMIC
PLUGIN_DAEMON_EXAMPLE:STRING=DYNAMIC
PLUGIN_DEBUG_KEY_MANAGEMENT:STRING=DYNAMIC
PLUGIN_DIALOG_EXAMPLES:STRING=DYNAMIC
PLUGIN_DISKS:STRING=DYNAMIC
PLUGIN_EXAMPLE:STRING=DYNAMIC
PLUGIN_EXAMPLE_KEY_MANAGEMENT:STRING=DYNAMIC
PLUGIN_FEDERATED:STRING=DYNAMIC
PLUGIN_FEDERATEDX:STRING=DYNAMIC
PLUGIN_FEEDBACK:STRING=STATIC
PLUGIN_FILE_KEY_MANAGEMENT:STRING=DYNAMIC
PLUGIN_FTEXAMPLE:STRING=DYNAMIC
PLUGIN_HANDLERSOCKET:STRING=DYNAMIC
PLUGIN_INNOBASE:STRING=STATIC
PLUGIN_LOCALES:STRING=DYNAMIC
PLUGIN_METADATA_LOCK_INFO:STRING=DYNAMIC
PLUGIN_MROONGA:STRING=DYNAMIC
PLUGIN_PARTITION:STRING=STATIC
PLUGIN_PERFSCHEMA:STRING=STATIC
PLUGIN_QA_AUTH_CLIENT:STRING=DYNAMIC
PLUGIN_QA_AUTH_INTERFACE:STRING=DYNAMIC
PLUGIN_QA_AUTH_SERVER:STRING=DYNAMIC
PLUGIN_QUERY_CACHE_INFO:STRING=DYNAMIC
PLUGIN_QUERY_RESPONSE_TIME:STRING=DYNAMIC
PLUGIN_ROCKSDB:STRING=DYNAMIC
PLUGIN_SEQUENCE:STRING=STATIC
PLUGIN_SERVER_AUDIT:STRING=DYNAMIC
PLUGIN_SIMPLE_PASSWORD_CHECK:STRING=DYNAMIC
PLUGIN_SPHINX:STRING=DYNAMIC
PLUGIN_SPIDER:STRING=DYNAMIC
PLUGIN_SQL_ERRLOG:STRING=DYNAMIC
PLUGIN_TEST_SQL_DISCOVERY:STRING=DYNAMIC
PLUGIN_TEST_VERSIONING:STRING=DYNAMIC
PLUGIN_TOKUDB:STRING=DYNAMIC
PLUGIN_USER_VARIABLES:STRING=STATIC
PLUGIN_WSREP_INFO:STRING=DYNAMIC
RUBY:FILEPATH=/usr/bin/ruby2.3
SECURITY_HARDENED:BOOL=ON
TMPDIR:PATH=
UPDATE_SUBMODULES:BOOL=ON
USE_ARIA_FOR_TMP_TABLES:BOOL=ON
USE_GCOV:BOOL=OFF
WITHOUT_SERVER:BOOL=OFF
WITH_ASAN:BOOL=OFF
WITH_EMBEDDED_SERVER:BOOL=OFF
WITH_EXTRA_CHARSETS:STRING=all
WITH_FALLOCATE:BOOL=ON
WITH_INNODB_AHI:BOOL=ON
WITH_INNODB_BUG_ENDIAN_CRC32:BOOL=OFF
WITH_INNODB_BZIP2:STRING=AUTO
WITH_INNODB_DISALLOW_WRITES:BOOL=ON
WITH_INNODB_EXTRA_DEBUG:BOOL=OFF
WITH_INNODB_LZ4:STRING=AUTO
WITH_INNODB_LZMA:STRING=AUTO
WITH_INNODB_LZO:STRING=AUTO
WITH_INNODB_ROOT_GUESS:BOOL=ON
WITH_INNODB_SNAPPY:STRING=AUTO
WITH_JEMALLOC:STRING=auto
WITH_LIBWRAP:BOOL=OFF
WITH_MARIABACKUP:BOOL=ON
WITH_NUMA:STRING=AUTO
WITH_PCRE:STRING=auto
WITH_READLINE:BOOL=OFF
WITH_ROCKSDB_BZIP2:STRING=AUTO
WITH_ROCKSDB_JEMALLOC:BOOL=OFF
WITH_ROCKSDB_LZ4:STRING=AUTO
WITH_ROCKSDB_snappy:STRING=AUTO
WITH_ROCKSDB_zstd:STRING=AUTO
WITH_SAFEMALLOC:STRING=AUTO
WITH_SSL:STRING=bundled
WITH_SYSTEMD:STRING=auto
WITH_TSAN:BOOL=OFF
WITH_UBSAN:BOOL=OFF
WITH_UNIT_TESTS:BOOL=ON
WITH_VALGRIND:BOOL=OFF
WITH_WSREP:BOOL=ON
WITH_ZLIB:STRING=system
libmongoc-1.0_DIR:PATH=libmongoc-1.0_DIR-NOTFOUND
```
