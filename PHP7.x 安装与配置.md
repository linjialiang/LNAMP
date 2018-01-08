# ** `PHP7.x` 安装与配置**

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

