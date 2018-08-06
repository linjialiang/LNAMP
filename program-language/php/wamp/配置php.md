# 配置php

> 开发环境只需要对php做简单配置

## 关于php配置文件 `php.ini`

> php根目录下有两个配置文件模板，我们复制其中1个并重命名为 `php.ini` 即可！

配置文件模板                | 描述
--------------------- | --------
`php.ini-development` | 开发环境推荐模板
`php.ini-production`  | 部署环境推荐模板

> 由于我们是开发环境，所以选择复制php.ini-development并重命名为php.ini（我们基本都在这个文件上修改）！

## php绑定apache24服务器

> 该节内容已经在 <配置apache24.md> 上说明过，这里不再重复

## 关于php模块

> php里的模块一节，需要通过我们配置才能正常运行

### 为php模块默认目录配置正确路径

> Windows系统默认情况下php扩展的默认存放目录是 `c:\php\etc`，我们需要修改成正确的目录路径

位数 | 所在行  | 修改前                       | 修改后
-- | ---- | ------------------------- | --------------------------------------
32 | 734行 | `; extension_dir = "ext"` | `extension_dir = "c:\wamp\32\php\etc"`
64 | 732行 | `; extension_dir = "ext"` | `extension_dir = "c:\wamp\64\php\etc"`

### 开启几个默认的并且重要的php扩展

> 那些重要的php官方扩展都在etc存放着，并且php.ini都已经写入了，只是默认都被注释掉，我们只需要将备注去掉即可，下面是一些常用扩展：

常用扩展                | 说明
------------------- | ----------------------------------------------------
`php_gd2.dll`       | php对图像处理的扩展
`php_mbstring.dll`  | php对多字节的支持（多国语言并存就意味着多字节）
`php_exif.dll`      | 让php可以操作图像元数据
`php_mysqli.dll`    | php对mysql的mysqli语法支持
`php_openssl.dll`   | php开启对openssl支持
`php_pdo_mysql.dll` | php对mysql支持pdo语法支持
`php_tidy.dll`      | php内置的html格式化/美化tidy函数
`php_xdebug.dll`    | php开发环境下的报错美化扩展，需去[xdebug官网](https://xdebug.org)下载对应版本

> php扩展写入php.ini格式

扩展文件名               | 格式1                           | 格式2
------------------- | ----------------------------- | ---------------------
`php_别名.dll`        | `extension=php_别名.dll`        | `extension=别名`
`php_mbstring.dll`  | `extension=php_mbstring.dll`  | `extension=mbstring`
`php_mysqli.dll`    | `extension=php_mysqli.dll`    | `extension=mysqli`
`php_pdo_mysql.dll` | `extension=php_pdo_mysql.dll` | `extension=pdo_mysql`
`php_xdebug.dll`    | `zend_extension=php_xdebug.dll`    | `zend_extension=xdebug`

> 由于xdebug的驱动程序与其它官方自带扩展不同，我们建议将其写在 php.ini 最下方，写法如下：

```shell
[xdebug]
zend_extension=xdebug
...
# 这里是一些xdebug的配置信息，具体查看相关说明
...
```

> 提示：php重要的扩展远不止这些，只有需要用到我们再开启它们。

## wamp开发环境下的php其它设置

> 虽然php.ini-development模板对开发环境做了推荐配置，但是有些时候我们需要灵活的测试，这就需要我们对一些配置有些了解

### php错误提示

> php.ini通过对display_errors的设置控制是否对php语法错误进行提示，默认开启错误提示

指令|错误提示
--|--
`display_errors = On`|开启错误提示
`display_errors = Off`|关闭错误提示

### php错误提示级别

> php.ini通过对error_reporting的设置控制php错误提示级别
