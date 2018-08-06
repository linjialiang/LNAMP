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
-- | ---- | ------------------------- | --------------------
32 | 734行 | `; extension_dir = "ext"` | `c:\wamp\32\php\etc`
64 | 732行 | `; extension_dir = "ext"` | `c:\wamp\64\php\etc`
