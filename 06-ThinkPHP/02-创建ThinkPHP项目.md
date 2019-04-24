# <center>创建 ThinkPHP 项目</center>

> 这里以创建 `ThinkPHP 6.0` 项目为例，来帮助新手解决 `git` 与 `composer` 的结合问题！

## 项目创建原理（首次）

> 首次创建项目的操作原理如下：

| 序号 | 操作               | 使用工具 | 需求情况               |
| ---- | ------------------ | -------- | ---------------------- |
| 01   | 下载 ThinkPHP 项目 | composer | 必备，包版本基于锁文件 |
| 02   | 更新 ThinkPHP 扩展 | composer | 必选，保持扩展最新     |
| 03   | 下载 ThinkPHP 扩展 | composer | 可选                   |
| 04   | 创建 gitee 版本库  | gitee    | 必选                   |
| 04   | 创建 github 版本库 | github   | 可选（国内不稳）       |

### 安装 qyadmin 项目

> 首先，使用 composer 安装 ThinkPHP 6.0 框架，并命名为 qyadmin

```shell
cd /wamp/web/www/
## 安装稳定版本
composer create-project topthink/think qyadmin
## 安装开发版
composer create-project topthink/think qyadmin 6.0.*-dev
```

> 提示：会将 ThinkPHP 核心及其必备 composer 扩展安装到 vendor 目录下

### 更新框架下自带扩展

> 框架下自带的扩展包版本较旧，需要通过 composer 来保持更新

```shell
cd qyamdin/
## 更新全部composer扩展
composer update
## 更新指定的composer扩展
composer update topthink/framework
```

> 提示：一般 ThinkPHP 框架的核心更新频率很高，需要经常更新框架核心

### 为 qyadmin 创建版本库

> 初始化本地仓库

```shell
## 初始化 git 仓库
git init
## 提交全部数据
git add .
git commit -m "初始化本地仓库成功！"
```

> 增加本地分支

```shell
# 以 master 分支 为基础，创建 dev 本地分支
$ git branch dev master
# 进入到新分支 dev
$ git checkout dev
```

> 添加远程仓库

```shell
## 添加gitee仓库地址
git remote add linjialiang-gitee https://gitee.com/linjialiang/qyadmin.git
## 添加github仓库地址
git remote add linjialiang-github https://github.com/linjialiang/qyadmin.git
```

> 推送本地分支至远程仓库（远程仓库需要是空白仓库）

```shell
## 推送dev分支到远程
git push -u linjialiang-gitee dev
git push -u linjialiang-gitee dev

## 推送master分支到远程
git push -u linjialiang-gitee master:master
git push -u linjialiang-gitee master:master
```

> 设置本地分支的默认远程分支（建议 gitee 为默认分支）

```shell
## 先取消默认远程分支
git branch --unset-upstream
git branch --unset-upstream master

## 设置默认远程分支
git branch --set-upstream-to linjialiang-gitee dev
git branch --set-upstream-to linjialiang-gitee/master master
```

---

## 其它电脑安装方式（非首次）

> 非首次创建项目的操作原理如下：

| 序号 | 操作               | 使用工具 | 需求情况               |
| ---- | ------------------ | -------- | ---------------------- |
| 01   | 下载 ThinkPHP 项目 | gitee    | 必备                   |
| 02   | 下载 composer 扩展 | composer | 必选，包版本基于锁文件 |
| 03   | 下载 composer 扩展 | composer | 必选，保持扩展最新     |
| 04   | 下载 ThinkPHP 扩展 | composer | 可选                   |

### 安装 qyadmin 项目

> 首先，使用 gitee 安装 qyadmin

```shell
git clone https://gitee.com/linjialiang/qyadmin.git
```

> 其次，管理分支

```shell
## 增加本地分支master
git checkout master
## 重命名gitee远程分支别名
git remote rename origin linjialiang-gitee
## 增加远程分支 github
git remote add linjialiang-github https://github.com/linjialiang/qyadmin.git
## 拉取远程仓库
git fetch linjialiang-github
```

> 最后，使用 composer 下载扩展

```shell
## 项目中 composer.lock 记录了所有使用到的composer扩展，我们直接下载即可
composer install
## 更新全部composer扩展包
composer update
## 更新指定的composer扩展包
composer update topthink/framework
```

> 到此，ThinkPHP 6.0 项目的创建过程已经结束！
