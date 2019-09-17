# lnmp 一次升级操作

> 我在 wsl 上安装的 lnmp 运行了几个月时间，现在有很多包都更新了，现在我们就来做一次全面的升级操作！

## 升级 wsl 子系统

> 第一步，我们应该先升级系统

```shell
$ apt update
$ apt upgrade       # 小版本更新方式
$ apt dist-upgrade  # 大版本更新方式
```

更新完系统后，我们会发现 mariadb 已经更新到了最新版本 `10.4.8`

## 更新 nginx
