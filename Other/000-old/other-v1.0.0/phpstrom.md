# `phpstrom` 配置指南

## 单点调试

> 为 phpstrom 配置xdebug断点调试功能（直接贴录制的gif图片）

![phpstrom断点调试配置](./phpstrom-xdebug/phpstrom断点调试配置.gif)

> 首先 php.ini 需要配置好 xdebug 的信息（代码以我们自己配置的 `WAMP` 为例子）

```shell
[xdebug]
zend_extension=xdebug
xdebug.profiler_append = 0
xdebug.profiler_enable = 1
xdebug.profiler_enable_trigger = 0
xdebug.profiler_output_dir ="C:\wamp\logs\xdebug"
xdebug.trace_output_dir ="C:\wamp\logs\xdebug"
xdebug.profiler_output_name = "cache.out.%t-%s"
xdebug.remote_enable = 1
xdebug.remote_autostart = 1
xdebug.remote_handler = "dbgp"
xdebug.remote_host = "127.0.0.1"
xdebug.idekey= PHPSTROM
```

> 下面是一些比较重要的截图

![php配置文件](./phpstrom-xdebug/php配置文件.png)

--------------------------------------------------------------------------------

![调试别名](./phpstrom-xdebug/调试别名.png)

--------------------------------------------------------------------------------

![url调试程序](./phpstrom-xdebug/url调试程序.png)

--------------------------------------------------------------------------------

![配置服务站点](./phpstrom-xdebug/配置服务站点.png)

--------------------------------------------------------------------------------

![建立调试的url](./phpstrom-xdebug/建立调试的url.png)

--------------------------------------------------------------------------------

![开始调试](./phpstrom-xdebug/开始调试.png)

--------------------------------------------------------------------------------

![继续研究](./phpstrom-xdebug/继续研究.png)





|dad|daf|
|--|--|
|daf|fafa|
|1|12r43tg|
