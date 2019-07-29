# 构建 zlib 库选项

1. `--with-zlib=DIR`

   > 设置 zlib 库源的路径。[zlib 官网](http://zlib.net/) 下载符合版本（如：zlib 1.2.11 版）并解压缩。其余的工作由 nginx 通过 ./configure 和 make 完成。

2. `--with-zlib-opt=OPTIONS`

   > 为 zlib 设置额外构建选项。

3. `--with-zlib-asm=CPU`
   > 使用为指定 CPU 优化的 zlib 汇编器源，有效值为： pentium、pentiumpro。
