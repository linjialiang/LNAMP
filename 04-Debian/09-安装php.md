# 安装 php

> 这里我们以安装 php-7.3.6 为例

## 下载 php

> 直接去 php [官网](https://www.php.net)下载

```shell
$ mkdir /server/php
$ cd /server/php
$ wget https://www.php.net/distributions/php-7.3.6.tar.bz2
$ tar -jxvf php-7.3.6.tar.bz2
```

## 编译前的准备

> 具体查看 [编译前的准备](./info/编译前的准备.md)

## 编译 php 源代码

> php 是使用 autotools 工具来编译的。

```txt
autotools 工具编译的包：
    - 可以使用 ./configure --help 指令来查看所有配置选项
```

1. 创建目录

   ```shell
   $ mkdir /server/{build,compile}/php-7.3.6
   ```

2. 安装编译依赖

   > 解决依赖项最方便的方法就是缺啥补啥，怎么多执行几次 `./configure` 就是了

   ```shell
   apt install libxml2-dev
   ```

3. 开始编译

   ```shell
   $ cd /server/build/php-7.3.6
   $ /server/php/php-7.3.6/configure --prefix=/server/compile/php-7.3.6
   $ make
   $ make install
   ```
