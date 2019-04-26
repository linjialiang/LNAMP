# <center>Composer 快速手册</center>

> 该文档是基于 composer 官方手册的精简版本！

| 指令             | 描述                         |
| ---------------- | ---------------------------- |
| composer init    | 初始化 composer              |
| composer install | 安装 composer 包             |
| composer update  | 更新 composer 包             |
| composer require | 申明当前 composer 包的依赖项 |

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

## 初始化 init

> 初始化其实就是创建 composer.json 的过程，分为手动创建和 `init` 指令两种！

1. init 指令创建

   > init 指令非常简单的，就是按照终端提示，一步步完成

2. 手动创建
   > 手动创建也不困难，这两个前提都要求我们对 composer.json 文件内的属性有清晰的了解，这个在后面会详细讲解

## 安装 install

> install 命令从当前目录读取 composer.json 文件，处理了依赖关系，并把其安装到 vendor 目录下。

1. 存在 composer.lock 文件

   > 如果当前目录下存在 composer.lock 文件，它会从此文件读取依赖版本，而不是根据 composer.json 文件去获取依赖。这确保了该库的每个使用者都能得到相同的依赖版本。

2. 不存在 composer.lock 文件

   > 如果没有 composer.lock 文件，composer 将在处理完依赖关系后创建它。

> install 的参数说明请查看[官方手册](https://docs.phpcomposer.com/03-cli.html#install)

## 更新 update

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

## 申明依赖 require

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
