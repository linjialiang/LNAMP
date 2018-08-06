# 配置php

> 开发环境只需要对php做简单配置

## 关于php配置文件 `php.ini`

> php根目录下有两个配置文件模板，我们复制其中1个并重命名为 `php.ini` 即可！

配置文件模板                | 描述
--------------------- | --------
`php.ini-development` | 开发环境推荐模板
`php.ini-production`  | 部署环境推荐模板

> 由于我们是开发环境，所以选择复制php.ini-development并重命名为php.ini

## php绑定apache24服务器

> 该节内容已经在 [配置apache24.md](配置apache24.md) 上说明过，这里不再重复

## 关于php模块

> php里的模块一节，需要通过我们配置才能正常运行

1. 为php模块默认目录配置正确路径

>
