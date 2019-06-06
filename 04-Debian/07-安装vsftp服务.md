# 安装 VSFTP 服务

> VSFTP 是一个基于 GPL 发布的类 Unix 系统上使用的 FTP 服务器软件，它的全称是 Very Secure FTP 从此名称可以看出来，编制者的初衷是代码的安全。

## 安装 VSFTP

> 我们使用 debian 源镜像里已经编译好的包来安装 VSFTP

```shell
$ apt list vsftpd*
$ apt-get install vsftpd
```

## 配置 VSFTP

> vsftp 主要由下面这几个配置文件：

| 配置文件                    | 说明                 |
| --------------------------- | -------------------- |
| /etc/vsftpd.conf            | 主配置文件           |
| /etc/ftpusers               | vsftp 禁止登录的账户 |
| chroot_list_file 指定的文件 | 账号是否限制在家目录 |

> chroot_list_file 文件规则

| 参数属性值               | 说明                                       |
| ------------------------ | ------------------------------------------ |
| chroot_local_user =yes   | 本地用户默认限制在家目录（设置本地监狱）   |
| chroot_local_user =no    | 本地用户默认允许访问根目录（没有本地监狱） |
| chroot_list_enable = yes | chroot_list_file 指定的文件生效            |
| chroot_list_enable = no  | chroot_list_file 指定的文件无效            |

> 提示：chroot_list_file 指定的文件里的账户列表是 chroot_local_user 的例外
