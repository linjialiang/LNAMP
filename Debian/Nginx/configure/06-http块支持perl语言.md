# 让 http 块支持 perl 预约

> 该 ngx_http_perl_module 模块用于在 Perl 中实现位置和变量处理程序，并将 Perl 调用插入到 SSI 中。

1. `--with-http_perl_module`

   > 启动构建 ngx_http_perl_module 模块，默认情况下不构建此模块。

   - 模块用于在 Perl 中实现位置和变量处理程序，并将 Perl 调用插入到 SSI 中。
   - 使用 `--with-http_perl_module=dynamic` 可以动态构建 ngx_http_perl_module 模块

2. `--with-perl_modules_path=PATH`

   > 定义了一个保留 Perl 模块的目录。

3. `--with-perl=PATH`

   > 设置 Perl 二进制可执行文件的路径及名称。
