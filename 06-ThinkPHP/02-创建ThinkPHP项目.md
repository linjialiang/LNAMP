# <center>创建 ThinkPHP 项目</center>

> 这里以创建 `ThinkPHP 6.0` 项目为例，来帮助新手解决 `git` 与 `composer` 的结合问题！

## 首次创建项目

> 首次创建项目原理如下：

| 步骤 | 具体操作                   | 使用工具 |
| ---- | -------------------------- | -------- |
| 00   | 拉取 ThinkPHP 仓库作为项目 | git      |
| 01   | 创建项目远程仓库           | git      |
| 02   | 安装 ThinkPHP 框架必备库   | composer |
| 03   | 安装项目需要的库           | composer |
| 04   | 更新库的版本               | composer |
| 05   | 更新 ThinkPHP 框架         | git      |

### 拉取 ThinkPHP 仓库作为项目

> ThinkPHP 框架的仓库地址为：

| 框架仓库地址                            | 服务商 |
| --------------------------------------- | ------ |
| https://github.com/top-think/think.git  | github |
| https://gitee.com/liu21st/thinkphp5.git | gitee  |

> 涉及代码：

```shell
# 指定目录
cd \wamp\web\www\
# 下载项目的指定分支
git clone -b 6.0 https://github.com/top-think/think.git qyadmin
# 修改远程分支别名
git remote rename origin topthink-github
# 拉取6.0分支最新数据
git pull topthink-github 6.0
```

### 创建项目远程仓库

> qyadmin 项目的远程仓库地址如下：

| 项目仓库地址                               | 服务商 |
| ------------------------------------------ | ------ |
| https://github.com/linjialiang/qyadmin.git | github |
| https://gitee.com/linjialiang/qyadmin.git  | gitee  |

> 本地增加远程仓库

```shell
## 增加远程仓库
git remote add linjialiang-github https://github.com/linjialiang/qyadmin.git
git remote add linjialiang-gitee https://gitee.com/linjialiang/qyadmin.git
```

> 创建新分支

```shell
## 增加本地分支master，用于qyadmin项目稳定版本的发布（仅合并dev分支）
git branch master 6.0
## 增加本地分支dev，用于qyadmin项目的开发工作
git branch dev master
```

> 推送本地分支到远程

```shell
git push linjialiang-github 6.0
git push linjialiang-github master
git push linjialiang-github dev
git push linjialiang-gitee 6.0
git push linjialiang-gitee master
git push linjialiang-gitee dev
```

> 为本地分支设置默认远程分支

```shell
# 首先取消
git branch --unset-upstream 6.0
git branch --unset-upstream dev
git branch --unset-upstream master
# 设置默认远程分支
git branch --set-upstream-to linjialiang-gitee/6.0 6.0
git branch --set-upstream-to=linjialiang-gitee/dev dev
git branch --set-upstream-to linjialiang-gitee/master master
```

### 安装 ThinkPHP 框架必备库

> 框架必备库在 composer.json 上已经列出，代码如下：

```shell
# 切换到 dev 分支
git checkout dev
# composer安装框架必备库
composer install
# 将变化的数据提交到仓库
git add .
git commit -m "安装了框架必备的库！"
```

### 安装项目需要的库

> 当前项目需要的库，也是项目必备库，使用 require 添加，代码如下：

```shell
# 如：添加一个散列库（项目根目录下执行）
composer require linjialiang/hash
# 将变化的数据提交到仓库
git add .
git commit -m "安装了项目必要的库！"
```

### 更新库的版本

> 更新库的版本，如下代码：

```shell
composer update
# 如果数据发生变化，我们需要将变化的数据提交到仓库
git add .
git commit -m "更新了项目内库的版本号！"
```

### 更新 ThinkPHP 框架

> 注意切换到 6.0 分支进行，代码如下：

```shell
# 切换到6.0分支
git checkout 6.0
# 从think官方仓库拉取最新数据
git pull topthink-github 6.0
# 如果数据发生变化，我们需要将变化的数据提交到仓库
git add .
git commit -m "ThinkPHP对框架做了更新！"
```

> 将 6.0 分支合并到 dev 分支

```shell
# 合并分支
git checkout dev
git merge 6.0
# 如果有合并冲突，就需自行处理冲突
```

---

## 非首次创建项目

> 非首次创建项目原理如下：

| 步骤 | 具体操作             | 使用工具       |
| ---- | -------------------- | -------------- |
| 00   | 拉取项目远程仓库     | git            |
| 01   | 增加项目远程仓库     | git            |
| 02   | 安装项目必备库       | composer       |
| 03   | 安装项目需要添加的库 | composer       |
| 04   | 更新库的版本         | 与首次安装一致 |
| 05   | 更新 ThinkPHP 框架   | 与首次安装一致 |

### 拉取项目远程仓库

> gitee 远程仓库地址 https://gitee.com/linjialiang/qyadmin.git

```shell
# 拉取qyadmin项目的远程仓库
git clone https://gitee.com/linjialiang/qyadmin.git qyadmin
# 重命名远程仓库别名
git remote rename origin linjialiang-gitee
# 新建本地分支
git branch dev linjialiang-gitee/dev
git branch 6.0 linjialiang-gitee/6.0
```

### 增加项目远程仓库

```shell
# 增加ThinkPHP框架远程仓库
git remote add topthink-github https://github.com/top-think/think.git
# 增加qyadmn项目的github远程仓库
git remote add linjialiang-github https://github.com/linjialiang/qyadmin.git
```

### 安装项目必备库

> 项目必备库已经记录在 composer.json 和 composer.lock 中

```shell
# 切花到 dev 分支
git checkout dev
# 安装项目必备库
composer install
# 如果数据发生变化，我们需要将变化的数据提交到仓库
git add .
git commit -m "qyadmin项目更新了库！"
```

### 安装项目需要添加的库

> 如果项目需要添加新的库，就需要执行这一步

```shell
# 切花到 dev 分支
git checkout dev
# 如：添加一个库（项目根目录下执行）
composer require 用户名/库名
```
