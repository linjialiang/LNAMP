## wamp 使用说明书

> 这是wamp软件包使用指南，现在基于wamp-v3.2.1版本,操作步骤如下：

## 获得软件包

> 首先要获得文软件包

1.  在 `ThinkPHP快速入门二群` 提供 `wamp-v2.0.6.7z` 下载）

    > 在看云上购买 [thinkphp5快速入门手册](https://www.kancloud.cn/thinkphp/thinkphp5_quickstart/) 可加入该群

2.  百度网盘下载地址

    > 见 [wamp组件维护](https://www.kancloud.cn/madnesslin/wamp/758157) 章节

## 解压到指定目录

> 可以直接解压到c盘根目录下，这样就不需要自行配置了

## 开启必要的php扩展

> 默认情况下，仅开启了 `php_xdebug` 扩展，其它扩展需手动修改，
> 很简单，直接去php.ini文件里，将扩展所在行注释（最前面的分号 `;` ）去掉即可

| 版本  | php.ini路径                |
| --- | ------------------------ |
| 兼容版 | `c:\wamp\32\php\php.ini` |
| 推荐版 | `c:\wamp\64\php\php.ini` |

> v4版本开始移除了32位的兼容版

| 版本       | php.ini路径             |
| -------- | --------------------- |
| `v4.x.x` | `c:\wamp\php\php.ini` |

## 为wamp环境安装必备运行库

> 使用 `c:\wamp` 目录下 `运行库.bat` 脚本文件

## 将wamp环境的相关服务写入windows系统服务

> 使用 `c:\wamp` 目录下 `install.bat` 脚本文件

## 经常使用的脚本 `便捷指令.bat`

> 这个脚本是我们经常使用的，功能如下：

| 序号  | 功能               |
| --- | ---------------- |
| 1   | `apache2 服务一键重启` |
| 2   | `mariadb 服务一键重启` |
| 3   | `服务开机启动选项`       |

> wamp使用说明就简单的说到这里了!
