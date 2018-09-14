# windows全局安装composer

> 确保本地已经安装了php5.6+，并加入path变量
>
> 下载安装脚本php（php需要开启openssl扩展）

```shell
php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"
```

> 执行安装过程

```shell
php composer-setup.php
```

> 移除安装脚本

```shell
php -r "unlink('composer-setup.php');"
```

> 找到并进入 PHP 的安装目录（和你在命令行中执行的 php 指令应该是同一套 PHP）。
>
> 将 composer.phar 复制到 PHP 的安装目录下面，也就是和 php.exe 在同一级目录。
>
> 在 PHP 安装目录下新建一个 composer.bat 文件，并将下列代码保存到此文件中。

```shell
@php "%~dp0composer.phar" %*
```

> 提示：不要忘了经常执行 composer selfupdate 以保持 Composer 一直是最新版本哦！

## 修改 composer 的全局配置文件

> 打开命令行窗口（windows用户）或控制台（Linux、Mac 用户）并执行如下命令：

```shell
composer config -g repo.packagist composer https://packagist.phpcomposer.com

## 近期可使用这个
composer config -g repo.packagist composer https://packagist.laravel-china.org
```
