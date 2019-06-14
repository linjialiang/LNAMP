# 安装 mariadb

> 我们这里要安装的是 mariadb 10.3.15

## 安装缺失的依赖项

> 当前这台服务器缺少了下面 4 个包及其依赖

```shell
$ apt install libncurses5-dev libghc-gnutls-dev libbison-dev libevent-dev
```

## 编译 mariadb

> 使用 cmake 来编译 mariadb

```shell
# 生成makefile文件
$ cmake /data/source/mariadb/mariadb-10.3.15 \
-DCMAKE_INSTALL_PREFIX=/data/compile/mariadb-10.3.15/
# 构建
$ make
# 编译
$ make install
# 清理编译留下的缓存
$ make clean
```
