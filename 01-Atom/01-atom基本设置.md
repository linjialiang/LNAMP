# <center>atom 基本设置</center>

> 这小节主要讲解 Atom 的基本设置以及文件的作用

## 常用文件说明

> 安装完 Atom 后会在当前用户的目录下面创建一个 `.atom` 目录，所有的配置都在这里进行

## 目录结构

> Atom 配置目录的结构如下：

```shell
├─ .atom                                    Atom配置根目录
|   ├─.apm                                  忽略的目录
|   |
|   ├─.node-gyp                             安装插件基础
|   |
|   ├─blob-store                            忽略的目录
|   |
|   ├─compile-cache                         忽略的目录
|   |
|   ├─other                                 自定义目录
|   |   ├─php-cs-fixer.phar                 php代码格式化基础包
|   |   ├─file-header                       头文件插件
|   |   |   ├─lang-mapping.json             自定义配置文件
|   |   |   ├─templates                     自定义模板目录
|   |   |   └─...
|   |
|   ├─packages                              插件存放目录
|   |
|   ├─recovery                              忽略的目录
|   |
|   ├─storage                               忽略的目录
|   |
|   ├─.apmrc                                代理配置文件
|   |
|   ├─.gitignore                            git忽略文件
|   |
|   ├─config.cson                           配置信息文件
|   |
|   ├─github.cson                           忽略的文件
|   |
|   ├─init.coffee                           忽略的文件
|   |
|   ├─keymap.cson                           自定义快捷键文件
|   |
|   ├─projects.cson                         Project Manager插件的配置文件
|   |
|   ├─snippets.cson                         自定义代码片段
|   |
|   └─styles.less                           自定义界面样式文件
|
├─github                                    忽略的目录
|
└─emmet                                     忽略的目录
```

## 基本设置

> 通过快捷键 `Ctrl-,` 可以打开基本设置界面，界面如下：

![Atom设置界面](./static/01/设置界面.png)

> 具体如何设置看个人喜好，大家也可以参考我的配置文件：

| 配置文件                                  | 文件说明           |
| ----------------------------------------- | ------------------ |
| [`.apmrc`](./source/.apmrc)               | 配置代理文件       |
| [`config.cson`](./source/config.cson)     | 界面与插件配置信息 |
| [`keymap.cson`](./source/keymap.cson)     | 自定义快捷键信息   |
| [`styles.less`](./source/styles.less)     | 自定义样式信息     |
| [`projects.cson`](./source/projects.cson) | 保存的项目信息     |
