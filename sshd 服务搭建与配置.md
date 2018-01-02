# **sshd 服务搭建与配置**

> sshd 是远程控制服务器，最便捷与安全的工具（服务器默认已经安装）

## **安装 `openssh`**

```shell
# apt-get install ssh
```

## **ssh 服务端文件的简单配置**

> ssh 配置文件分 服务端与客户端

> - ssh 服务端文件 `/etc/ssh/sshd_config`
> - ssh 客户端文件 `/etc/ssh/ssh_config`

```shell
PermitRootLogin no              ## 禁止root通过ssh登录， 默认yes(yes是允许)
PermitEmptyPasswords no         ## 禁止空密码登陆， 默认no(yes是允许)
PasswordAuthentication yes      ## 设置是否允许口令验证，默认yes(no是拒绝)
# DenyGroups nossh              ## 禁止nossh用户群组登陆ssh， 增加
# DenyUsers testssh             ## 禁止testssh用户登陆ssh， 增加
```

## **ssh限制ip登录ssh**

- 允许通过文件 `/etc/hosts.allow`

  ```shell
  sshd: 192.168.1.3 168.68.0.0/16  ## 只允许1个IP和1个IP段登录
  ```

- 禁止通过文件 `/etc/hosts.deny`

  ```shell
  sshd : ALL                            ## 禁止所有IP登陆
  ```

--------------------------------------------------------------------------------
