# Nginx 核心功能

> `Nginx 核心功能` 相当于 `main 模块` 的指令

## main 模块指令列表

> main 模块一共包含 29 个指令，按字母排序如下：

1. accept_mutex

   > 与负载、性能相关

   ```text
   - 语法: 	  accept_mutex on | off;
   - 默认值: 	 accept_mutex off;
   - 上下文: 	 events
   ```

   > accept_mutex 的作用：

   ```text
   - accept_mutex on;
        - 当一个新连接到达时，如果激活了 accept_mutex，那么多个Worker将以串行方式来处理，其中有一个 Worker 会被唤醒，其他的 Worker 继续保持休眠状态；
        - 需要程序一个个分配，worker分配不均匀，执行效率低。
   - accept_mutex off;
        - 那么所有的Worker都会被唤醒，不过只有一个 Worker 能获取新连接，其它的 Worker 会重新进入休眠状态，这就是「惊群问题」；
        - 自动分配，worker分配均匀，执行效率高，不过CPU占用会相对高一点；
        - 作者也推荐大家选择关闭状态。
   ```

2. accept_mutex_delay

   > 与负载、性能相关， 满足 `accept_mutex on;` 这个条件才有效

   ```text
   - 语法:     accept_mutex_delay time;
   - 默认值:   accept_mutex_delay 500ms;
   - 上下文:   events
   ```

   > accept_mutex_delay 的作用：

   ```text
   - 当 accept_mutex 功能启用后，只有一个持有 mutex 锁的 worker 进程会接受并处理请求，其他 worker 进程等待；
   - accept_mutex_delay 指定的时间就是这些 worker 进程的等待时间，过了等待时间下一个 worker 进程便取得 mutex 锁，处理请求；
   - accept_mutex_delay 在 events 模块中指定，默认的值为 500ms。
   ```

3. daemon

   > 确定 nginx 是否应该成为守护进程，主要用于开发环境中。

   ```text
   - 语法:     daemon on | off;
   - 默认值:   daemon on;
   - 上下文:   events
   ```

   > 注意：用于开发调试，生产环境不建议使用

4. debug_connection

   > 为选定的客户端连接启用 debug 日志，而其他客户端的连接将使用 error_log 指令设置的日志级别。

   ```text
   - 语法:    debug_connection address | CIDR | unix:;
   - 默认值:  没有
   - 上下文:  events
   ```

   > 注意：用于开发调试，生产环境不建议使用

5. debug_points

   > 这个指令用于调试。

   ```text
   Syntax: 	debug_points abort | stop;
   Default: 	—
   Context: 	main
   ```

6. env

   > 设置 nginx 环境变量

   ```text
   Syntax: 	env variable[=value];
   Default: 	env TZ;
   Context: 	main
   ```

7. error_log

   > 配置错误日志记录

   ```text
   Syntax: 	error_log file [错误日志级别];
   Default: 	error_log logs/error.log error;
   Context: 	main, http, mail, stream, server, location
   ```

   > 注意： 要使用 debug 级别的日志，需要在编译 nginx 时加上 `--with-debug`，使用 `nginx -V` 可以查看编译时是否支持 debug 级别日志

8. events

   > 核心功能中唯一的块指令，提供配置文件上下文，其中指定了影响连接处理的指令。

   ```text
   Syntax: 	events { ... }
   Default: 	—
   Context: 	main
   ```

9. include

   > 在配置中包含另一个文件，或与指定掩码匹配的文件。包含的文件应该由语法正确的指令和块组成。

   ```text
   Syntax: 	include file | mask;
   Default: 	—
   Context: 	any
   ```

   > include 指令案例：

   ```conf
   include mime.types;
   include vhosts/*.conf;
   ```

10. load_module

    > 加载一个动态模块

    ```text
    Syntax: 	load_module file;
    Default: 	—
    Context: 	main
    ```

    > load_module 案例：

    ```conf
    load_module modules/ngx_mail_module.so;
    ```

11. lock_file

    > nginx 使用锁的机制来实现 accept_mutex 功能和共享内存.

    ```text
    - 大多数操作系统中，锁都是一个原子操作，这种情况下这条指令无效；
    - 还有一些操作系统中使用“锁文件”的的机制来实现锁，此命令用来指定锁文件前缀名。
    - lock_file 我们一般也用不到
    ```

    ```text
    Syntax: 	lock_file file;
    Default: 	lock_file logs/nginx.lock;
    Context: 	main
    ```

12. master_process

    > 是否以 master/worker 方式进行工作

    ```text
    Syntax: 	master_process on | off;
    Default: 	master_process on;
    Context: 	main
    ```

    > master_process 选项解释：

    ```text
    - master_process on; 表示 nginx 是以一个 master 进程管理多个 worker 进程的方式运行的；
    - master_process off; 表示 nginx 不会 fork 出 worker 子进程来处理请求，而是用master进程自身来处理请求。
    - 除非开发插件，一般都是开启的
    ```
