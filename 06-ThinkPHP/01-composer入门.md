# <center>composer 入门</center>

## 安装 composer

> composer 在不同平台安装基本一致，[访问官方](https://getcomposer.org/download/)查看教程，这里简单讲解下：

| composer 依赖 | 描述             |
| ------------- | ---------------- |
| PHP 版本      | PHP 5.3.2+       |
| PHP 扩展      | openssl 扩展开启 |

> 进入指定 php 版本的根目录依次输入 3 条命令：

```shell
# 下载脚本文件
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
# 检测文件是否被篡改
php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
# 执行脚本，安装 composer
php composer-setup.php
# 移除安装脚本
php -r "unlink('composer-setup.php');"
```

> 执行脚本选项说明：

```shell
# --install-dir 指定目标目录，如：
php composer-setup.php --install-dir=bin
# --filename 指定文件名 (默认: composer.phar) ，如：
php composer-setup.php --filename=composer
# --version 指定安装特定的发行版本，如：
php composer-setup.php --version=1.0.0-alpha8
```

> Linux 下为 composer 加入全局调用：

```shell
# 移动 composer.phar 到 bin 目录下，并重命名为 compoer：
mv composer.phar /usr/local/bin/composer
```

> Windows 下为 composer 加入全局调用：

```shell
# 将 php 根目录加入 `PATH` 环境变量中；
# 进入 php 根目录，输入一行指令：
echo @php "%~dp0composer.phar" %*>composer.bat
```

---

## 切换 composer 镜像

> 如果 composer 镜像不能正常访问，我们可以更换成国内镜像：

```shell
# 全局切换镜像源：
composer config -g repo.packagist composer https://packagist.laravel-china.org

# 如果仅限当前工程使用镜像，去掉 -g 即可，如下：
composer config repo.packagist composer https://packagist.laravel-china.org

# 恢复官方镜像：
composer config -g repo.packagist composer https://packagist.org
```
