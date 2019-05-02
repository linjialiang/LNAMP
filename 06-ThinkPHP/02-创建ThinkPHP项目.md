# <center>创建 ThinkPHP 项目</center>

> 这里以创建 `ThinkPHP 6.0` 项目为例，来帮助新手解决 `git` 与 `composer` 的结合问题！

## 首次创建项目

> 首次创建项目原理如下：

| 步骤 | 具体操作                   | 使用工具 |
| ---- | -------------------------- | -------- |
| 00   | 拉取 ThinkPHP 仓库作为项目 | git      |
| 01   | 创建项目远程仓库           | git      |
| 02   | 下载 ThinkPHP 框架必备库   | composer |
| 03   | 下载项目需要的库           | composer |
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

```

## 非首次创建项目

> 非首次创建项目原理如下：

| 步骤 | 具体操作             | 使用工具 |
| ---- | -------------------- | -------- |
| 00   | 拉取项目远程仓库     | git      |
| 01   | 增加项目远程仓库     | git      |
| 02   | 下载项目必备库       | composer |
| 03   | 下载项目需要添加的库 | composer |
| 04   | 更新库的版本         | composer |
| 05   | 更新 ThinkPHP 框架   | git      |

### 拉取项目远程仓库

> gitee 远程仓库地址 https://gitee.com/linjialiang/qyadmin.git

```shell
# 拉取qyadmin项目的远程仓库
git clone https://gitee.com/linjialiang/qyadmin.git qyadmin
```
