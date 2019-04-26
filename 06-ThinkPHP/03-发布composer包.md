# <center>发布 composer 包</center>

> 自己发布 composer ，这样也方便自己和别人在 composer 上直接安装！

## 发布步骤

> composer 包发布过程需经历一下过程：

| 步骤 | 描述                                          |
| ---- | --------------------------------------------- |
| 01   | 注册一个 github 账户                          |
| 02   | github 上创建`满足composer条件`的仓库         |
| 03   | https://packagist.org/ 上注册账户             |
| 04   | https://packagist.org/ 上提交 github 仓库地址 |
| 05   | composer 之后会同步更新 github 上的仓库版本   |

## 仓库规则说明

> 这里仅是符合 ThinkPHP 的最基本 composer 包，具体参考 composer 官方手册！

### 目录结构

> 这是展现的 composer 包的一般目录结构

```shell
├─根目录               composer包名称
│  ├─src                类库目录
│  ├─func_name.php      函数库文件
│  ├─composer.json      composer配置文件
│  ├─REMADE.ME          仓库自述文件
│  ├─.gitignore         仓库忽略跟踪文件
│  │
```

> 具体说明

| 结构            | 描述                                           |
| --------------- | ---------------------------------------------- |
| `src`           | 该目录下存放 composer 包的所有类库，目录名随意 |
| `func_name.php` | 该文件是 composer 包的函数库文件               |
| `composer.json` | php 和 composer 可识别的文件                   |

## composer.json 说明

> composer.json 中定义了您当前项目的依赖项。[参考手册](https://docs.phpcomposer.com/04-schema.html)

```shell
{
    "name": "linjialiang/hash",
    "description": "The ThinkPHP6 Hash",
    "authors": [
        {
            "name": "linjialiang",
            "email": "linjialiang@163.com"
        }
    ],
    "license": "Apache-2.0",
    "require": {
        "php": ">=7.1.0"
    },
    "autoload": {
        "psr-4": {
            "qyadmin\\": "src"
        },
        "files": []
    }
}
```

| 重要属性 | 描述                          |
| -------- | ----------------------------- |
| name     | 包名                          |
| authors  | 作者信息                      |
| require  | 需要依赖的其它包              |
| autoload | PHP autoloader 的自动加载映射 |

| autoload 子属性 | 描述                                                                    |
| --------------- | ----------------------------------------------------------------------- |
| psr-0           | psr-0 自动加载规则                                                      |
| psr-4           | psr-4 自动加载规则                                                      |
| files           | 自动加载函数库文件                                                      |
| classmap        | 引用的所有组合，都会存储到 vendor/composer/autoload_classmap.php 文件中 |

> 到此发布 composer 包基本思路已经完成！
