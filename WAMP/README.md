# wamp开发环境核心

> 实践是检验真理的唯一标准，做开发最重要的一条就是练习、练习、再练习！

## wamp开发环境介绍

> 该wamp开发环境有两种组合：1）推荐版（64位）；2）兼容版（32位）

### 推荐版（64位）安装包列表

1.  `httpd-2.4.35-win64-VC15.zip`
2.  `mariadb-10.3.10-winx64.zip`
3.  `php-7.2.11-Win32-VC15-x64.zip`

### 兼容版（32位）安装包列表

1.  `httpd-2.4.35-win32-VC15.zip`
2.  `mariadb-10.0.36-win32.zip`
3.  `php-5.6.38-Win32-VC11-x86.zip`

### 其它安装包列表

> mariadb网页版管理工具

1.  `phpMyAdmin-4.8.3-all-languages.zip`
2.  `adminer.php`

> 推荐版（64位）所需运行库

1.  `vc15_x64.exe`

> 兼容版（32位）所需运行库

1.  `vc11_x86.exe`
2.  `vc15_x86.exe`

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
├─vc                            运行库存放目录
│
├─phpmyadmin                    数据库管理平台，内附：adminer.php
│
├─install.bat                   安装wamp相关服务到系统服务
│
├─uninstall.bat                 从系统服务卸载wamp相关服务
│
├─便捷指令.bat                   日常经常用到的wamp相关指令
│
├─强制删除.bat                   使用net指令来删除wamp相关服务
│
└─安装运行库.bat                 安装wmap必备的运行库
```

> 文章列表

| 文章标题       | 导航链接                      |
| ---------- | ------------------------- |
| 配置apache24 | [apache24](配置apache24.md) |
| 配置php      | [php](配置php.md)           |
| 配置mariadb  | [mariadb](配置mariadb.md)   |
| wamp组件维护   | [组件维护](wamp组件维护.md)       |

## 版本说明

> 从v3版本开始确立的版本号的发布为： `wamp-v` + `A-B-C`

| 写法  | 说明                                              |
| --- | ----------------------------------------------- |
| `A` | 主版本号，除非有重大技术更改，否则不会发布新版本                        |
| `B` | 次版本号，当改变了 `php` `mariadb` `apache2` 等的版本时，会发布新版本 |
| `C` | 小版本号，针对当前次版本的维护，会发布新版本                          |

## 更新说明

> 更新说明从v3.2.1版本开始

### wamp-v3.2.1更新说明

1. 将 `php` 除了 `php_xdebug` 以外的所有扩展都禁用掉，需要的话自定开启；
2. 为 `php` 增加了 `composer` ，只需要将指定php根目录加入环境变量中即可在终端中使用：
    ```shell
    $ composer -V
    ```
