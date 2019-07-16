# Composer 快速手册

> 该文档是基于 composer 官方手册的精简版本！

| 指令                    | 描述                         |
| ----------------------- | ---------------------------- |
| composer init           | 初始化 composer              |
| composer install        | 安装 composer 包             |
| composer update         | 更新 composer 包             |
| composer require        | 申明当前 composer 包的依赖项 |
| composer create-project | 创建项目                     |

> 次要指令

| 指令                 | 描述                                               |
| -------------------- | -------------------------------------------------- |
| composer global      | COMPOSER_HOME 目录下执行其它命令                   |
| composer search      | 为当前项目搜索依赖包                               |
| composer show        | 列出所有可用的软件包                               |
| composer depends     | 查出已安装的某个包，是否被其它包所依赖，并列出他们 |
| composer validate    | 检测 composer.json 文件是否有效                    |
| composer status      | 依赖包状态检测                                     |
| composer self-update | 将 Composer 自身升级到最新版本                     |
| composer config      | 编辑 Composer 的一些基本设置                       |

## 重要指令解释

> 这里我们只讲解了个别重要的指令，其它指令请[查看手册](https://docs.phpcomposer.com)

### 初始化 init

> 初始化其实就是创建 composer.json 的过程，分为手动创建和 `init` 指令两种！

1. init 指令创建

   > init 指令非常简单的，就是按照终端提示，一步步完成

2. 手动创建
   > 手动创建也不困难，这两个前提都要求我们对 composer.json 文件内的属性有清晰的了解，这个在后面会详细讲解

### 安装 install

> install 命令从当前目录读取 composer.json 文件，处理了依赖关系，并把其安装到 vendor 目录下。

1. 存在 composer.lock 文件

   > 如果当前目录下存在 composer.lock 文件，它会从此文件读取依赖版本，而不是根据 composer.json 文件去获取依赖。这确保了该库的每个使用者都能得到相同的依赖版本。

2. 不存在 composer.lock 文件

   > 如果没有 composer.lock 文件，composer 将在处理完依赖关系后创建它。

> install 的参数说明请查看[官方手册](https://docs.phpcomposer.com/03-cli.html#install)

### 更新 update

> 为了获取依赖的最新版本，并且升级 composer.lock 文件，你应该使用 update 命令。

1. 更新全部

   > 这将解决项目的所有依赖，并将确切的版本号写入 composer.lock

   ```shell
   composer update
   ```

2. 更新个别包

   > 如果你只是想更新几个包，你可以像这样分别列出它们：

   ```shell
   composer update composer_username/package_name [...]
   ```

   > 举例

   ```shell
   composer update topthink/framework linjialiang/hash
   ```

3. 批量更新

   > 你还可以使用通配符进行批量更新：

   ```shell
   composer update composer_username1/*
   ```

   > 举例

   ```shell
   composer update topthink/*
   ```

> update 的参数说明请查看[官方手册](https://docs.phpcomposer.com/03-cli.html#update)

### 申明依赖 require

> require 命令增加新的依赖包到当前目录的 composer.json 文件中。并且在添加或改变依赖时， 修改后的依赖关系将被安装或者更新。

```shell
composer require
```

> 如果你不希望通过交互来指定依赖包，你可以在这条令中直接指明依赖包。

```shell
composer require composer_username/package_name:version [...]
```

> 举例

```shell
composer require topthink/framework:6.0.*-dev linjialiang/hash:0.0.6
```

> 注意：`:version` 缺省为最新版本，也可以自己指定一个固定版本号，支持使用通配符指定次版本号

### 创建项目 create-project

> 你可以使用 Composer 从现有的包中创建一个新的项目。

| 序号 | create-project 流程                        |
| ---- | ------------------------------------------ |
| 01   | 执行了一个 git clone 命令后                |
| 02   | 并将这个包的依赖安装到它自己的 vendor 目录 |

> 如果该目录目前不存在，则会在安装过程中自动创建

```shell
composer create-project composer_username/project_name path version
```

> 举例

```shell
composer create-project topthink/think /www/tp6 6.0.*-dev
```

## composer.json 架构

> 下面我们来讲解 composer 中 最重要的文件 composer.json

### `Root 包` 概念

> “root 包”是指由 composer.json 定义的在你项目根目录的包。这是 composer.json 定义你项目所需的主要条件。（简单的说，你自己的项目就是一个 root 包）
>
> - 如果你克隆了其中的一个依赖包，直接在其上开始工作，那么它就变成了“root 包”。与作为他人的依赖包时使用相同的 composer.json 文件，但上下文发生了变化。
> - 注意： 一个资源包是不是“root 包”，取决于它的上下文。 例：如果你的项目依赖 monolog 库，那么你的项目就是“root 包”。 但是，如果你从 GitHub 上克隆了 monolog 为它修复 bug， 那么此时 monolog 就是“root 包”。

### 属性

> 这里列出了 composer.json 部分属性名，详情[查看手册](https://docs.phpcomposer.com/04-schema.html)

| 属性名       | 别名         | 描述                                              |
| ------------ | ------------ | ------------------------------------------------- |
| name         | 包名         | 包的名称，它包括供应商名称和项目名称，使用 / 分隔 |
| description  | 描述         | 一个包的简短描述                                  |
| version      | 版本         | 版本号不是必须的，并且建议忽略                    |
| type         | 安装类型     | 包的安装类型，默认为 library                      |
| keywords     | 关键字       | 该包相关的关键词的数组。这些可用于搜索和过滤。    |
| homepage     | 项目主页     | 该项目网站的 URL 地址。                           |
| time         | 版本发布时间 | YYYY-MM-DD 或 YYYY-MM-DD HH:MM:SS 格式            |
| license      | 许可协议     | 如：Apache-2.0                                    |
| authors      | 作者         | 包的作者。这是一个对象数组。                      |
| support      | 支持         | 获取项目支持的向相关信息对象。                    |
| require      | 软件包列表   | 除非这些依赖被满足，否则不会完成安装。            |
| require-dev  | 仅 root 包   | 这个列表是为开发或测试等目的                      |
| conflict     | 冲突包列表   | 此列表中的包与当前包的这个版本冲突。              |
| replace      | 替代包列表   | 这个列表中的包将被当前包取代                      |
| suggest      | 建议安装的包 | 它们增强或能够与当前包良好的工作。                |
| autoload     | 自动加载     | PHP autoloader 的自动加载映射                     |
| PSR-4        | 自动加载规则 | psr-4 自动加载规则                                |
| PSR-0        | 自动加载规则 | psr-0 自动加载规则                                |
| Classmap     | 引用组合     | 存储到 vendor/composer/autoload_classmap.php 中   |
| Files        | 自动加载规则 | 在每次请求时都要载入某些文件，通常是函数库        |
| autoload-dev | 仅 root 包   | 本节允许为开发目的定义 autoload 规则              |
| include-path | include 加载 | 一个追加到 PHP include_path 中的列表              |
| target-dir   | ...          | 定义当前包安装的目标文件夹                        |
| config       | 仅 root 包   | 定义项目级的 composer 基础配置                    |
| scripts      | 仅 root 包   | 允许在安装过程中的各个阶段挂接脚本。              |
| extra        | ...          | 供 scripts 使用的额外数据                         |
| bin          | ...          | 该属性用于标注一组应被视为二进制脚本的文件        |
| archive      | ...          | 这些选项在创建包存档时使用                        |

## 附录：安装 composer

> composer 在不同平台安装基本一致，[访问官方](https://getcomposer.org/download/)查看教程，这里简单讲解下：

| composer 依赖 | 描述             |
| ------------- | ---------------- |
| PHP 版本      | PHP 5.3.2+       |
| PHP 扩展      | openssl 扩展开启 |

> 进入指定 php 版本的根目录依次输入 3 条命令：

```shell
# 下载脚本文件
$ php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
# 检测文件是否被篡改
$ php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
# 执行脚本，安装 composer
$ php composer-setup.php
# 移除安装脚本
$ php -r "unlink('composer-setup.php');"
```

> 执行脚本选项说明：

```shell
# --install-dir 指定目标目录，如：
$ php composer-setup.php --install-dir=bin
# --filename 指定文件名 (默认: composer.phar) ，如：
$ php composer-setup.php --filename=composer
# --version 指定安装特定的发行版本，如：
$ php composer-setup.php --version=1.0.0-alpha8
```

> Linux 下为 composer 加入全局调用：

```shell
# 移动 composer.phar 到 bin 目录下，并重命名为 compoer：
$ mv composer.phar /usr/local/bin/composer
```

> Windows 下为 composer 加入全局调用：

```shell
# 将 php 根目录加入 `PATH` 环境变量中；
# 进入 php 根目录，输入一行指令：
$ echo @php "%~dp0composer.phar" %*>composer.bat
```

### 切换 composer 镜像

> 如果 composer 镜像不能正常访问，我们可以更换成国内镜像：

```shell
# 全局切换镜像源：
$ composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

# 如果仅限当前工程使用镜像，去掉 -g 即可，如下：
$ composer config repo.packagist composer https://mirrors.aliyun.com/composer/

# 恢复官方镜像：
$ composer config -g repo.packagist composer https://packagist.org

# 调试
$ composer -vvv require alibabacloud/sdk
```
