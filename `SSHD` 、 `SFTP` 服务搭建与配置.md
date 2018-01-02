# **`SSHD` 、 `SFTP` 服务搭建与配置**

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

### **用 TCP Wrappers 限制 SSH**

hosts.allow                      | 允许内容
-------------------------------- | ------------
sshd:192.168.200.1               | ssh允许单个ip
sshd:192.168.200.                | ssh允许ip端
sshd:192.168.200., 192.168.100.1 | ssh允许多个ip
in.telnetd:192.168.200.1         | telnet允许单个ip

hosts.deny     | 允许内容
-------------- | ----
sshd:ALL       | 禁止全部
in.telnetd:ALL | 禁止全部

- _`hosts.allow` 、 `hosts.deny` 书写格式_

  1. `/etc/hosts.allow`

    ```shell
    # cp /etc/hosts.allow{,.backup}
    # vim /etc/hosts.allow
    ```

    ```hosts.allow
    sshd: .baidu.com , 192.168.1.3, 192.168.1.
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
  # cp /etc/sshd_config{,.kackup}
  # vim /etc/sshd_config
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
X11Forwarding no  ## 如果是 yes 改成 no，如果不存在则添加
Subsystem sftp internal-sftp   ## 将Subsystem sftp 修改成 internal-sftp，如果不存在则添加
Match Group usergroup1 usergroup2          ## usergroup1 usergroup2 是我们自定义的2个用户组
    AllowTcpForwarding no       ## 进制tcp端口转发，保护其他的tcp连接
    ChrootDirectory %h          ## 绑定到家目录
    ForceCommand internal-sftp  ## 登录方式，强制按internal-sftp来
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

6. 更改用户 user1 的 shell 为拒绝登录（拒绝ftp登录）

  ```shell
  # usermod -s /bin/false user1
  ```

7. 更改用户 user2 的 shell 为拒绝登录（拒绝ftp登录）

  ```shell
  # usermod -s /usr/sbin/nilogin
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
