# **sshd、sftp服务搭建与配置**

> sshd 是远程控制服务器，最便捷与安全的工具（服务器默认已经安装）

## **安装 `openssh`**

```shell
# apt-get install ssh
# /etc/init.d/ssh resart        ## 重启ssh
```

## **ssh 服务端文件的简单配置**

> ssh 配置文件分 服务端与客户端

> - ssh 服务端文件 `/etc/ssh/sshd_config`
> - ssh 客户端文件 `/etc/ssh/ssh_config`

```sshd_config
PermitRootLogin no              ## 禁止root通过ssh登录， 默认yes(yes是允许)
PermitEmptyPasswords no         ## 禁止空密码登陆， 默认no(yes是允许)
PasswordAuthentication yes      ## 设置是否允许口令验证，默认yes(no是拒绝)
# DenyGroups nossh              ## 禁止nossh用户群组登陆ssh， 增加
# DenyUsers testssh             ## 禁止testssh用户登陆ssh， 增加
```

## **限制ssh登陆**

> - 建议使用 `TCP Wrappers` 按 `主机名/域或IP` 阻止主机；
> - 并且使用 `sshd_config` 实现基于 `用户/组` 的访问控制。

### **用 `hosts.allow` 和 `hosts.deny` 限制 SSH**

> `hosts.allow` 和 `hosts.deny` 规则的执行者为 `TCP wrappers`，对应守护进程为 `tcpd` ；而 `tcpd` 执行依赖于程序使用了 `libwrap` 库

> - 也就是说： `hosts.allow` 和 `hosts.deny` 支持且只支持使用了 `libwrap` 库的服务

hosts.allow                | 允许内容
-------------------------- | ------------
sshd:192.168.200.1         | ssh允许单个ip
sshd:192.168.              | ssh允许1个ip段
sshd:192.168.*             | ssh允许1个ip段
sshd:192.168.0.0/16        | ssh允许1个ip段
sshd:192.168., 192.1.89.32 | ssh允许多个ip
in.telnetd:192.1.89.32     | telnet允许单个ip

hosts.deny     | 允许内容
-------------- | ----
sshd:ALL       | 禁止全部
in.telnetd:ALL | 禁止全部

> _`hosts.allow` 、 `hosts.deny` 书写格式_

1. `/etc/hosts.allow`

  ```shell
  # cp /etc/hosts.allow{,.backup}
  # vim /etc/hosts.allow
  ```

  ```hosts.allow
  sshd: www.baidu.com , 192.0.1.189, 192.168.0.0/16
  in.telnetd:192.168.200.1
  ```

2. `/etc/hosts.deny`

  ```shell
  # cp /etc/hosts.deny{,.backup}
  # vim /etc/hosts.deny
  ```

  ```hosts.deny
  sshd:ALL
  in.telnetd:ALL
  ```

> _PS: 查看应用包是否使用libwarp（是否支持hosts.allow和hosts.deny）_

1. 查看hosts_access字段串 查看应用程序是否支持 wrapper，可以使用 strings 程序然后 grep 字符串 hosts_access

  ```shell
  # strings /usr/sbin/sshd | grep hosts_access
  hosts_access
  ```

2. 使用ldd

  ```shell
  # ldd /usr/sbin/sshd | grep libwrap
  libwrap.so.0 => /lib/x86_64-linux-gnu/libwrap.so.0 (0x00007fda94d5e000)
  ```

## **限制用户登录ssh**

> - 这是在 ssh 配置文件 `/etc/ssh/sshd_config` 里面操作的
> - 下面这四个命令在配置文件里，应该只出现1个，这样才不会导致不必要的混乱

command     | 说明
----------- | ------
AllowUsers  | 允许的用户
AllowGroups | 允许的用户组
DenyUsers   | 禁止的用户
DenyGroups  | 禁止的用户组

### _操作_

```shell
  # cp /etc/ssh/sshd_config{,.kackup}
  # vim /etc/ssh/sshd_config
```

```sshd_config
  AllowUsers user1 user2          ## 只允许 user1 user2 用户登录ssh
  # AllowGroups group1 group2     ## 只允许 group1 group2 用户组登录ssh
  # DenyUsers user1 user2         ## 只拒绝 user1 user2 登录ssh
  # DenyGroups group1 group2      ## 只拒绝 group1 group2 登录ssh
```

## **ssh配置sftp**

> 这是一个比 `vsftpd` 更加安全的传输协议

```shell
# cp /etc/ssh/sshd_config{,.backup}
# vim /etc/ssh/sshd_config
```

```sshd_config
## 前面一般有 `X11Forwarding` 的指令，需要删除或备注，见下文说明
X11Forwarding no  ## 提高传输速度，但是 `ssh` 的安全性可能会降低
## 前面一般有的 `Subsystem sftp` 指令，需要删除或备注，见下文说明
Subsystem sftp internal-sftp
## usergroup 是我们自定义的用户组（测试结果，仅支持1个用户组）
Match Group usergroup
  ## 进制tcp端口转发，保护其他的tcp连接
  AllowTcpForwarding no
  ## 绑定到家目录
  ChrootDirectory %h  
  ## 登录方式，强制按internal-sftp来    
  ForceCommand internal-sftp
```

> `sshd_config` 配置文件如果存在一下内容需要注释掉

1. `X11Forwarding yes` 注释掉或删除

  > 在配置文件末尾已经加上 `X11Forwarding no`

  > - 可以提高 SFTP 传输速度，但是安全性可能会降低

  ```sshd_config
  ## X11Forwarding yes
  ```

2. `Subsystem sftp` 注释掉或删除

  > 在配置文件末尾已经加上 `Subsystem sftp internal-sftp`

  > - 下面两段内容，在 `sshd_conf` 中一般会出现一段

  ```sshd_config
  ## Subsystem sftp /usr/lib/openssh/sftp-server
  ```

  ```sshd_config
  ## Subsystem sftp /usr/libexec/openssh/sftp-server
  ```

## **用户/用户组 操作**

> linux必须要掌握一些用户、用户组的操作，下面都是实践总结下来的

1. 新建一个用户组 usergroup

  ```shell
  # groupadd usergroup
  ```

2. 新建用户 user1、user2

  > debian 下 `useradd` `adduser` 是不一样的，centos 则完全相同

  > ```shell
  > # useradd user1     ## home下不会创建user1目录，并不会要求设置密码
  > # adduser user2     ## home创建user2目录，并要求设置密码等
  > ```

3. 用户 user1 加入 usergroup 用户组

  ```shell
  # usermod -G usergroup
  ```

4. 用户 user2 更改主用户组为 usergroup

  ```shell
  # usermod -g usergroup
  ```

5. 从用户组 usergroup 里移除 user1 用户

  ```shell
  # gpasswd usergroup -d user1
  ```

6. 更改用户 user1 的 shell 为拒绝一切服务（拒绝ftp登录，拒绝ssh远程登录）

  ```shell
  # usermod -s /bin/false user1
  ```

7. 更改用户 user2 的 shell 为拒绝login系统（允许ftp登录，拒绝ssh远程登录）

  ```shell
  # usermod -s /usr/sbin/nologin
  ```

8. 更改用户 user1 的 shell 允许登录 （允许ssh远程登录）

  ```shell
  # usermod -s /bin/bash
  ```

9. 修改用户 user1 目录为 /home/newdir1

  ```shell
  # usermod -d /home/newdir1 user1
  ```

10. 修改用户 user2 目录为 /home/newdir2 ，如果目录不存在，则强制建立目录

  ```shell
  # usermod -d /home/newdir2 -m user2
  ```

11. 将用户 user1 添加到附加组 group1 之前的附加组消失

  ```shell
  # usermod -G group user1
  ```

12. 将用户 user2 添加到其它附加组, 加上 `-a` 之前的附加组会保留着

  ```shell
  # usermod -G group1,group2 user2
  ```

13. 修改用户 user1 名称为 newuser1

  ```shell
  # usermod -l newuser1 user1
  ```

14. 修改用户组 usergroup 名称为 newgroup

  ```shell
  # groupmod -n newgroup usergroup
  ```

15. debian 下新建 `ftp` `sftp` 用户

  > - 用户名 `baidu_com`
  > - 添加附属用户组 `-G group-www-data`
  > - 目录为 `-d /alidata/www-data/baidu_com`
  > - 如果目录不存在，则强制建立目录 `-m`
  > - 指定主用户组 `-g baidu_com`
  > - 只允许ftp登录，不允许ssh远程登录 `-s /usr/sbin/nologin`

  ```shell
  # useradd -d /alidata/www-data/baidu_com -s /usr/sbin/nologin -G group-www-data -m baidu_com
  # useradd -d /alidata/www-data/baidu_com -s /usr/sbin/nologin -g group_baidu_com -G www-data -m baidu_com
  # paddwd baidu_com
  # 输入两次密码
  ```

16. centos 下新建 `ftp` `sftp` 用户

  > - 用户名 `baidu_com`
  > - 添加附属用户组 `-G group-www-data`
  > - 目录为 `-d /alidata/www-data/baidu_com`
  > - 如果目录不存在，则强制建立目录 `-m`
  > - 指定主用户组 `-g baidu_com`
  > - 只允许ftp登录，不允许ssh远程登录 `-s /sbin/nologin`

  ```shell
  # useradd -d /alidata/www-data/baidu_com -s /sbin/nologin -g group_baidu_com -G group-www-data -m baidu_com
  # paddwd baidu_com
  # 输入两次密码
  ```

## 附录一：ssh 终端登录方式
```shell
# ssh://username:passwd@ip:22
```
