# **`PHP7.x` 安装与配置**

## **安装php7.x**

> 安装php是会一起安装apache2的，因为linux里php是apache2的一个组件

```shell
# apt-get install php
```

> php 只是编程语言的解析器，并不需要特别的配置，默认即可满足大多数开发者的要求

## **为php安装pdo扩展支持**

> 不管是 `php_mysql扩展` `php_mysqli扩展` `php_pdo扩展` 只需要安装 `php-mysql包`

```shell
# apt-get install php-mysql
# /etc/init.d/mysql restart
```
## **安装 `php-fpm`**
> `php-fpm` 是为 `Nginx` 准备的，因为 `Nginx` 本身并不能处理 PHP，需要 php解释器处理

```shell
# apt-get install php-fpm
```

### **更改 `php-fpm` 用户和用户组**
> `Nginx` 运行 php 的过程中牵涉到两个用户及用户组
> 1. 一个是nginx运行的用户，一个是php-fpm运行的用户；
> 2. 如果访问的是一个静态文件的话，则只需要nginx运行的用户对文件具有读权限或者读写权限；
> 3. 而如果访问的是一个 php 文件的话，则首先需要 `nginx` 运行的用户对文件有读取权限，
> 4. 读取到文件后发现是一个 php 文件，则转发给 `php-fpm`，此时则需要 `php-fpm` 用户对文件具有有读权限或者读写权限。
> php 默认用户及用户组也是 `www-data`

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
