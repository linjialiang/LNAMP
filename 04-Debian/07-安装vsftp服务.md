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

> 创建vsftp用户

```shell
# 语法
$ useradd -m -c <备注> -d <家目录> -g <群组> -G <附属群组> -s <登录shell> <用户名>
# 案例
$ useradd -m -c 'vsftpd username' -d /data/www -g www -G ftp -s /usr/sbin/nologin www
$ passwd www
```

> 将 /usr/sbin/nologin 这个shell，加入到pam验证允许登录列表中

```shell
$ cp /etc/shells{,.bak}
$ vim /etc/shells
```

```conf
# 如不加入一行
/usr/sbin/nologin
```

> 本地用户只有加入到 userlist_file 指定的文件中才能正常登录

```shell
$ vim /etc/vsftpd/user_list
```

```conf
ftp_user1
ftp_user2
ftp_user3
```

> 配置好所有事情，我们就可以重新加载vsftp程序了

```shell
$ /etc/init.d/vsftpd reload
```

### 配置方案

> 方案一：主动模式配置

```conf
listen=NO
listen_ipv6=YES
listen_port=21
anonymous_enable=NO
local_enable=YES
local_max_rate=0
write_enable=YES
file_open_mode=0666
local_umask=022
max_clients=5
max_per_ip=2
use_localtime=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
data_connection_timeout=300
idle_session_timeout=300

# 主动模式
port_enable=YES
connect_from_port_20=YES
ftp_data_port=20
connect_timeout=60

# 被动模式
pasv_enable=NO
pasv_min_port=60001
pasv_max_port=60100
accept_timeout=60

## 用户坐牢
chroot_local_user=YES
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd/chroot_list

## 用户禁止登录
userlist_enable=YES
userlist_deny=NO
userlist_file=/etc/vsftpd/user_list

## 开启加密，需要安装openssl包
ssl_enable=YES
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
```

> 方案二：被动模式配置（推荐）

```conf
listen=NO
listen_ipv6=YES
listen_port=21
anonymous_enable=NO
local_enable=YES
local_max_rate=0
write_enable=YES
file_open_mode=0666
local_umask=022
max_clients=5
max_per_ip=2
use_localtime=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
data_connection_timeout=300
idle_session_timeout=300

# 主动模式
port_enable=NO
connect_from_port_20=YES
ftp_data_port=20
connect_timeout=60

# 被动模式
pasv_enable=YES
pasv_min_port=60001
pasv_max_port=60100
accept_timeout=60

## 用户坐牢
chroot_local_user=YES
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd/chroot_list

## 用户禁止登录
userlist_enable=YES
userlist_deny=NO
userlist_file=/etc/vsftpd/user_list

## 开启加密，需要安装openssl包
ssl_enable=YES
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
```

> 注意：被动模式下指定的端口号似乎无效，这个需要处理

## 附录：vsftpd.conf 重要配置信息

> vsftpd.conf 其它选项说明，请查看 [vsftp选项说明](./info/vsftp选项说明.md)

- listen

  ```text
  如果启用，vsftpd将以独立模式运行。这意味着不能从某种类型的inetd运行vsftpd。相反，vsftpd可执行文件直接运行一次。然后，vsftpd将负责监听和处理传入的连接。
  默认值：YES
  ```

- listen_ipv6

  ```text
  与listen参数一样，除了vsftpd将侦听IPv6套接字而不是IPv4套接字。此参数和listen参数是互斥的。
  默认值：NO
  ```

- listen_port

  ```text
  如果vsftpd处于独立模式，则它将侦听传入FTP连接的端口。
  默认值：21
  ```

- anonymous_enable

  ```text
  控制是否允许匿名登录。如果启用，则用户名 ftp 和 anonymous 都将被识别为匿名登录。
  默认值：YES
  ```

- local_enable

  ```text
  控制是否允许本地登录。如果启用，则可以使用/etc/passwd中的普通用户帐户（或PAM配置引用的任何位置）登录。必须启用此功能才能使任何非匿名登录工作，包括虚拟用户。
  默认值：NO
  ```

- local_max_rate

  ```text
  本地身份验证用户允许的最大数据传输速率（以字节/秒为单位）。
  默认值：0（无限制）
  ```

- write_enable

  ```text
  这可以控制是否允许任何更改文件系统的ftp命令。这些命令是：stor，dele，rnfr，rnto，mkd，rmd，appe和site。
  默认值：NO
  ```

- guest_enable

  ```text
  如果启用，则所有非匿名登录都被归类为“访客”登录。guest 虚拟机登录将重新映射到guest_username 设置中指定的用户 。
  默认值：NO
  ```

- guest_username

  ```text
  有关guest虚拟机 登录的说明，请参阅boolean设置 guest_enable。此设置是访客用户映射到的真实用户名。
  默认值：ftp
  ```

- file_open_mode

  ```text
  用于创建上载文件的权限。Umasks应用于此值之上。如果您希望上传的文件可执行，您可能希望更改为0777。
  默认值：0666
  ```

- local_umask

  ```text
  为本地用户设置用于文件创建的umask的值。注意！如果要指定八进制值，请记住“0”前缀，否则该值将被视为基数为10的整数！
  默认值：077
  ```

- max_clients

  ```text
  如果vsftpd处于独立模式，则这是可以连接的最大客户端数。连接的任何其他客户端都将收到错误消息。
  默认值：0（无限制）
  ```

- max_per_ip

  ```text
  如果vsftpd处于独立模式，则这是可以从同一源Internet地址连接的最大客户端数。如果客户端超过此限制，则会收到错误消息。
  默认值：0（无限制）
  ```

- use_localtime

  ```text
  如果启用，vsftpd将显示当前时区中包含时间的目录列表。默认为显示GMT。MDTM FTP命令返回的时间也受此选项的影响。
  默认值：NO
  ```

- port_enable

  ```text
  如果要禁止使用PORT方法获取数据连接，请设置为NO。
  默认值：YES
  ```

- connect_from_port_20

  ```text
  这可以控制PORT样式数据连接是否在服务器计算机上使用端口20（ftp-data）。出于安全原因，一些客户可能会坚持认为是这种情况。相反，禁用此选项可使vsftpd以较低的权限运行。
  默认值：NO（但是示例配置文件启用它）
  ```

- ftp_data_port

  ```text
  PORT样式连接源自的端口（只要命名不佳的 connect_from_port_20 已启用）。
  默认值：20
  ```

- connect_timeout

  ```text
  远程客户端响应PORT样式数据连接的超时（以秒为单位）。
  默认值：60
  ```

- pasv_enable

  ```text
  如果要禁用PASV获取数据连接的方法，请设置为NO。
  默认值：YES
  ```

- pasv_max_port

  ```text
  为PASV样式数据连接分配的最大端口。可用于指定窄端口范围以协助防火墙。
  默认值：0（使用任何端口）
  ```

- pasv_min_port

  ```text
  为PASV样式数据连接分配的最小端口。可用于指定窄端口范围以协助防火墙。
  默认值：0（使用任何端口）
  ```

- accept_timeout

  ```text
  远程客户端与PASV样式数据连接建立连接的超时（以秒为单位）。
  默认值：60
  ```

- data_connection_timeout

  ```text
  超时（以秒为单位），大致是允许数据传输停止而没有进度的最长时间。如果超时触发，则启动远程客户端。
  默认值：300
  ```

- idle_session_timeout

  ```text
  超时（以秒为单位），即远程客户端在FTP命令之间可能花费的最长时间。如果超时触发，则启动远程客户端。
  默认值：300
  ```

- pam_service_name

  ```text
  此字符串是vsftpd将使用的PAM服务的名称。
  默认值：ftp
  ```

- chroot_local_user

  ```text
  如果设置为YES，则登录后本地用户（默认情况下）将放置在其主目录中的chroot()监狱中。 警告： 此选项具有安全隐患，尤其是在用户具有上载权限或shell访问权限的情况下。只有在您知道自己在做什么时才启用。请注意，这些安全隐患不是特定于vsftpd的。它们适用于所有提供将本地用户放在chroot()监狱中的FTP守护进程。
  默认值：NO
  ```

- chroot_list_enable

  ```text
  如果激活，您可以在登录时提供放置在其主目录中的chroot()监狱中的本地用户列表。如果chroot_local_user设置为YES，则含义略有不同。在这种情况下，列表将成为不被放置在chroot()监狱中的用户列表。默认情况下，包含此列表的文件是/etc/vsftpd.chroot_list，但您可以使用chroot_list_file 设置覆盖它 。
  默认值：NO
  ```

- chroot_list_file

  ```text
  该选项是包含本地用户列表的文件的名称，该列表将放置在其主目录中的chroot()监狱中。仅当 启用了选项chroot_list_enable时，此选项才有意义 。如果 启用了chroot_local_user选项 ，则列表文件将成为不放在chroot()监狱中的用户列表。
  默认值：/etc/vsftpd.chroot_list
  ```

- userlist_enable

  ```text
  如果启用，vsftpd将从userlist_file给出的文件名加载用户名列表 。如果用户尝试使用此文件中的名称登录，则在要求输入密码之前，他们将被拒绝。这可能有助于防止传输明文密码。另请参见 userlist_deny。
  默认值：NO
  ```

- userlist_deny

  ```text
  如果 激活userlist_enable，则检查此选项 。如果将此设置设置为NO，则将拒绝用户登录，除非它们明确列在userlist_file指定的文件中 。拒绝登录时，将在要求用户输入密码之前发出拒绝。
  默认值：YES
  ```

- userlist_file

  ```text
  此选项是userlist_enable 选项处于活动状态时加载的文件的名称 。
  默认值：/etc/vsftpd.user_list
  ```

- hide_file

  ```text
  此选项可用于设置文件名（包括目录名）从目录列表中隐藏。
  尽管被隐藏，但是知道实际使用的名称的客户可以完全访问它们。
  如果项目的名称包含hide_file给出的字符串，或者它们与hide_file指定的正则表达式匹配，则将隐藏这些项目。

  注意：
    vsftp的正则表达式匹配代码是一个简单的实现，它是完整正则表达式功能的子集。
    有关具体支持的正则表达式语法的详细信息，请参阅 deny_file。示例：hide_file = {*.mp3,.hidden,hide*,h?}
  默认值:(无）
  ```

- deny_file

  ```text
  此选项可用于设置，让某些指定的文件名（包括目录名）无法访问；
  受影响的文件不会被隐藏，但ftp客户端不能对这些文件做任何事情，即：下载、更改路径、修改文件等都将被拒绝；
  此选项非常简单，不应用于严格的访问控制，建议对任何重要的安全策略使用文件系统权限。
  但是，此选项在某些虚拟用户设置中可能很有用。
  特别要注意的是，如果文件名可以通过各种名称访问（可能是由于符号链接或硬链接），那么必须注意拒绝访问所有名称。
  如果项目的名称包含hide_file给出的字符串，或者它们与hide_file指定的正则表达式匹配，则将拒绝访问项目。

  请注意：
    vsftp 支持的正则表达式是完整正则表达式功能的子集。因此，您需要仔细而详尽地测试此选项的任何应用程序。
    1）仅在路径的最后一个组件上支持正则表达式匹配；
    2）支持的正则表达式语法是任意数量的 * 、? 和 非嵌套的{,}运算符；
    3）例如：a/b/? 支持，但 a/?/c 不支持。示例：deny_file = {*.mp3,*.mov,.private}
  默认值:(无）
  ```

- secure_chroot_dir

  ```text
  此选项应该是空目录的名称。此外，ftp用户不应该写入该目录。此目录有时用作安全chroot() 监狱，vsftpd不需要文件系统访问。
  默认值：/usr/share/empty
  ```

- ssl_enable

  ```text
  如果启用，并且vsftpd是针对OpenSSL编译的，则vsftpd将通过SSL支持安全连接。这适用于控制连接（包括登录）以及数据连接。您还需要一个支持SSL的客户端。注意！！请注意启用此选项。只有在需要时才启用它。vsftpd无法保证OpenSSL库的安全性。通过启用此选项，您声明您信任已安装的OpenSSL库的安全性。
  默认值：NO
  ```

- rsa_cert_file

  ```text
  此选项指定用于SSL加密连接的RSA证书的位置。
  默认值：/usr/share/ssl/certs/vsftpd.pem
  ```

- rsa_private_key_file

  ```text
  此选项指定用于SSL加密连接的RSA私钥的位置。如果未设置此选项，则预期私钥与证书位于同一文件中。
  默认值:(无）
  ```
