# <center>创建 ThinkPHP 项目</center>

> 这里以创建 `ThinkPHP 6.0` 项目为例，来帮助新手解决 `git` 与 `composer` 的结合问题！

| 版本库名称              | 托管平台 | 版本库地址                                 |
| ----------------------- | -------- | ------------------------------------------ |
| ThinkPHP 框架官方基础包 | github   | https://github.com/top-think/think.git     |
| ThinkPHP 框架官方基础包 | gitee    | https://gitee.com/top-think/think.git      |
| qyadmin 后台管理系统    | github   | https://github.com/linjialiang/qyadmin.git |
| qyadmin 后台管理系统    | gitee    | https://gitee.com/linjialiang/qyadmin.git  |

> 提示：如果你的网络不能正常使用 github 就全部使用 gitee 的仓库

## 创建原理

> 创建项目的操作原理如下：

| 序号 | 操作                           | 使用工具 | 需求情况 |
| ---- | ------------------------------ | -------- | -------- |
| 01   | 下载 ThinkPHP 框架官方基础包   | Git      | 必备     |
| 02   | 下载 ThinkPHP 核心（官方扩展） | composer | 必备     |
| 03   | 下载 ThinkPHP 其它扩展         | composer | 可选     |

## Git 操作

> 下面是创建与管理 tp6 项目操作的具体步骤：

### 拉取框架

> 使用 Git 拉取框架基础包到本地，并指定拉取 `6.0` 分支

```shell
# 指定目录
$ cd /c/wamp/web/www/
# 将 ThinkPHP 框架的 6.0 分支拉取下来，并将项目命名为 qyadmin
$ git clone --branch=6.0 https://github.com/top-think/think.git qyadmin
# 进入 qyadmin 项目
$ cd qyadmin
```

### 操作版本库

> 远程版本库重命名，增加自己的远程版本库

```shell
# 修改远程版本库名称
$ git remote rename origin topthink-github
# 增加自己的远程版本库
$ git remote add linjialiang-github https://github.com/linjialiang/qyadmin.git
$ git remote add linjialiang-gitee https://gitee.com/linjialiang/qyadmin.git
# 本地 6.0 分支更新数据方式(不会拉取多余的分支和标签)
$ git pull topthink-github 6.0
```

> 为远程空版本库创建分支：

```shell
# 设置默认远程分支，并推送内容
$ git push -u linjialiang-gitee 6.0
# 推送内容到github远程版本库
$ git push -u linjialiang-github 6.0
```

> 本地创建一个用于开发的分支，今后我们都在该分支上开发：

```shell
# 以 6.0 分支 为基础，创建 dev1 本地分支
$ git branch dev1 6.0
# 进入到新分支 dev1
$ git checkout dev1
# 为 dev1 设置默认远程分支，并推送内容
$ git push --set-upstream linjialiang-gitee dev1
# 推送分支内容到github远程版本库
$ git push linjialiang-github
```

> 本地版本库创建 `master` 分支，并设置为版本库默认分支：

```shell
# 以 `dev1分支` 为基础，创建 master 分支：
$ git branch master dev1
# 进入到新分支 master
$ git checkout master
# 为 dev1 设置默认远程分支，并推送内容
$ git push --set-upstream linjialiang-gitee master
# 推送分支内容到 github 远程版本库
$ git push linjialiang-github
```

> 分支简要说明：

| 分支     | 描述                                                          |
| -------- | ------------------------------------------------------------- |
| `6.0`    | 该分支同步 ThinkPHP 官方最新代码，不做其他用途                |
| `dev1`   | 该分支为开发分支，需要合并最新的 6.0 分支                     |
| `master` | 该分支是 qyadmin 项目的默认分支，合并开发分支下已经稳定的数据 |

> 注意：在版本库托管平台上将 maste 设置成默认分支

## Composer 操作

> composer 操作应该都在开发分支下进行操作

```shell
# 进入 dev1 分支
$ git checkout dev1
# composer 更新 topthink/framework
$ composer update topthink/framework
```

> 注意：composer 更新完数据后，会有一些文件被会改变，这里记得提交！

## 其它电脑操作

> 其它电脑与首台电脑略有不同，具体操作如下：

```shell
# 进入指定目录
$ cd /c/wamp/web/www
# 下载自己的远程版本库，这个远程版本库会被默认版本
$ git clone https://gitee.com/linjialiang/qyadmin.git qyadmin
# 进入版本库
cd tp6
# 重命名远程版本库
$ git remote rename origin linjialiang-gitee
# 添加远程版本库，linjialiang-github
$ git remote add linjialiang-github https://github.com/linjialiang/qyadmin.git
# 添加远程版本库，topthink-github
$ git remote add topthink-github https://github.com/top-think/think.git
# 快速创建本地的 dev1 master 这两个版本库
$ git checkout dev1
$ git checkout master
# 拉取 linjialiang-github 版本库所有内容
$ git fetch linjialiang-github
# 拉取 topthink-github 的 6.0 分支
$ git fetch topthink-github 6.0
# 更改6.0分支的绑定的默认远程分支为：topthink-github/6.0
$ git branch --unset-upstream 6.0
$ git branch --set-upstream-to=topthink-github/6.0 6.0
```

> 提示：Composer 操作与首台电脑一致，这里就不再重复了！

## 结束语

> 到此，ThinkPHP 6.0 项目的创建过程已经结束！
