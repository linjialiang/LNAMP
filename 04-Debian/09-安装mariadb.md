# 安装 mariadb

> 我们这里要安装的是 mariadb 10.3.16

## 下载源码包

> mariadb 源码下载地址 https://downloads.mariadb.org/

```shell
$ mkdir /data/source/maridb
$ cd /data/source/maridb
$ wget https://downloads.mariadb.org/interstitial/mariadb-10.3.16/source/mariadb-10.3.16.tar.gz
```

## 安装缺失的依赖项

> 当前这台服务器，安装 mariadb 缺少了如下包（及对应的依赖）

```shell
$ apt install git libncurses5-dev libghc-gnutls-dev libbison-dev libevent-dev libxml2-dev
```

## 编译 mariadb

> 使用 cmake 来编译 mariadb

```shell
$ tar -xzvf mariadb-10.3.16.tar.gz
$ cd mariadb-10.3.16
$ mkdir -p /data/{build,compile}/mariadb-10.3.16
$ cd /data/build/mariadb-10.3.16/
# 生成makefile文件
$ cmake /data/source/mariadb/mariadb-10.3.16 \
-DCMAKE_INSTALL_PREFIX=/data/compile/mariadb-10.3.16
# 构建
$ make
# 编译
$ make install
# 清理编译留下的缓存
$ make clean
```

## 初始化 mariadb 前的准备

> maridb 刚刚编译成功，事实上还不能开启服务，需要我们做初始化的工作，而初始化操作前，还有一个准备工作：

| 序号 | 初始化前需要准备的内容            |
| ---- | --------------------------------- |
| 01   | 为 mariadb 创建特定的用户及用户群 |
| 02   | 为 mariadb 目录设置权限           |

> 用户和群组名是可以按自己喜好来的，但是为了容易识别，一般都是使用 `mysql`

```shell
# 没有特别设置会自动创建跟用户同名的用户群组
# 使用 /bin/false 来禁止 mariadb 账户登录功能
$ useradd -d /data/compile/mariadb-10.3.16 -s /bin/false  -c 'mariadb user' mysql
# 设置权限，根目录为root用户，内部用户为mariadb用户
$ chown mysql:mysql -R /data/compile/mariadb-10.3.16
$ chown root:root /data/compile/mariadb-10.3.16
```

## 初始化 mariadb

> `./scripts/mysql_install_db` 这个脚本是 mariadb 的初始化工具

| 重要指令                                        | 指令描述                                     |
| ----------------------------------------------- | -------------------------------------------- |
| --help                                          | 列出帮助说明                                 |
| --user=user_name                                | 用于运行 mysqld 的登录用户名(详情查看备注 3) |
| --basedir=path                                  | 指向 MariaDB 安装目录的路径                  |
| --datadir=path                                  | MariaDB 数据目录的路径                       |
| --defaults-file=path                            | 只读取此配置文件。                           |
| --skip-test-db                                  | 不安装测试服务器                             |
| --skip-name-resolve                             | 创建时使用 IP 地址而不是主机名               |
| --auth-root-authentication-method=normal/socket | 备注 1                                       |
| --auth-root-socket-user=user                    | 备注 2                                       |
| --ldata=path                                    | 与`--datadir` 一样                           |
| --no-defaults                                   | 不要从任何选项文件中读取默认选项。           |

> 初始化操作指令

```shell
$ cd /data/compile/mariadb-10.3.16
$ touch /data/conf/my.cnf
$ ./scripts/mysql_install_db \
--user=mysql \
--basedir=/data/compile/mariadb-10.3.16 \
--datadir=/data/compile/mariadb-10.3.16/data \
--defaults-file=/data/conf/my.cnf \
--auth-root-authentication-method=socket \
--skip-test-db \
--skip-name-resolve \
--auth-root-socket-user=root
```

> 备注 1：`--auth-root-authentication-method=normal|socket` 属性描述

| 序号   | 描述                                                                              |
| ------ | --------------------------------------------------------------------------------- |
| 作用   | 为创建的初始根用户选择身份验证方法。                                              |
| normal | 默认值，用于创建可以不使用密码登录的根用户，这可能是不安全的。                    |
| socket | 只允许 `系统root用户` 作为 `MariaDB 根用户` 登录(需要 `unix socket` 身份验证插件) |

> 备注 2 ： `--auth-root-socket-user=user`

```text
指定 MariaDB 根帐户名称，以及允许访问它的系统帐户名称。默认为 'root'
```

> 备注 3：`--user=user_name`

```text
用于运行mysqld的登录用户名。
由mysqld创建的文件和目录将由该用户拥有。
必须是root用户才能使用此选项。
默认情况下，mysqld使用您当前的登录名运行，它创建的文件和目录将由您拥有。
```

## 将可执行文件加入环境变量中

> 首先需要将 bin 目录下的可执行文件加入到环境变量

```shell
$ cp /etc/profile{,.bak}
$ vim /etc/profile
```

> 底部加入如下一行：

```conf
export PATH=/data/compile/mariadb-10.3.16/bin:$PATH
:wq
```

> 激活新设置的环境变量（或者重启服务器）

```shell
$ source /etc/profile
```

## 启动方式

> 启动方式主要有如下 3 种：

1. init.d 启动

   > 将 `mysql.server` 文件复制到 init.d 目录下并重命名

   ```shell
   $ cp ./support-files/mysql.server /etc/init.d/mysql
   $ /etc/init.d/mysql {start|stop|restart|reload|status}
   ```

2. service 启动（可用 `systemctl开机启动` 替代）

   > 将 `mysql.server` 文件加入 bin 目录（或者将其加入环境变量中）

   ```shell
   $ cp ./support-files/mysql.server ./bin
   $ systemctl daemon-reload
   $ server mysql {start|stop|restart|reload|status}
   $ systemctl {start|stop|restart|reload|status} mysql.service
   ```

   > 提示：将 `/etc/init.d/mysql` 通过 systemctl 程序加入开机启动时，加入环境变量的 `mysql.service` 文件，全部都会被移除（确保仅有 systemctl 启动程序中唯一存在）

3. `systemctl` 管理开机启动

   > 可以使用 systemctl 指令设置开机启动（确保 init.d 下面有对应的启动文件）

   ```shell
   # 开机启动（第一次允许使用这个指令）
   $ systemctl enable mysql
   # 禁止开机启动
   $ /lib/systemd/systemd-sysv-install disable mysql
   # 开机启动（第二次开始必须使用这个指令）
   $ /lib/systemd/systemd-sysv-install enable mysql
   ```

## 其它设置

1. 为 mariadb 的根账户设置密码

   > 管理员直接使用 mysqladmin 这个程序设置根账户密码

   ```shell
   # 首先要先启动mysql，并且密码为空
   $ mysqladmin -u <根用户名> password [密码]
   # 案例一
   $ mysqladmin -u root password '123456'
   # 案例二
   $ mysqladmin -u mariadb_root password
   New password:123456
   Confirm new password:123456
   ```

2. mariadb 配置选项文件

   > 默认选项文件可能有多个，依次读取顺序为 `/etc/my.cnf` `~/.my.cnf` ，我们也可以使用 `--defaults-file=path` 自定义选项文件路径

   ```text
   注意：如果通过 `--defaults-file=path` 指定了选项文件
    - 那么仅从给定选项文件中读取选项配置;
    - 如果该文件不存在，则初始化 MariaDB 时，将引发错误提示。
   ```

   > 选项文件案例

   ```ini
   [client-server]
   socket=/tmp/mysql.sock
   port=3306

   [client]
   #password=my_password

   [mysqld]
   datadir=/data/compile/mariadb-10.3.16/data
   ```

   > mariadb 选项文件语法清查阅 [mariadb 选项文件语法](./info/mariadb选项文件语法.md)

## my.cnf 配置参考

> 这是网上摘抄的，可能并不适合 mariadb 10.3.16

```ini
## global_buffers 在内存中缓存从数据文件中检索出来的数据块，可以大大提高查询和更新数据的性能

## 计算公式：Innodb_buffer_pool_size + Innodb_additional_mem_pool_size + Innodb_log_buffer_size + key_buffer_size + query_cache_size

## per_thread_buffers 线程独享内存大小

## 计算公式（ read_buffer_size + read_rnd_buffer_size + sort_buffer_size + thread_stack + join_buffer_size + binlog_cache_size ）* max_connections

## 注意：global_buffers + per_thread_buffers 不能大于实际物理内存，否者并发量大时会造成内存溢出、系统死机 ！

[client]
port = 3306
socket = /usr/local/mysql/data/mysql.sock

## 定义客户端连接信息，端口号、socket 存放位置

[mysqld]
port = 3306
socket = /usr/local/mysql/data/mysql.sock
basedir = /usr/local/mysql
datadir = /usr/local/mysql/data
temdir = /usr/local/mysql/data

## Mysql 基本信息，端口号、socket、安装目录、数据存放目录、临时目录

# skip-name-resolve

## 禁止 Mysql 对外部连接进行 DNS 解析，加快连接速度。开启后所有远程连接主机只能使用 IP 的方式

skip_external_locking

## 避免 Mysql 外部锁定，减少出错几率、增强稳定性

local-infile = 0

## 禁止 SQL 读取本地文件

character-set-server = utf8

## 默认字符集 utf8

default-storage-engine = innodb

## 默认存储引擎

# general_log = on

## 开启查询日志，一般选择不开启，因为查询日志记录很详细，会增大磁盘 IO 开销，影响性能

# general_log_file = /usr/local/mysql/data/mysql.log

## 查询日志存放位置及文件名

log-error = /usr/local/mysql/data/error.log

## 错误日志位置跟文件名

# slow_query_log = on

## 开启慢查询日志，开启后将会记录执行时间超过 long_query_time 参数值的 SQL 语句（ 一般临时开启即可 ）

# long_query_time = 2

## 定义执行时间超过多少秒为慢查询，默认 10s

# slow_query_log_file = /usr/local/mysql/data/slow.log

## 定义慢查询日志存放位置

# server-id = 1

## Mysql Server 唯一标识，用来做主同同步（ 主从时开启 ）

log-bin = mysql-bin

## 开启 binlog ( 二进制 ) 日志，主要用来做增量备份跟主从同步

binlog_format = mixed

## Mysql binlog 的日志格式，Statement、ROW 跟 Mixed（ 混合模式 ）

binlog_cache_size = 2M

## 二进制日志缓冲大小，此参数是为每 Session 单独分配的，当一个线程开始一个事务时，Mysql 就会为此 Session 分配一个 binlog cache，当这个事务提交时，binlog cache 中的数据被写入 binlog 文件
## 通过 show status like 'binlog_cache%'; 来查看使用 binlog cache 的次数及使用磁盘的次数

sync_binlog = 0

## 这个参数对 Mysql 系统来说很重要，不仅影响到 binlog 对 Mysql 所带来的性能损耗，还影响到 Mysql 中数据的完整性。
## 值为 0 时代表事务提交后，Mysql 不做 fsync 之类的磁盘同步指令刷新 binlog_cache 中的信息到磁盘，而让 Filesystem 自行决定什么时候同步，或者 cache 满了之后才同步磁盘。
## 值为 n 时代表进行 n 次事务提交后，Mysql 将进行一次 fsync 之类的磁盘同步指令来将 binlog_cache 中的数据强制写入磁盘。
## 系统默认将此参数设置为 0 ，即不做任何强制性的磁盘刷新指令，性能最好，但是风险也最大。当系统崩溃时 binlog_cache 中的所有 binlog 信息都会丢失。
## 而设置为 1 时，是最安全但是性能损耗最大。当系统崩溃时，最多丢失 binlog_cache 中未完成的一个事务，对实际数据没有实质性的影响。

expire_logs_days = 30

## 保留 30 天的 binlog 日志，系统重启、执行 flush logs 或 binlog 日志文件大小达到上限时删除 binlog 日志

back_log = 500

## Mysql 连接请求队列存放数，当某一时刻客户端连接请求过多，造成 Mysql Server 无法为其建立连接时存放的数量，最大 65535（ 增大时需同时调整 OS 级别的网络监听队列限制 ）

max_connections = 1000

## Mysql 最大连接数，直接影响 Mysql 应用的并发处理能力（ 500~1000 是个比较合适的值，注意每建立的连接都会占用一定的内存空间，直到连接被关闭才释放内存 ）

wait_timeout = 100
interactive_timeout = 100

## 服务器关闭非交换连接之前等待活动的秒数，默认 28800 秒（ 注意：在 my.cnf 中修改这个参数需要配合 interactive_timeout (超时间隔)参数一起修改，否则不生效）
##（ Mysql 处理完一条连接后所等待释放的时间，如果并发很高，默认设置会导致最大连接被占满，出现 "too many connections" 错误 ）
##（ 如果这个值很低，比如 5 ，可能会导致出现 "ERROR 2006 (HY000) MySQL server has gone away" 的错误，出现这个错误还有可能是 max_allowed_packet 设置过小 ）
## 真实案例

max_connect_errors = 1000

## 最大连接失败次数，跟性能没有太大关系，主要跟安全方面有关（ 达到此上限后会无条件阻止其连接数据库 ，默认 100 ）

connect_timeout = 20

## 连接超时时间为 20 秒

max_allowed_packet = 16M

## 网络传输中一次消息量的最大值，默认 4M ，必须设为 1024 的整倍数

table_open_cache = 2000

## 打开文件描述符的缓存个数，防止系统频繁打开、关闭描述符而浪费资源（ 对性能有影响，默认 2000 ）

read_buffer_size = 512K

## Mysql 读入缓冲区大小，对表进行顺序扫描的请求将分配一个读入缓冲区，Mysql 会为其分配一段内存缓冲区（ 默认 128K ，此参数为每线程分配 ）

read_rnd_buffer_size = 512K

## Mysql 随机 Query 缓冲区大小，当按任意顺序读取行时，将分配一个随机读取缓冲区。如进行排序查询时，Mysql 会首先扫描该缓冲，避免磁盘搜索，提高查询速度（ 默认 256K ，该缓冲也是为每线程分配 ）

sort_buffer_size = 512K

## 系统中对数据进行排序时使用的 buffer ，如果系统中排序比较大，且内存充足、并发不大时，可以适当增大此值（ 默认 256K ，此参数为每线程分配独立的 buffer ）

join_buffer_size = 512K

## join 为 ALL、index、rang 或 index_merge 时使用的 buffer（ 默认 256K ，每 Thread 都会建立自己独立的 buffer ）

thread_stack = 256K

## 参数表示每线程的堆栈大小

thread_cache_size = 64

## Thread Cache 池中存放的连接线程数（ 此池中的线程不是启动服务时就创建的，而是随着连接线程的创建和使用，逐渐将用完的线程存入其中，达到此值后将不再缓存连接线程 ）
## 缓存命中率计算公式：Thread_Cache_Hit = ( Connections - Thread_created ) / Connections * 100%
## 系统运行一段时间后，Thread Cache 命中率应该保持在 90% 以上

explicit_defaults_for_timestamp = 1

## 如果此参数不开启，error_log 中会有警告信息

query_cache_type = 1

## 是否启用 query_cache ，0 为不使用（ 若要关闭 query_cache 时，需同时将 query_cache_size 、query_cache_limit 设为 0 ）

query_cache_size = 32M

## 查询缓冲大小，当重复查询时会直接从该缓冲中获取，但是当所查询表有改变时，缓冲的查询将失效（ 频繁写入、更新、高并发的环境下建议关闭此缓冲 ）

query_cache_limit = 1M

## 单个查询所能够使用的缓冲区大小

ft_min_word_len = 1

## 使用全文索引最小长度

transaction_isolation = REPEATABLE-READ

## 事务隔离级别，为了有效保证并发读取数据的正确性（ 默认 Repeatables Read 即：可重复读 ）
## Innodb 有四种隔离级别：Read Uncommitted（ 未提交读 ）、Read Committed（ 已提交读 ）、Repeatable Read（ 可重复读 ）、Serializable（ 可序列化 ）

tmp_table_size = 32M

## 临时表大小

key_buffer_size = 32M

## 用来缓存 MyISAM 存储引擎的索引（ 默认 8M ，如果使用 Innodb 存储引擎，此值设为 64M 或更小 ）
## 计算公式：key_reads / key_read_requests * 100% 的值小于 0.1%

## Innodb 存储引擎相关参数

innodb_file_per_table = 0

## 关闭独享表空间，使用共享表空间

innodb_buffer_pool_size = 256M

## Innodb 存储引擎核心参数，用于缓存 Innodb 表的索引、数据（ 默认 128M ，单独使用 Innodb 存储引擎且单一 Mysql 服务时建议设为物理内存的 70% - 80 % ）
## 可以通过 show status like 'innodb_buffer_pool_%'; 来获取 innodb buffer pool 的实时状态信息
## Innodb_buffer_pool_pages_total 总共的 pages（ Innodb 存储引擎中所有数据存放最小物理单位 page ，每个 page 默认为 16KB ）
## Innodb_buffer_pool_pages_free  空闲的 pages
## Innodb_buffer_pool_pages_data  有数据的 pages
## Innodb_buffer_pool_read_requests  总共的 read 请求次数
## Innodb_buffer_pool_reads  读取物理磁盘读取数据的次数，即：在 buffer pool 中没有找到
## Innodb_buffer_pool_wait_free  因 buffer 空间不足而产生的 wait_free
## Innodb_buffer_pool_read_ahead_rnd  记录进行随机读的时候产生的预读次数
## Innodb_buffer_pool_read_ahead_seq  记录连续读的时候产生的预读次数
## Innodb_buffer_pool_size  使用率 = innodb_buffer_pool_pages_data / innodb_buffer_pool_pages_total * 100%
## Innodb_buffer_pool_read  命中率 = （ innodb_buffer_pool_read_requests - innodb_buffer_pool_reads ）/ innodb_buffer_pool_read_requests * 100%

innodb_use_sys_malloc = 1

## 使用系统自带的内存分配器，替代 innodb_additional_mem_pool_size 参数

innodb_data_file_path = ibdata1:512M:autoextend

## 指定一个大小为 512M 的、可扩展的 ibdata1 数据文件

innodb_read_io_threads = 4
innodb_write_io_threads = 4

## Innodb 使用后台线程处理数据页上的 IO 请求，根据 CPU 核数修改，默认 4

innodb_thread_concurrency = 0

## Innodb 线程并发数，0 为不限制，默认 0

innodb_flush_log_at_trx_commit = 2

## Innodb 事务日志刷新方式，0 为每隔一秒 log thread 会将 log buffer 中的数据写入到文件，并通知文件系统进行文件同步 flush 操作，极端情况下会丢失一秒的数据
## 1 为每次事务结束都会触发 log thread 将 log buffer 中的数据写入文件并通知文件系统同步文件，数据最安全、不会丢失任何已经提交的数据
## 2 为每次事务结束后 log thread 会将数据写入事务日志，但只是调用了文件系统的文件写入操作，并没有同步到物理磁盘，因为文件系统都是有缓存机制的，各文件系统的缓存刷新机制不同
## 当设为 1 时是最为安全的，但性能也是最差的。0 为每秒同步一次，性能相对高一些。设为 2 性能是最好的，但故障后丢失数据也最多（ OS 跟主机硬件、供电足够安全可以选择，或对数据少量丢失可以接受 ）。

innodb_log_buffer_size = 8M

## 事务日志所使用的缓冲区。Innodb 在写事务日志时，为了提高写 Log 的 IO 性能，先将信息写入 Innodb Log Buffer 中，当满足 Innodb_flush_log_trx_commit 参数或日志缓冲区写满时，再将日志同步到磁盘中。
## 默认 8M ，一般设为 16~64M 即可，可以通过 show status like 'innodb_log%'; 查看状态

innodb_buffer_pool_dump_at_shutdown = 1

## 关闭数据库时把热数据 dump 到本地磁盘。

innodb_buffer_pool_dump_now = 1

## 采用手工方式把热数据 dump 到本地磁盘。

innodb_buffer_pool_load_at_startup = 1

## 启动时把热数据加载到内存。

innodb_buffer_pool_load_now = 1

## 采用手工方式把热数据加载到内存。

## 以上四条参数会快速预热 Buffer_pool 缓冲池，当机器正常重启后，热数据还保留在内存中，避免瞬间连接数爆满导致机器死机。

[mysqldump]
quick
max_allowed_packet = 4M

## 使用 mysqldump 工具备份数据库时，当某张表过大时备份会报错，需要增大该值（ 增大到大于表大小的值 ）
```
