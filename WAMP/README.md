# 《wamp 核心详解》

> wamp 核心详解主要是帮助 `php开发人员` 或 `Microsoft管理员` 快速搭建 php 工作环境

## wamp 环境包列表

| 序号 | 包名                                 | 描述                 |
| ---- | ------------------------------------ | -------------------- |
| 1    | `httpd-2.4.38-win64-VC15.zip`        | web 服务器包         |
| 2    | `mariadb-10.3.12-winx64.zip`         | 数据库管理包         |
| 3    | `php-7.3.1-Win32-VC15-x64.zip`       | php 解释器（线程版） |
| 4    | `phpMyAdmin-4.8.5-all-languages.zip` | mysql 网页版管理平台 |
| 5    | `adminer-4.7.1.php`                  | mysql 网页版管理平台 |
| 6    | `php_xdebug.7z`                      | php_xdebug 包        |
| 7    | `composer.7z`                        | composer 包          |
| 8    | `vc15_x64.exe`                       | 所需运行库           |

### 目录结构如下：

```php
// =============================================================================
//                              【wamp环境部署目录】
// =============================================================================
├─ base                                     wamp核心目录
|   ├─apache24                              Web服务器
|   |  ├─bin                                阿帕奇可执行程序目录
|   |  ├─conf                               配置
|   |  |  ├─httpd.conf                      阿帕奇主配置文件
|   |  |  └─ ...
|   |  └─ ...
|   |
|   ├─mariadb                               mariadb 10.3版本
|   |  ├─bin                                mariadb可执行程序目录
|   |  ├─my.ini                             mariadb配置文件
|   |  └─ ...
|   |
|   ├─php                                   php 7.3版本
|   |  ├─ext                                模块目录
|   |  ├─php.ini                            php主配置文件
|   |  └─ ...
|   |
|   ├─phpmyadmin                            数据库管理平台，内附：adminer.php
|   |
|   ├─conf                                  公用配置文件目录
|   |   ├─apache24.conf                  apache24的公用配置文件
|   |
|   ├─default                               apache24站点缺省位置
|   |
├─web                                       web根目录
|   ├─sites                                 站点配置文件目录
|   |
|   ├─www                                   Web根目录
|   |
|   ├─data                                  mariadb数据库存放目录
|   |
|   ├─logs                                  服务器相关日志文件目录
|   |  ├─apache24                           apache24日志目录
|   |  ├─xdebug                             xdebug日志目录
|   |
|
├─install.bat                               安装wamp相关服务到系统服务
|
├─uninstall.bat                             从系统服务卸载wamp相关服务
|
├─便捷指令.bat                              日常经常用到的wamp相关指令
|
└─强制删除.bat                              使用net指令来删除wamp相关服务
```

> 文章列表

| 文章标题      | 导航链接                    |
| ------------- | --------------------------- |
| 配置 apache24 | [apache24](配置apache24.md) |
| 配置 php      | [php](配置php.md)           |
| 配置 mariadb  | [mariadb](配置mariadb.md)   |
| wamp 组件维护 | [组件维护](wamp组件维护.md) |

## 版本说明

> 从 v3 版本开始确立的版本号的发布为： `wamp-v` + `A-B-C`

| 写法 | 说明                                                                  |
| ---- | --------------------------------------------------------------------- |
| `A`  | 主版本号，除非有重大技术更改，否则不会发布新版本                      |
| `B`  | 次版本号，当改变了 `php` `mariadb` `apache2` 等的版本时，会发布新版本 |
| `C`  | 小版本号，针对当前次版本的维护，会发布新版本                          |

## 更新说明

> wamp-v4.3.2 更新说明

1. php 升级至 `v7.3.2`
2. composer 升级至 `v.1.8.4`

> wamp-v4.3.1 更新说明

1. phpMyAdmin 升级至 `v4.8.5`
2. Adminer 升级至 `v4.7.1`
3. php_xdebug 升级至 `v2.7.0rc1`
4. composer 升级至 `v.1.8.3`

> wamp-v4.3.0 更新说明

1.  目录结构做了调整，在根目录增加了 `web` 目录
2.  将 `sites & www & data & logs` 这 4 个目录移动到 `web` 目录下
3.  `my.ini` 数据目录改为 `c:\wamp\web\data`
4.  apache24 配置文件的变量名做了相应调整：
    ```shell
    Define WAMP_ROOT "c:/wamp"
    Define WEB_ROOT "c:/wamp/web"
    Define BASE_ROOT "${WAMP_ROOT}/base"
    Define SRVROOT "${BASE_ROOT}/apache24"
    Define PHP_VERSION "php7"
    Define HTDOCS "${WEB_ROOT}/www"
    Define HTLOGS "${WEB_ROOT}/logs/apache24"
    ```

> wamp-v4.2.1 更新说明

1.  php 版本升级到 `7.3.1`
2.  mariadb 版本升级到 `10.3.12`
3.  php 目录下增加了 composer，版本为 `1.8.0`
4.  phpMyAdmin 版本升级到 4.8.4

> wamp-v4.2.0 更新说明

1.  php 版本升级到 php7.3.0
2.  php 目录下移除了 composer，有需要自行添加！

> wamp-v4.1.1 更新说明

1.  在 `v4.0.1` 的基础上，修复了部分 bug

> wamp-v4.0.1 更新说明

1.  在 `v4.0.0` 的基础上，重新设计了目录结构

> wamp-v4.0.0 更新说明

1.  移除了 32 位版本，mariadb 更新至 `10.3.11`
2.  `composer` 更新至 `1.8.0`

> wamp-v3.3.0 更新说明

1.  64 位版本，更新 php 至 7.2.12；
2.  `composer` 更新至 `1.7.3` ，将指定 php 根目录加入环境变量中即可在终端中使用，例如：
    ```shell
    $ composer -V
    ```

> wamp-v3.2.1 更新说明

1.  将 `php` 除了 `php_xdebug` 以外的所有扩展都禁用掉，需要的话自定开启；
2.  为 `php` 增加了 `composer` ，只需要将指定 php 根目录加入环境变量中即可在终端中使用，例如：
    ```shell
    $ composer -V
    ```
