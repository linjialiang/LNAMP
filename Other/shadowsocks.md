# **`shadowsocks` 代理配置**

> - 代理服务器是 debian 8.x
> - 客户端系统是 ms-win10

## 客户端

> 客户端很简单就是一个 `shadowsocks-windows` 软件 软件下载地址 >> `https://github.com/shadowsocks/shadowsocks-windows/releases`

## 服务器端

> 服务器端必须满足自己的需要，比如说想翻墙的用户，就需要海外的 vpn 项目地址 >> `https://github.com/shadowsocks/shadowsocks`

### 安装 `shadowsocks`

> `debian 8.x` 安装 `shadowsocks` 很简单（服务端命令和客户端命令其实是一同安装的）

```shell
# apt-get update && apt-get upgrade && apt-get dist-upgrade
# apt-get install python
# pip install shadowsocks
# mkdir /etc/shadowsocks
# touch /etc/shadowsocks/config.json
```

### 配置 `shadowsocks`

> `shadowsocks` 需要一些配置，不然不能正常工作 打开用户配置文件 `vim /etc/shadowsocks/config.json`

1. `config.json` 添加单用户

  ```json
  {
  "server":"0.0.0.0",
  "server_port":8388,
  "local_address": "127.0.0.1",
  "local_port":1080,
  "password":"123456",
  "timeout":300,
  "method":"aes-256-cfb",
  "fast_open": false
  }
  ```

2. `config.json` 添加多用户

  ```json
  {
  "server":"0.0.0.0",
  "local_address": "127.0.0.1",
  "local_port":1080,
  "port_password": {
  "8388": "123456",
  "8389": "123456"
  },
  "timeout":300,
  "method":"aes-256-cfb",
  "fast_open": false
  }
  ```

### `shadowsocks` 几个有用的客户端命令

1. 客户端-前端启动 `shadowsocks`

  ```shell
  sslocal -c /etc/shadowsocks/config.json
  ```

2. 客户端-后端启动 `shadowsocks`

  ```shell
  sslocal -c /etc/shadowsocks/config.json -d start
  ```

3. 客户端-停止运行 `shadowsocks`

  ```shell
  sslocal -c /etc/shadowsocks/config.json -d stop
  ```

4. 客户端-重新启动 `shadowsocks`

  ```shell
  sslocal -c /etc/shadowsocks/config.json -d restart
  ```

### `shadowsocks` 几个有用的服务端命令

1. 服务端-前端启动 `shadowsocks`

  ```shell
  ssserver -c /etc/shadowsocks/config.json
  ```

2. 服务端-后端启动 `shadowsocks`

  ```shell
  ssserver -c /etc/shadowsocks/config.json -d start
  ```

3. 服务端-停止运行 `shadowsocks`

  ```shell
  ssserver -c /etc/shadowsocks/config.json -d stop
  ```

4. 服务端-重新启动 `shadowsocks`

  ```shell
  ssserver -c /etc/shadowsocks/config.json -d restart
  ```

### `shadowsocks` 设置开机启动

> 需要操作 2 个文件

#### 创建 `shadowsocks` 开机启动项配置文件

1. 新建开机启动项文件

  ```shell
  touch /etc/init/shadowsocks.conf
  ```

2. 配置文件

  ```shell
  start on (runlevel [2345])stop on (runlevel [016])pre-start script
  /etc/init.d/shadowsocks start
  end script

  post-stop script
  /etc/init.d/shadowsocks stop
  end script
  ```

3. 保存并退出

  ```shell
  wq
  ```

4. Debian系不需要创建 `/etc/init/shadowsocks.conf` 文件，直接执行：

  ```shell
  # update-rc.d shadowsocks defaults
  ```

#### 将 `shadowsocks` 加入到开机启动项

1. 打开开机启动项配置文件

  ```shell
  vim /etc/rc.local
  ```

2. 如果 `rc.local` 文件带有 `ssserver` 的一大段默认的代码,请删除

3. 再在eixt 0 之前加进去下面这段：

  ```local
  ssserver -c /etc/shadowsocks/config.json -d start
  ```

4. 保存并退出

  ```shell
  wq
  ```

### 查看 `shadowsocks` 的日志

```shell
vim /var/log/shadowsocks.log
```

### 查看系统运行的端口号

```shell
netstat -tnulp
```

### 让 `shadowsocks` 支持全局环境命令行模式

1. 新建 `shadowsocks` 全局配置文件

  ```shell
  touch /etc/init.d/shadowsocks
  ```

2. 配置全局配置文件

  ```conf
  #!/bin/sh
  start(){
  ssserver -c /etc/shadowsocks/config.json -d start
  }
  stop(){
  ssserver -c /etc/shadowsocks/config.json -d stop
  }
  case "$1" in
  start)
  start
  ;;
  stop)
  stop
  ;;
  reload)
  stop
  start
  ;;
  *)
  echo "Usage: $0 {start|reload|stop}"
  exit 1        
  ;;
  esac
  ```

3. 保存并退出，增加文件当前文件的可执行权限（一般root）

  ```shell
  wq
  chmod +x /etc/init.d/shadowsocks
  ```

### 关于服务器防火墙

> - 服务器： `公网出方向` 需要向所有网络、所有端口开启
> - 服务器： `公网入方向` 需要向 `客户端（一个固定ip或ip段）` 开启 `服务器端口（一个特定端口，如：8388）`
> - 客户端： 代理端口 `1080` 服务器端口 `8388` 服务器ip `服务器的公网ip` 密码 `123456` 密码加密方式 `aes-256-cfb`

```json
{
  "server":"0.0.0.0",
  "server_port":8388,
  "local_address": "127.0.0.1",
  "local_port":1080,
  "password":"123456",
  "timeout":300,
  "method":"aes-256-cfb",
  "fast_open": false
}
```

### 注意事项

> - 说明：在 `openssl1.1.0` 版本中，废弃了 `EVP_CIPHER_CTX_cleanup` 函数， 用 `EVP_CIPHER_CTX_reset` 函数替代（不是必然发生）
> - 修改：在 `openssl.py` 文件中将 `EVP_CIPHER_CTX_cleanup` 替换成 `EVP_CIPHER_CTX_reset`

--------------------------------------------------------------------------------

### 附录一：关于 debian 9 下面不存在 `/etc/rc.local` 的解决方法

> 由于某些软件并没有增加开启启动的服务，很多时候需要手工添加，一般我们都是推荐添加命令到 /etc/rc.local 文件，但是 Debian 9 默认不带 /etc/rc.local 文件，而 rc.local 服务却还是自带的

1. 首先查看 `rc.local.service` 文件信息

  ```shell
  root@debian9 ~ # cat /lib/systemd/system/rc.local.service
  ```

  ```conf
  #  This file is part of systemd.
   #
   #  systemd is free software; you can redistribute it and/or modify it
   #  under the terms of the GNU Lesser General Public License as published by
   #  the Free Software Foundation; either version 2.1 of the License, or
   #  (at your option) any later version.

   # This unit gets pulled automatically into multi-user.target by
   # systemd-rc-local-generator if /etc/rc.local is executable.
   [Unit]
   Description=/etc/rc.local Compatibility
   ConditionFileIsExecutable=/etc/rc.local
   After=network.target

   [Service]
   Type=forking
   ExecStart=/etc/rc.local start
   TimeoutSec=0
   RemainAfterExit=yes
   GuessMainPID=no
  ```

2. 默认情况下 `rc.local.service` 这个服务，处于关闭的状态

  ```shell
  root@debian9 ~ # systemctl status rc-local
   ● rc-local.service - /etc/rc.local Compatibility
      Loaded: loaded (/lib/systemd/system/rc-local.service; static; vendor preset: enabled)
     Drop-In: /lib/systemd/system/rc-local.service.d
              └─debian.conf
      Active: inactive (dead)
  ```

3. 解决这个问题，我们需要手工添加一个 `/etc/rc.local` 文件
> `cat <<EOF >/etc/rc.local`

  ```conf
  #!/bin/sh -e
   #
   # rc.local
   #
   # This script is executed at the end of each multiuser runlevel.
   # Make sure that the script will "exit 0" on success or any other
   # value on error.
   #
   # In order to enable or disable this script just change the execution
   # bits.
   #
   # By default this script does nothing.

   exit 0
   EOF
  ```

4. 赋予 `/etc/rc.local` 文件权限

  ```shell
  chmod +x /etc/rc.local
  ```

5. 接着启动 `rc-local` 服务

  ```shell
  systemctl start rc-local
  ```

6. 查看 `rc-local` 服务状态

  ```shell
  root@debian9 ~ # systemctl status rc-local
  ```

7. 出现下面信息，则服务开启成功

  ```shell
  ● rc-local.service - /etc/rc.local Compatibility
     Loaded: loaded (/lib/systemd/system/rc-local.service; static; vendor preset: enabled)
    Drop-In: /lib/systemd/system/rc-local.service.d
             └─debian.conf
     Active: active (exited) since Thu 2017-08-03 09:41:18 UTC; 14s ago
    Process: 20901 ExecStart=/etc/rc.local start (code=exited, status=0/SUCCESS)

  Aug 03 09:41:18 xtom-proxy systemd[1]: Starting /etc/rc.local Compatibility...
  Aug 03 09:41:18 xtom-proxy systemd[1]: Started /etc/rc.local Compatibility.
  ```

8. 然后我们可以把需要开机启动的命令添加到 `/etc/rc.local` 文件，丢在 `exit 0` 前面即可，并尝试重启以后试试是否生效了
