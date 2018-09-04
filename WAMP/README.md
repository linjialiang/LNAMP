# windows下纯手工配置wamp开发环境

> 实践是检验真理的唯一标准，做开发最重要的一条就是练习、练习、再练习！

## wamp开发环境介绍

> 该wamp开发环境有两种组合：1）推荐版（64位）；2）兼容版（32位）

### 推荐版（64位）安装包列表

> 需要安装运行库版本 `vc15_x64`

1. `httpd-2.4.34-win64-VC15.zip`
2. `mariadb-10.3.9-winx64.zip`
3. `php-7.2.9-Win32-VC15-x64.zip`
4. `phpMyAdmin-4.8.3-all-languages.zip`
5. `MSVBCRT_AIO_2018.07.30_X86+X64.exe`

### 兼容版（32位）安装包列表

> 需要安装运行库版本 `vc11_x86`

1. `httpd-2.4.34-win32-VC11.zip`
2. `mariadb-10.0.36-win32.zip`
3. `php-5.6.37-Win32-VC11-x86.zip`
4. `phpMyAdmin-4.8.3-all-languages.zip`
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

> 文章列表

文章标题          | 导航链接
------------- | -------------------------
配置apache24 | [apache24](配置apache24.md)
配置php         | [php](配置php.md)
配置mariadb     | [mariadb](配置mariadb.md)
wamp组件维护      | [组件维护](wamp组件维护.md)

>  安装包链接： [https://pan.baidu.com/s/15DQZdjYtPenf6JIUf5VUEA](https://pan.baidu.com/s/15DQZdjYtPenf6JIUf5VUEA)  密码：`snt0`
