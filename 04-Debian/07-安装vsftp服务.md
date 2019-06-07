# 安装 VSFTP 服务

> VSFTP 是一个基于 GPL 发布的类 Unix 系统上使用的 FTP 服务器软件，它的全称是 Very Secure FTP 从此名称可以看出来，编制者的初衷是代码的安全。

## 安装 VSFTP

> 我们使用 debian 源镜像里已经编译好的包来安装 VSFTP

```shell
$ apt list vsftpd*
$ apt-get install vsftpd
```

## 配置 VSFTP

> vsftp 主要涉及的几个配置文件：

文件                      | 作用
----------------------- | --------------------------------------
/etc/vsftpd.conf        | 最重要的配置文件
/etc/pam.d/vsftpd       | vsftpd 支持 pam 认证
/etc/ftpusers           | 禁止登录 vsftp 的账户（/etc/pam.d/vsftpd 里配置的）
/etc/shells             | 允许登录的 shell 类型（基于 pam_shells.so 模块）
/etc/vsftpd/user_list   | 是否禁止登录 vsftp 的账户（vsftp 自身认证）
/etc/vsftpd/chroot_list | 账户是否能离开账户家目录，即坐牢（vsftp 自身认证）
/srv/ftp                | 匿名用户登入 vsftp 的根目录

### vsftpd.conf 重要配置信息

> vsftpd.conf 其它选项说明，请查看 [vsftp选项说明](./info/vsftp选项说明.md)
