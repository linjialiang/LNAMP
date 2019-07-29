# 构建 pcre 库选项

1. `--without-pcre`

   > 禁用 PCRE 库的使用。

2. `--with-pcre`

   > 强制使用已安装的 PCRE 库。

3. `--with-pcre=DIR`

   > 设置 PCRE 库源的路径。该库是 location 指令和 ngx_http_rewrite_module 模块中的正则表达式支持所必需的。

   - [PCRE 官网](http://www.pcre.org/) 下载符合版本（如：pcre-8.43 版）并解压缩。其余的工作由 nginx 通过 ./configure 和 make 完成。

4. `--with-pcre-opt=OPTIONS`

   > 为 PCRE 设置额外的构建选项

5. `--with-pcre-jit`
   > 让构建的 PCRE 库支持 即时编译(pcre_jit 指令)
