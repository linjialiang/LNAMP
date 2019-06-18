<!-- TOC START min:1 max:3 link:true asterisk:false update:true -->
- [debian 基本配置](#debian-基本配置)
    - [设置静态 ip](#设置静态-ip)
    - [修改 DNS](#修改-dns)
    - [ssh 允许 root 连接远程](#ssh-允许-root-连接远程)
    - [配置镜像源](#配置镜像源)
    - [美化bash终端](#美化bash终端)
    - [安装必备工具](#安装必备工具)
<!-- TOC END -->

# debian 基本配置

> debian 刚刚安装完成，还需要进行一系列的配置，才能更好的使用

## 设置静态 ip

> 网络地址设置成静态 ip，方便 ssh 远程管理

```shell
$ cp /etc/network/interfaces{,.bak}
$ vi /etc/network/interfaces
```

> 动态 ip 设置

```conf
source /etc/nerwork/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary nerwork interfaces
allow-hotplug enp0s3
iface enp0s3 inet dhcp
```

> 静态 ip 设置

```conf
source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary nerwork interfaces
allow-hotplug enp0s3
iface enp0s3 inet static
        address 192.168.10.252
        netmask 255.255.255.0
        gateway 192.168.10.1
```

> 关闭/开启网卡

```shell
$ ifdown enp0s3
$ ifup enp0s3
```

> 重启网络

```shell
$ service networking restart
$ systemctl restart network
$ /etc/init.d/networking restart
```

## 修改 DNS

> DNS 对网络速度和网络安全有很大的作用

```shell
$ cp /etc/resolv.conf{,.bak}
$ vi /etc/resolv.conf
```

> 提示：虚拟机桥接安装后的首选 dns 为 192.168.10.1，如无必要，不需要修改

## ssh 允许 root 连接远程

> 开发环境下，推荐使用 root 账户远程连接，这样非常便捷

```shell
$ cp /etc/ssh/sshd_config{,.bak}
$ vi /etc/ssh/sshd_config
```

> 找到 `PermitRootLogin` 去掉备注，并将属性值改为 yes

```shell
PermitRootLogin yes
```

> 重启 ssh

```shell
$ /etc/init.d/ssh restart
```

## 配置镜像源

> 安装好 debian 后，我们需要按照自身的需求配置好镜像源文件

```shell
$ cp /etc/apt/sources.list{,.bak}
$ vi /etc/apt/sources.list
```

> `sources.list` 文件内容：

```conf
deb http://mirrors.163.com/debian/ stretch main non-free contrib
deb http://mirrors.163.com/debian/ stretch-updates main non-free contrib
deb http://mirrors.163.com/debian/ stretch-backports main non-free contrib
deb-src http://mirrors.163.com/debian/ stretch main non-free contrib
deb-src http://mirrors.163.com/debian/ stretch-updates main non-free contrib
deb-src http://mirrors.163.com/debian/ stretch-backports main non-free contrib
deb http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib
deb-src http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib
```

> 更新源索引/更新包

```shell
$ apt-get update
$ apt-get dist-upgrade
```

## 美化bash终端

> 用户根目录下的 `.bashrc` 可以让bash控制台的界面更加清晰

```shell
$ vi ~/.bashrc
```

```shell
PS1='[${debian_chroot:+($debian_chroot)}\u@debian9 \W]\$ '
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS -F'
alias ll='ls $LS_OPTIONS -lF'
alias lla='ls $LS_OPTIONS -laF'
```

## 安装必备工具

> 有些系统工具非常有用，而我们的极简安装可能都没有安装上

1. lrzsz

  > lrzsz是一款在linux里可代替ftp上传和下载的程序

  ```shell
  $ apt install lrzsz
  ```

2. zip/unzip

  > zip压缩和解压缩（有必要再安装）

  ```shell
  $ apt install zip unzip
  ```

3. tar/tar.gz/tar.bz2

  > linux下最常使用的压缩工具

  ```shell
  $ apt install tar bzip2 gzip
  ```
