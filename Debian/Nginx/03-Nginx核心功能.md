# Nginx 核心功能

> `Nginx 核心功能` 相当于 `main 模块` 的指令

## main 模块指令列表

> main 模块一共包含 29 个指令，按字母排序如下：

1.  accept_mutex

    > 与负载、性能相关，也称 `互斥锁`

    ```ini
    - 语法: 	  accept_mutex on | off;
    - 默认值: 	 accept_mutex off;
    - 上下文: 	 events
    ```

    > accept_mutex 的作用：

    ```ini
    - accept_mutex on;
         - 当一个新连接到达时，如果激活了 accept_mutex，那么多个Worker将以串行方式来处理，其中有一个 Worker 会被唤醒，其他的 Worker 继续保持休眠状态；
         - 需要程序一个个分配，worker分配不均匀，执行效率低。
    - accept_mutex off;
         - 所有的Worker都会被唤醒，不过只有一个 Worker 能获取新连接，其它的 Worker 会重新进入休眠状态，这就是「惊群问题」；
         - 自动分配，worker分配均匀，执行效率高，不过CPU占用会相对高一点；
         - 默认情况下，互斥锁时关闭的，这也是官方推荐的。
    ```

2.  accept_mutex_delay

    > 与负载、性能相关， 满足 `accept_mutex on;` 这个条件才有效

    ```ini
    - 语法:     accept_mutex_delay time;
    - 默认值:   accept_mutex_delay 500ms;
    - 上下文:   events
    ```

    > accept_mutex_delay 的作用：

    ```ini
    - 当 accept_mutex 功能启用后，只有一个持有 mutex 锁的 worker 进程会接受并处理请求，其他 worker 进程等待；
    - accept_mutex_delay 指定的时间就是这些 worker 进程的等待时间，过了等待时间下一个 worker 进程便取得 mutex 锁，处理请求；
    - accept_mutex_delay 在 events 模块中指定，默认的值为 500ms。
    ```

3.  daemon

    > 确定 nginx 是否应该成为守护进程，主要用于开发环境中。

    ```ini
    - 语法:     daemon on | off;
    - 默认值:   daemon on;
    - 上下文:   events
    ```

    > 注意：用于开发调试，生产环境不建议使用

4.  debug_connection

    > 为选定的客户端连接启用 debug 日志，而其他客户端的连接将使用 error_log 指令设置的日志级别。

    ```ini
    - 语法:    debug_connection address | CIDR | unix:;
    - 默认值:  没有
    - 上下文:  events
    ```

    > 注意：用于开发调试，生产环境不建议使用

5.  debug_points

    > 这个指令用于调试。

    ```ini
    Syntax: 	debug_points abort | stop;
    Default: 	—
    Context: 	main
    ```

6.  env

    > 设置 nginx 环境变量

    ```ini
    Syntax: 	env variable[=value];
    Default: 	env TZ;
    Context: 	main
    ```

7.  error_log

    > 配置错误日志记录

    ```ini
    Syntax: 	error_log file [错误日志级别];
    Default: 	error_log logs/error.log error;
    Context: 	main, http, mail, stream, server, location
    ```

    > 注意： 要使用 debug 级别的日志，需要在编译 nginx 时加上 `--with-debug`，使用 `nginx -V` 可以查看编译时是否支持 debug 级别日志

8.  events

    > 核心功能中唯一的块指令，提供配置文件上下文，其中指定了影响连接处理的指令。

    ```ini
    Syntax: 	events { ... }
    Default: 	—
    Context: 	main
    ```

9.  include

    > 在配置中包含另一个文件，或与指定掩码匹配的文件。包含的文件应该由语法正确的指令和块组成。

    ```ini
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

    ```ini
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

    ```ini
    Syntax: 	lock_file file;
    Default: 	lock_file logs/nginx.lock;
    Context: 	main
    ```

    ```ini
    - 大多数操作系统中，锁都是一个原子操作，这种情况下这条指令无效；
    - 还有一些操作系统中使用“锁文件”的的机制来实现锁，此命令用来指定锁文件前缀名。
    - lock_file 我们一般也用不到
    ```

12. master_process

    > 是否以 master/worker 方式进行工作

    ```ini
    Syntax: 	master_process on | off;
    Default: 	master_process on;
    Context: 	main
    ```

    > master_process 选项解释：

    ```ini
    - master_process on; 表示 nginx 是以一个 master 进程管理多个 worker 进程的方式运行的；
    - master_process off; 表示 nginx 不会 fork 出 worker 子进程来处理请求，而是用master进程自身来处理请求。
    - 除非开发插件，一般都是开启的
    ```

13. multi_accept

    > 让 nginx worker 进程尽可能多地接受请求。

    ```ini
    Syntax: 	multi_accept on | off;
    Default: 	multi_accept off;
    Context: 	events
    ```

    ```ini
    - multi_accept on; 时，可以让 nginx worker 进程尽可能多地接受请求；
        - 作用是让worker进程一次性地接受监听队列里的所有请求，然后处理；
    - multi_accept off; 时，worker进程必须一个一个地接受监听队列里的请求。
    ```

14. pcre_jit

    > 开启或者禁用即时编译正则表达式(PCRE 版本必须在 8.20 或者更高)

    ```ini
    Syntax:	pcre_jit on | off;
    Default:	pcre_jit off;
    Context:	main
    ```

    > `pcre_jit on;` 可显著提高 nginx 对正则的处理速度，具体实现过程如下：

    ```ini
    1. 构建PCRE时，必须指定 --enable-jit 参数；
    2. 构建nginx时，必须指定 --with-pcre-jit 参数，让nginx启用对pcre_jit的支持；
    3. 如果pcre可执行程序没有加入系统环境变量中，则需要通过 '--with-pcre=<pcre可执行程序路径>' 指定正确的路径。
    ```

15. pid

    > 定义一个文件，该文件将存储主进程的进程 ID。

    ```ini
    Syntax:	pid file;
    Default:    pid logs/nginx.pid;
    Context:	main
    ```

16. ssl_engine

    > 该指令用于指定 openssl 使用的引擎。

    ```ini
    Syntax: ssl_engine <引擎名>;
    Default:	—
    Context:	main
    ```

    > 你可以通过下面的命令行获知系统目前支持的 openssl 引擎：

    ```shell
    $ openssl engine -t
    (rdrand) Intel RDRAND engine
         [ available ]
    (dynamic) Dynamic engine loading support
         [ unavailable ]
    ```

17. thread_pool

    > 定义用于多线程读取和发送文件而不阻塞 worker 进程的命名线程池。

    ```ini
    Syntax:	thread_pool name threads=number [max_queue=number];
    Default:	thread_pool default threads=32 max_queue=65536;
    Context:	main
    ```

    ```ini
    - threads参数定义池中的线程数;
    - 如果池中的所有线程都处于繁忙状态，则新任务将在队列中等待;
    - max_queue参数限制允许在队列中等待的任务数量;
    - 默认情况下，队列中最多可以等待65536个任务。当队列溢出时，任务将带着错误完成。
    ```

    > 提示：要使用线程池必须在构建的时候加上 `--with-threads` 参数

18. timer_resolution

    > 该配置指令允许用户减少调用 gettimeofday()的次数。

    ```ini
    Syntax:	timer_resolution <间隔时间>;
    Default:	—
    Context:	main
    ```

    > 示例：

    ```conf
    timer_resolution 100ms;
    ```

    > 默认情况下，该函数在每次 I/O 端口监听（比如 epoll_wait）返回后都将被调用，而通过 timer_resolution 配置选项可以直接指定调用 gettimeofday() 函数的间隔时间。

19. use

    > 指定要使用的连接处理方法。通常不需要显式地指定它，因为 nginx 默认使用最有效的方法。

    ```ini
    Syntax:	use [ select| poll| kqueuw | epoll ];
    Default:	—
    Context:	events
    ```

    > select/poll 是标准模式，kqueue/epoll 是高效模式。kqueue 仅仅适合 BSD 系统。linux 首选是 epoll

20. user

    > 定义 worker 进程使用的用户和组凭据。如果省略组，则使用名称等于 user 的组。

    ```ini
    Syntax:	user 用户名 [用户组名];
    Default:	user nobody nobody;
    Context:	main
    ```

21. worker_connections

    > 设置单个 worker 进程能同时打开的最大连接数。

    ```ini
    Syntax:	worker_connections number;
    Default:	worker_connections 512;
    Context:	events
    ```

    ```ini
    - 应该记住，这个数字包括所有连接(例如与代理服务器的连接等)，而不仅仅是与客户机的连接。
    - 另一个需要考虑的问题是，实际并发连接的数量不能超过当前打开文件最大数量的限制，可以通过 worker_rlimit_nofile 指令更改。
    ```

22. worker_cpu_affinity

    > 将 worker 进程绑定到 cpu 集。每个 CPU 集由允许的 CPU 的位掩码表示。应该为每个 worker 进程定义一个单独的集合。默认情况下，worker 进程不绑定到任何特定的 CPU。

    ```ini
    Syntax:	    worker_cpu_affinity cpumask ...;
                worker_cpu_affinity auto [cpumask];
    Default:	—
    Context:	main
    ```

    > 使用一下指令查看 cpu 核心数：

    ```shell
    $ cat /proc/cpuinfo | grep processor
    ```

    > 规则设定：cpu 有多少个核，就有几位数，1 代表内核开启，0 代表内核关闭。

23. worker_priority

    > 定义 worker 进程的调度优先级，负数表示更高的优先级。允许范围通常在-20 到 19 之间变化。

    ```ini
    Syntax:	worker_priority number;
    Default:	worker_priority 0;
    Context:	main
    ```

    > 默认即可，对性能影响不大。可以使用下面的指令查看优先级：

    ```shell
    $ ps axo cmd,pid,psr,ni | grep nginx
    ```

24. worker_processes

    > 定义 worker 进程的数量。

    ```ini
    Syntax:	worker_processes number | auto;
    Default:	worker_processes 1;
    Context:	main
    ```
