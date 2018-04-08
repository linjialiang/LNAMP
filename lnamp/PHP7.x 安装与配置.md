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
  zend_extension = "c:\xampp\php\ext\php_xdebug-2.5.5-7.1-vc14.dll"
  ; xdebug.remote_autostart = 1
  ; xdebug.profiler_append = 0
  ; xdebug.profiler_enable = 0
  ; xdebug.profiler_enable_trigger = 0
  ; xdebug.profiler_output_dir = "c:\xampp\tmp"
  ; xdebug.profiler_output_name = "cachegrind.out.%t-%s"
  ; xdebug.remote_enable = 1
  ; xdebug.remote_handler = "dbgp"
  ; xdebug.remote_host = "127.0.0.1"
  ; xdebug.remote_log="c:\xampp\tmp\xdebug.txt"
  ; xdebug.remote_port = 9000
  ; xdebug.trace_output_dir = "c:\xampp\tmp"
  ; 3600 (1 hour), 36000 = 10h
  ; xdebug.remote_cookie_expire_time = 36000
  ```

- 使用的是 `PHP` 的 `FastCGI IIS` 应该使用非线程安全的 `NTS` 版本的 `PHP` ;
- 使用 `Apache` ，您必须使用PHP的线程安全 `TS` 版本的 `PHP` .
--------------------------------------------------------------------------------

