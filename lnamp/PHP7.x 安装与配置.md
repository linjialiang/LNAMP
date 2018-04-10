# **`PHP7.x` 安装与配置**

## **安装php7.x**

> 安装php是会一起安装apache2的，因为linux里php是apache2的一个组件

```shell
# apt-get install php
```

> php 只是编程语言的解析器，并不需要特别的配置，默认即可满足大多数开发者的要求

## **为 php 安装 pdo 扩展支持**

> 不管是 `php_mysql扩展` `php_mysqli扩展` `php_pdo扩展` 只需要安装 `php-mysql包`

```shell
# apt-get install php-mysql
# /etc/init.d/mysql restart
```

## **安装 `php-fpm`**

> `php-fpm` 是为 `Nginx` 准备的，因为 `Nginx` 本身并不能处理 PHP，需要 php 解释器处理

> - <font color="red">注意： <code>lnamp</code> 下并不需要安装 <code>php-fpm</code> 因为 PHP 都是由 <code>apache2</code> 来执行的</font>

```shell
# apt-get install php-fpm
```

### **更改 `php-fpm` 用户和用户组**

> `Nginx` 运行 php 的过程中牵涉到两个用户及用户组

> 1. 一个是 `nginx` 运行的用户，一个是 `php-fpm` 运行的用户；
> 2. 如果访问的是一个静态文件的话，则只需要 `nginx` 运行的用户对文件具有读权限或者读写权限；
> 3. 而如果访问的是一个 php 文件的话，则首先需要 `nginx` 运行的用户对文件有读取权限，
> 4. 读取到文件后发现是一个 php 文件，则转发给 `php-fpm`，此时则需要 `php-fpm` 用户对文件具有有读权限或者读写权限。 php 默认用户及用户组也是 `www-data`

1. 打开 `/etc/php/7.0/fpm/pool.d/www.conf` 配置文件

  ```shell
  # cp /etc/php/7.0/fpm/pool.d/www.conf{,.backup}
  # vim /etc/php/7.0/fpm/pool.d/www.conf
  ```

2. 配置文件

  ```conf
  ;; 找到下面2行注释掉，并添加2行
  ;; user = www-data
  ;; group = www-data
  ;; 下面2行是新添加的
  user = www
  group = www

  ;; 找到下面2行注释掉，并添加2行
  ;; listen.owner = www-data
  ;; listen.group = www-data
  ;; 下面2行是新添加的
  listen.owner = www
  listen.group = www
  ```

3. 记得重启 `php-fpm`

```shell
# /etc/init.d/php7.0-fpm restart
```

### **修改 `php7.0-fpm.sock` 用户和用户组**

```shell
# chown www:www /var/run/php/php7.0-fpm.sock
# /etc/init.d/php7.0-fpm restart
```

> 配置 `php-fpm` 已经差不多了，下面就是在 `nginx` 下面配置，让站点支持php

## **为php安装 `mbstring` 扩展**

> phpmyadmin 安装好了 打开可能会提示：

> - <font color="red">没有找到 PHP 扩展 mbstring，而您现在正在使用多字节字符集。没有 mbstring 扩展的 phpMyAdmin 不能正确分割字符串并可能产生意料之外的结果。</font>

> - 这是因为 `Debian 9.x` 默认并没有为 php 安装 `mbstring 扩展`

```shell
# apt-get install php-mbstring
# /etc/init.d/apache2 restart
```

## 附录一： 开发环境下配置 `xdebug`
> 这里以 `xampp` 为例子，操作方式适用于所有 `ms` 系统

- 下载 `Xdebug` : 
  1. [PHP 7.0.x](https://xdebug.org/files/php_xdebug-2.6.0-7.0-vc14-x86_64.dll)
  2. [PHP 7.1.x](https://xdebug.org/files/php_xdebug-2.6.0-7.1-vc14-x86_64.dll)
  3. [PHP 7.2.x](https://xdebug.org/files/php_xdebug-2.6.0-7.2-vc15-x86_64.dll)
  
- 拷贝文件 `php_xdebug-2.6.0-7.2-vc15-x86_64.dll` 到 `C:\xampp\php\ext` 下面
- 使用 `notepad++` 打开 `C:\xampp\php\php.ini` 文件，并编辑:
  1. 禁用输出缓冲 `output_buffering = Off`
  ```ini
  ; ...
  output_buffering = Off  # 禁用输出缓冲，默认情况下已经禁用，如果是 On 开启了，请修改为 Off 禁用掉
  ; ...
  ```
  
  2. 文件最底部添加以下内容(注释掉的内容，一般都不需要添加)：
  ```ini
  ; ...
  [XDebug]
  ; 请确保使用完整路径
  zend_extension = "c:\xampp\php\ext\php_xdebug-2.6.0-7.2-vc15-x86_64.dll"
  
  ; 通常，您需要使用特定的HTTP GET/POST变量来启动远程调试；
  ; 当此设置设置为1时，即使GET/POST/COOKIE变量不存在，Xdebug也将始终尝试启动远程调试会话并尝试连接到客户端。
  ;; xdebug.remote_autostart = 1
  
  ; 探查器输出将被写入的目录，确保PHP将运行的用户对该目录具有写入权限；
  ; 这个设置不能在脚本中用 ini_set() 设置。
  xdebug.profiler_output_dir = "c:\xampp\php\php_xdebug\profiler"
  
  ; 此设置确定用于将跟踪转储到的文件的名称；
  ; 该设置用格式说明符指定格式，与 sprintf() 和 strftime() 非常相似；
  ; 有几种格式说明符可用于格式化文件名。
  ;; xdebug.profiler_output_name = "cachegrind.out.%p"
  
  ; 此开关控制 Xdebug 是否应尝试联系正在使用设置 xdebug.remote_host 和 xdebug.remote_port 设置的侦听主机和端口的调试客户端；
  ; 如果该设置为0，无法建立连接，则该脚本将会继续。
  ;; xdebug.remote_enable = 1
  
  ; 选择运行调试客户端的主机，您可以为Unix域套接字使用主机名；
  ; IP地址或'unix：/// path / to / sock'；
  ; 如果启用 xdebug.remote_connect_back ，此设置将被忽略。
  ;; xdebug.remote_host = localhost
  
  ; Xdebug尝试在远程主机上连接的端口；
  ; 端口9000是客户端和捆绑调试客户端的默认端口；
  ; 由于许多客户端使用此端口号，所以最好不要改变此设置。
  ;; xdebug.remote_port = 9000
  
  ; 跟踪文件将被写入的目录，确保PHP将运行的用户具有对该目录的写入权限
  xdebug.trace_output_dir = "c:\xampp\php\php_xdebug\trace"
  
  ; 此设置确定用于将跟踪转储到的文件的名称；
  ; 该设置用格式说明符指定格式，与sprintf()和strftime()非常相似；
  ; 有几种格式说明符可用于格式化文件名；
  ; '.xt'扩展名总是自动添加。
  ;; xdebug.trace_output_name = "trace.%c"
  
  ; 控制哪个 xdebug.idekey 应该传递给 DBGp 调试器处理程序，默认值基于环境设置；
  ; 首先咨询环境设置 DBGP_IDEKEY，然后是 USER 和最后一个 USERNAME ；
  ; 默认设置为找到的第一个环境变量。如果没有找到该设置，则默认设置为''；
  ; 如果设置了此设置，它将始终覆盖环境变量。
  ;; xdebug.idekey="netbeans-xdebug"
  ```

- 使用的是 `PHP` 的 `FastCGI IIS` 应该使用非线程安全的 `NTS` 版本的 `PHP` ;
- 使用 `Apache` ，您必须使用PHP的线程安全 `TS` 版本的 `PHP` .
--------------------------------------------------------------------------------

