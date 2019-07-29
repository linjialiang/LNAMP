# 帮助选项

> 使用 ./configure --help 可以查看所有构建选项

1. `--help`

   > 打印帮助信息

## 设置路径的构建选项

> 设置 Nginx 不同类型文件的目录

1. `--prefix=PATH`

> 指定一个安装路径，用于存放安装 Nginx 时产生的文件，默认设置为 /usr/local/nginx 目录。

```text
- 构建Nginx时，configure 设定了绝对路径的选项以外，Nginx 构建产生的所有其它文件都会以此为根目录；
- 另外 nginx.conf 配置文件中设置的所有相对路径，也是以此为根路径。
```

2. `--sbin-path=path`

> 设置 nginx 可执行文件的路径。此路径仅在安装 Nginx 期间使用。默认该路径名为 prefix/sbin/nginx

3. `--modules-path=PATH`

> 定义了 nginx 模块的安装目录。默认使用 prefix/modules 目录。

4. `--conf-path=PATH`

> 设置配置文件(nginx.conf)的路径及名称。默认为 prefix/conf/nginx.conf

- 安装成功以后如果需要，始终可以使用 nginx -c file 指令在终端中更改：

```shell
$ nginx -c /etc/nginx/nginx.conf
$ nginx -s reload
```

5. `--error-log-path=PATH`

> 设置错误日志的路径及名称，默认为 prefix/logs/error.log

- 安装后，如果需要，始终可以使用 error_log 指令在配置文件(nginx.conf)中更改：

```conf
error_log /logs/nginx/error.log error;
```

6. `--pid-path=PATH`

> 设置存储 Nginx 主进程 ID 的文件路径及名称，默认为 prefix/logs/nginx.pid

7. `--lock-path=PATH`

> 为锁定文件的名称设置前缀。默认为 prefix/logs/nginx.lock

- 安装后，始终可以使用 lock_file 指令在配置文件(nginx.conf)中更改该值：

```conf
lock_file /logs/nginx/nginx.lock;
```

8. `--build=NAME`

   > 设置 Nginx 构建时的名称，仅在构建时有效

9. `--builddir=DIR`

   > 指定一个构建路径，用于存放构建时生成的文件
