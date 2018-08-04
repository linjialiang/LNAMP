# `tp5` 下 `composer` 相关指令汇总

---

## 安装 `composer`
> 去官方下载 ms 安装包，双击执行
> - [composer.exe](https://getcomposer.org/Composer-Setup.exe "点击下载composer.exe")

---

## 使用国内镜像

```shell
composer config -g repo.packagist composer https://packagist.phpcomposer.com
```

---

## 安装 `tp5`
> 在命令行下面，切换到你的 `WEB根目录` 下面并执行下面的命令：
> 1. 在当前目录下新建一个 `www_tp5_com` 目录
> 2. 在 `www_tp5_com` 目录下，下载最新版本的 `ThinkPHP`
> 3. `www_tp5_com` 就是我们后面会经常提到的应用根目录

```shell
composer create-project topthink/think www_tp5_com
```

## 更新 `tp5`
> 切换到你的应用根目录下面，然后执行下面的命令进行更新：

```shell
composer update topthink/framework
```

### 安装 `tp5` 最新的开发版本
> 一般情况下， `composer` 安装的是最新的稳定版本，不一定是最新版本；
> 如果你需要安装实时更新的版本，可以安装5如果你需要安装实时更新的版本，可以安装5.1.x-dev版本。

```shell
composer create-project topthink/think=5.1.x-dev www_tp5_com
```
