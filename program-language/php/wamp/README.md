# windows下纯手工配置wamp开发环境

> 实践是检验真理的唯一标准，做开发最重要的一条就是练习、练习、再练习！

## wamp开发环境介绍

> 该wamp开发环境有两种组合：1）推荐版（64位）；2）兼容版（32位）

### 推荐版（64位）安装包列表

> 需要安装运行库版本 `vc15_x64`

1. `httpd-2.4.34-win64-VC15.zip`
2. `mariadb-10.3.8-winx64.zip`
3. `php-7.2.8-Win32-VC15-x64.zip`
4. `phpMyAdmin-4.8.2-all-languages.zip`
5. `MSVBCRT_AIO_2018.07.30_X86+X64.exe`

### 兼容版（32位）安装包列表

> 需要安装运行库版本 `vc11_x86`

1. `httpd-2.4.34-win32-VC11.zip`
2. `mariadb-10.0.36-win32.zip`
3. `php-5.6.37-Win32-VC11-x86.zip`
4. `phpMyAdmin-4.8.2-all-languages.zip`
5. `MSVBCRT_AIO_2018.07.30_X86.exe`

### 目录结构如下：

```shell
├─     ====================     wamp环境部署目录
├─32                            32位安装包
│  ├─apache24                   Web服务器
│  │  ├─bin                     阿帕奇可执行程序目录
│  │  ├─conf                    配置
│  │  │  ├─httpd.conf           阿帕奇主配置文件
│  │  │  └─ ...
│  │  └─ ...
│  │
│  ├─mariadb                    mariadb 10.0版本
│  │  ├─bin                     mariadb可执行程序目录
│  │  └─ ...
│  │
│  ├─php                        php 5.6版本
│  │  ├─ext                     模块目录
│  │  ├─php.ini                 php主配置文件
│  │  └─ ...
│  │
│
├─64                            64位安装包
│  ├─apache24                   Web服务器
│  │  ├─bin                     阿帕奇可执行程序目录
│  │  ├─conf                    配置
│  │  │  ├─httpd.conf           阿帕奇主配置文件
│  │  │  └─ ...
│  │  └─ ...
│  │
│  ├─mariadb                    mariadb 10.3版本
│  │  ├─bin                     mariadb可执行程序目录
│  │  └─ ...
│  │
│  ├─php                        php 7.2版本
│  │  ├─ext                     模块目录
│  │  ├─php.ini                 php主配置文件
│  │  └─ ...
│  │
│
├─conf                          公用配置文件目录
│
├─logs                          服务器相关日志文件目录
│  │  ├─apache24                apache24日志目录
│  │  ├─mariadb                 mariadb日志目录
│  │
│
├─sites                         站点配置文件目录
│
├─www                           Web根目录
│
├─www-default                   apache24站点缺省位置
│
├─data                          mariadb数据库存放目录
│
└─phpmyadmin                    网页版mariadb数据库管理平台（编程语言是php）
```

### 将 apache2 加入到系统服务中

- 加入系统变量的操作

  > - 操作前提：只安装1个阿帕奇服务
  > - 操作方法：将 bin 目录加入到系统变量 PATH 中
  > - cmd要求：需要有管理员权限

  ```shell
  httpd.exe -k install -n <service-httpd>
  ```

- 不加入系统变量的操作

  > - 操作前提：安装多个阿帕奇服务
  > - 操作方法：进入 bin 目录后才能操作
  > - cmd要求：需要有管理员权限

  ```shell
  httpd.exe -k install -n <service-httpd>
  ```

### 将 apache2 从系统服务中卸载

> - 方法一：使用阿帕奇自带的工具卸载
> - 方法一：使用系统工具强制删除

- 使用阿帕奇自带的工具卸载

  > - 操作前提：确保阿帕奇服务未损坏
  > - 操作方法：未加入环境变量的需要进入 bin 目录后才能操作
  > - cmd要求：需要有管理员权限

  ```shell
  httpd.exe -k uninstall -n <service-httpd>
  ```

- 使用系统工具 `sc` 从注册表删除服务

  > - 优点1：不需要进入 bin 目录后才能操作
  > - 优点2：只要系统存在该服务，就算阿帕奇损坏了，也能正常删除
  > - cmd要求：需要有管理员权限

  ```shell
  sc delete <service-httpd>
  ```

### 启动 apache2 服务器

> - cmd要求：需要有管理员权限
> - 注意：阿帕奇需要安装到系统服务后才能启动

```shell
net start <service-httpd>
```

> - 默认情况：阿帕奇默认使用80和443端口，如果端口不变，系统只能开启一个阿帕奇服务
> - 修改端口：为每个阿帕奇都定义不同的空闲端口后，系统就可以开启多个阿帕奇服务
> - 端口占用：如果端口被占用也无法开启服务，需先关闭占用端口的软件，才能正常开启服务

### 关闭 apache2 服务器

> cmd要求：需要有管理员权限

```shell
net stop <service-httpd>
```

### `service-httpd` 属性值列表

digit | `service-httpd`
----- | ---------------
64    | apache24
32    | httpd

## 配置 mariadb

### 创建 my.ini

> - 默认说明：默认情况下mariadb没有my.ini文件，需要我们自己新建
> - 参考文件：mariadb目录下有几个 `my-*.ini` 文件，都是参考文件，我们可以根据需要自行配置
> - 操作说明：下面我们在 `c:\wamp\conf` 目录下创建 my.ini，并输入如下内容：

```ini
[client]
port = 3306

[mysqld]
port = 3306
datadir = "c:/wamp/data"
```

> - 提示：`innodb` 索引扩展默认会跟 `datadir` 同级，没有特殊必要不需要配置
> - 注意：切换版本前需要将data目录下的非目录文件删除掉

### 初始化 data 目录

> 前提：需要将data目录内容复制到指定位置 cmd：cmd需要管理员权限 操作：cmd进入bin目录，输入指令如下：

```shell
mysqld --initialize
```

> mariadb 初始化影响不大，每次重启都会初始化（除非你不想重启）

### 安装mariadb到系统服务

> - 前提：data目录正确，my.ini文件路径正确
> - 情况1：my.ini 在mariadb根目录下的安装方法
> - 情况2：my.ini 不在mariadb根目录下的安装方法

1. my.ini 在mariadb根目录下

  > cmd：cmd需要管理员权限 操作：cmd进入bin目录，输入指令如下：

  ```shell
  mysqld.exe --install <service-mariadb>
  ```

  > `service-mariadb` 是自定义服务名，为空会自动命名为 `MySQL`

2. my.ini 不在mariadb根目录下

  > 默认:默认会获取在mariadb根目录上的my.ini（假如存在） cmd：cmd需要管理员权限 操作：cmd进入bin目录，输入指令如下：

  ```shell
  mysqld.exe --install <service-mariadb> --defaults-file=c:\wamp\conf\my.ini
  ```

### 卸载 mariadb 系统服务

- 用mariadb自带工具卸载

  > cmd：cmd需要管理员权限 操作：cmd进入bin目录，输入指令如下：

  ```shell
  mysqld.exe --remove <service-mariadb>
  ```

- 用系统 `sc` 工具从注册表删除服务

  > cmd：cmd需要管理员权限 `server` 是服务器地址，如果是本地可以省略

  ```shell
  sc <server> delete <service-mariadb>
  ```

### 启动 mariadb 服务

> - 安装系统服务的启动方式
> - 未安装系统服务的启动方式

- 安装系统服务版-启动mariadb服务

  > cmd要求：需要管理员权限

  ```shell
  net start <service-mariadb>
  ```

- 未安装系统服务版-启动mariadb服务

  > cmd要求：需要管理员权限 操作：cmd进入bin目录，输入如下代码：

  ```shell
  mysqld.exe
  ```

  > 如果my.ini不在mariadb根目录需要如下代码：

  ```shell
  mysqld.exe --defaults-file="c:\wamp\conf\my.ini"
  ```

### 停止 mariadb 服务

> - 安装系统服务的停止方式
> - 未安装系统服务的停止方式

- 安装系统服务版-停止mariadb服务

  > cmd要求：需要管理员权限

  ```shell
  net stop <service-mariadb>
  ```

- 未安装系统服务版-停止mariadb服务

  > cmd要求：需要管理员权限 操作：cmd进入bin目录，输入如下代码：

  ```shell
  mysqladmin.exe -uroot shutdown
  ```

  > 如果root存在密码，需要加上 `-p` ，并在出现提示时提供密码

  ```shell
  mysqladmin.exe -uroot -p shutdown
  ```

### `service-mariadb` 属性值一览表

digit | version    | `sercice-mariadb`
----- | ---------- | -----------------
64    | mariadb103 | mysql103
64    | mariadb102 | mysql102
64    | mariadb101 | mysql101
64    | mariadb100 | mysql100
64    | mariadb55  | mysql55
32    | mariadb103 | mariadb103
32    | mariadb102 | mariadb102
32    | mariadb101 | mariadb101
32    | mariadb100 | mariadb100
32    | mariadb55  | mariadb55

## 配置系统服务启动类型

> 配置服务：不管是阿帕奇系统服务、mariadb系统服务方式都一样：

```shell
sc config <service-name> start=<set-value>
```

`set-value` | explain
----------- | -------
auto        | 自动
demand      | 手动
disabled    | 禁用

## wamp 说明书

> 该 `wamp` 安装包解压即用，包含32位和64位版本，并且可自由选择 `mariadb` 与 `php` 的版本！

### mariadb 相关：

1. root的默认密码是123456
2. `mariadb 5.5` 的 `data` 内数据与其它版本有很大不同，最简单的方法就是将 `data` 目录的原始资源全部替换掉
3. `mariadb 10.0` 版本基本上完全兼容 `mariadb 5.5` ，所以 `mariadb 5.5` 已经可以淘汰

### `bat` 脚本须知：

1. bat 脚本的换行符必须是 `\r\n` ，否则不能执行
2. bat 脚本的编码格式需要gb2312（因为中文版系统，其它编码cmd会出现乱码）

### 几个命令脚本说明：

1. `常用服务指令.bat` 该脚本用于启动服务、停止服务、设置服务选项
2. `批量清除服务.bat` 该脚本用来一次性卸载所有相关服务（安装前可执行一遍）
3. `安装.bat` 该脚本用于安装指定版本到相关服务
4. `卸载.bat` 该脚本用于卸载指定版本的相关服务

### 安装说明：

1. 先使用 `批量清除服务.bat` 脚本文件清理一遍
2. 使用 `安装.bat` 脚本文件安装你需要的版本
3. 使用 `常用服务指令.bat` 脚本文件启动或关闭服务

### 运行库支持：该环境包需要运行库支持，运行库建议自己去下载最新版的 `VC15` `VC14` `VC11` `VC9`

### 软件包自带的运行库安装包：

- `MSVBCRT_AIO_2018.05.13_X86.exe`
- `MSVBCRT_AIO_2018.05.13_X86+X64.exe`

> `文档连接` ：[wamp环境搭建说明文档](https://github.com/linjialiang/programmer/blob/dev3/program-language/php/wamp/README.md)
