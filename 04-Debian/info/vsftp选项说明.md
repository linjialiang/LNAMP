# VSFTP 选项说明

> vsftpd.conf 文件所涉及到的所有选项，我们都会在这里讲解，基于 `3.0.3` 版本

## 名称

> vsftpd.conf - vsftpd 的配置文件

## 描述

> vsftpd.conf 可用于控制 vsftpd 行为的各个方面。默认情况下，vsftpd 在 /etc/vsftpd.conf 位置查找此文件 。但是，您可以通过为 vsftpd 指定命令行选项来覆盖它。命令行选项是 vsftpd 的配置文件的路径名。此行为很有用，因为您可能希望使用高级 inetd（如 xinetd） 以每个虚拟主机为基础启动 vsftpd 和不同的配置文件。

## 格式

> vsftpd.conf 的格式非常简单。每一行都是注释或指令。注释行以＃开头并被忽略。指令行的格式为：`选项=选项值`

```text
注意：在指令中 `=` 的左右两侧放置任何空格是错误的。
提示：每个选项都有一个默认值，可以在配置文件中进行修改。
```

## 布尔选项

> 布尔选项的值可以设置为 `YES` 或 `NO`

- allow_anon_ssl

  ```text
  仅在ssl_enable 处于活动状态时适用 。如果设置为YES，则允许匿名用户使用安全SSL连接。
  默认值：NO
  ```

- anon_mkdir_write_enable

  ```text
  如果设置为YES，则允许匿名用户在特定条件下创建新目录。为此， 必须激活选项 write_enable，并且匿名ftp用户必须具有父目录的写权限。
  默认值：NO
  ```

- anon_other_write_enable

  ```text
  如果设置为YES，则允许匿名用户执行除上载和创建目录之外的写入操作，例如删除和重命名。通常不建议这样做，但包括完整性。
  默认值：NO
  ```

- anon_upload_enable

  ```text
  如果设置为YES，则允许匿名用户在特定条件下上载文件。为此， 必须激活选项 write_enable，并且匿名ftp用户必须具有所需上载位置的写入权限。虚拟用户上传也需要此设置; 默认情况下，虚拟用户使用匿名（即最大限制）权限处理。
  默认值：NO
  ```

- anon_world_readable_only

  ```text
  启用后，将只允许匿名用户下载世界可读的文件。这是认识到ftp用户可能拥有文件，尤其是在上传的情况下。
  默认值：YES
  ```

- anonymous_enable

  ```text
  控制是否允许匿名登录。如果启用，则用户名 ftp 和 anonymous 都将被识别为匿名登录。
  默认值：YES
  ```

- ascii_download_enable

  ```text
  启用后，ASCII模式数据传输将在下载时受到尊重。
  默认值：NO
  ```

- ascii_upload_enable

  ```text
  启用后，上传时将遵循ASCII模式数据传输。
  默认值：NO
  ```

- async_abor_enable

  ```text
  启用后，将启用称为“异步ABOR”的特殊FTP命令。只有不明智的FTP客户端才会使用此功能。此外，此功能难以处理，因此默认情况下禁用。遗憾的是，除非此功能可用，否则某些FTP客户端将在取消传输时挂起，因此您可能希望启用它。
  默认值：NO
  ```

- background

  ```text
  启用后，vsftpd以“监听”模式启动，vsftpd将为侦听器进程提供背景。即控制将立即返回到启动vsftpd的shell。
  默认值：NO
  ```

- check_shell

  ```text
  注意！此选项仅对vsftpd的非PAM构建有效。如果禁用，vsftpd将不会检查/etc/shells是否有用于本地登录的用户shell。
  默认值：YES
  ```

- chmod_enable

  ```text
  启用后，允许使用SITE CHMOD命令。注意！这仅适用于本地用户。匿名用户永远不会使用SITE CHMOD。
  默认值：YES
  ```

- chown_uploads

  ```text
  如果启用，则所有匿名上载的文件的所有权都将更改为设置chown_username中指定的用户 。从管理方面，也许是安全方面来看，这很有用。
  默认值：NO
  ```

- chroot_list_enable

  ```text
  如果激活，您可以在登录时提供放置在其主目录中的chroot()监狱中的本地用户列表。如果chroot_local_user设置为YES，则含义略有不同。在这种情况下，列表将成为不被放置在chroot()监狱中的用户列表。默认情况下，包含此列表的文件是/etc/vsftpd.chroot_list，但您可以使用chroot_list_file 设置覆盖它 。
  默认值：NO
  ```

- chroot_local_user

  ```text
  如果设置为YES，则登录后本地用户（默认情况下）将放置在其主目录中的chroot()监狱中。 警告： 此选项具有安全隐患，尤其是在用户具有上载权限或shell访问权限的情况下。只有在您知道自己在做什么时才启用。请注意，这些安全隐患不是特定于vsftpd的。它们适用于所有提供将本地用户放在chroot()监狱中的FTP守护进程。
  默认值：NO
  ```

- connect_from_port_20

  ```text
  这可以控制PORT样式数据连接是否在服务器计算机上使用端口20（ftp-data）。出于安全原因，一些客户可能会坚持认为是这种情况。相反，禁用此选项可使vsftpd以较低的权限运行。
  默认值：NO（但是示例配置文件启用它）
  ```

- debug_ssl

  ```text
  如果为true，则将OpenSSL连接诊断转储到vsftpd日志文件。（在v2.0.6中添加）。
  默认值：NO
  ```

- delete_failed_uploads

  ```text
  如果为true，则删除任何失败的上载文件。（在v2.0.7中添加）。
  默认值：NO
  ```

- deny_email_enable

  ```text
  如果激活，您可以提供匿名密码电子邮件响应列表，这会导致登录被拒绝。默认情况下，包含此列表中的文件是/etc/vsftpd.banned_emails，但你可以与覆盖这个 banned_email_file 设置。
  默认值：NO
  ```

- dirlist_enable

  ```text
  如果设置为NO，则所有目录列表命令都将拒绝权限。
  默认值：YES
  ```

- dirmessage_enable

  ```text
  如果启用，FTP服务器的用户首次进入新目录时可以显示消息。默认情况下，会扫描目录以查找文件.message，但可以使用配置设置message_file覆盖该目录 。
  默认值：NO（但是示例配置文件启用它）
  ```

- download_enable

  ```text
  如果设置为NO，则所有下载请求都将拒绝权限。
  默认值：YES
  ```

- dual_log_enable

  ```text
  如果启用，则会并行生成两个日志文件，默认情况下为/var/log/xferlog 和 /var/log/vsftpd.log。前者是一个wu-ftpd样式的传输日志，可以通过标准工具解析。后者是vsftpd自己的样式日志。
  默认值：NO
  ```

- force_dot_files

  ```text
  如果激活，则以。开头的文件和目录。即使客户端未使用“a”标志，也将显示在目录列表中。此覆盖不包括“。” 和“..”条目。
  默认值：NO
  ```

- force_anon_data_ssl

  ```text
  仅 在激活ssl_enable时适用 。如果激活，则强制所有匿名登录使用安全SSL连接，以便在数据连接上发送和接收数据。
  默认值：NO
  ```

- force_anon_logins_ssl

  ```text
  仅 在激活ssl_enable时适用 。如果激活，则强制所有匿名登录使用安全SSL连接以发送密码。
  默认值：NO
  ```

- force_local_data_ssl

  ```text
  仅 在激活ssl_enable时适用 。如果激活，则强制所有非匿名登录使用安全SSL连接，以便在数据连接上发送和接收数据。
  默认值：YES
  ```

- force_local_logins_ssl

  ```text
  仅 在激活ssl_enable时适用 。如果激活，则强制所有非匿名登录使用安全SSL连接以发送密码。
  默认值：YES
  ```

- guest_enable

  ```text
  如果启用，则所有非匿名登录都被归类为“访客”登录。guest 虚拟机登录将重新映射到guest_username 设置中指定的用户 。
  默认值：NO
  ```

- hide_ids

  ```text
  如果启用，目录列表中的所有用户和组信息将显示为“ftp”。
  默认值：NO
  ```

- implicit_ssl

  ```text
  如果启用，则SSL握手是所有连接（FTPS协议）上的第一件事。要支持显式SSL和/或纯文本，还应运行单独的vsftpd侦听器进程。
  默认值：NO
  ```

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

- local_enable

  ```text
  控制是否允许本地登录。如果启用，则可以使用/etc/passwd中的普通用户帐户（或PAM配置引用的任何位置）登录。必须启用此功能才能使任何非匿名登录工作，包括虚拟用户。
  默认值：NO
  ```

- lock_upload_files

  ```text
  启用后，所有上载都会继续对上载文件进行写锁定。所有下载都继续对下载文件进行共享读锁定。警告！在启用此功能之前，请注意恶意阅读器可能会使想要添加文件的作者感到饥饿。
  默认值：YES
  ```

- log_ftp_protocol

  ```text
  启用后，将记录所有FTP请求和响应，前提是未启用xferlog_std_format选项。对调试很有用。
  默认值：NO
  ```

- ls_recurse_enable

  ```text
  启用后，此设置将允许使用“ls -R”。这是一个小的安全风险，因为大型站点顶层的ls -R可能会消耗大量资源。
  默认值：NO
  ```

- mdtm_write

  ```text
  启用后，此设置将允许MDTM设置文件修改时间（根据通常的访问检查）。
  默认值：YES
  ```

- no_anon_password

  ```text
  启用后，这会阻止vsftpd请求匿名密码 - 匿名用户将直接登录。
  默认值：NO
  ```

- no_log_lock

  ```text
  启用后，这会阻止vsftpd在写入日志文件时进行文件锁定。通常不应启用此选项。它的存在是为了解决操作系统错误，例如Solaris/Veritas文件系统组合，有时会出现试图锁定日志文件的挂起。
  默认值：NO
  ```

- one_process_model

  ```text
  如果您有Linux 2.4内核，则可以使用不同的安全模型，每个连接只使用一个进程。它是一种不太纯粹的安全模型，但会提高您的性能。除非您知道自己在做什么，并且您的网站支持大量同时连接的用户，否则您真的不想启用它。
  默认值：NO
  ```

- passwd_chroot_enable

  ```text
  如果启用，则与 chroot_local_user一起 ，然后可以基于每个用户指定chroot()监狱位置。每个用户的监狱都是从/etc/passwd中的主目录字符串派生的。主目录字符串中出现/./表示监狱位于路径中的特定位置。
  默认值：NO
  ```

- pasv_addr_resolve

  ```text
  如果要在pasv_address 选项中使用主机名（而不是IP地址），请设置为YES 。
  默认值：NO
  ```

- pasv_enable

  ```text
  如果要禁用PASV获取数据连接的方法，请设置为NO。
  默认值：YES
  ```

- pasv_promiscuous

  ```text
  如果要禁用PASV安全检查，请设置为YES，以确保数据连接源自与控制连接相同的IP地址。只有在你知道自己在做什么的情况下才能启用 对此的唯一合法用途是采用某种形式的安全隧道方案，或者可能是为了促进FXP支持。
  默认值：NO
  ```

- port_enable

  ```text
  如果要禁止使用PORT方法获取数据连接，请设置为NO。
  默认值：YES
  ```

- port_promiscuous

  ```text
  如果要禁用PORT安全检查，则设置为YES，以确保传出数据连接只能连接到客户端。只有在你知道自己在做什么的情况下才能启用
  默认值：NO
  ```

- require_cert

  ```text
  如果设置为yes，则需要所有SSL客户端连接来提供客户端证书。应用于此证书的验证程度由validate_cert控制 （在v2.0.6中添加）。
  默认值：NO
  ```

- require_ssl_reuse

  ```text
  如果设置为yes，则需要所有SSL数据连接以展示SSL会话重用（这证明它们知道与控制通道相同的主密钥）。虽然这是一个安全的默认设置，但它可能会破坏许多FTP客户端，因此您可能希望禁用它。有关后果的讨论，请参阅 http://scarybeastsecurity.blogspot.com/2009/02/vsftpd-210-released.html （在v2.1.0中添加）。
  默认值：YES
  ```

- run_as_launching_user

  ```text
  如果您希望vsftpd作为启动vsftpd的用户运行，则设置为YES。在根访问不可用的情况下，这很有用。大规模警告！除非您完全知道自己在做什么，否则不要启用此选项，因为天真地使用此选项会产生大量安全问题。具体来说，当设置此选项时，vsftpd不会/不能使用chroot技术来限制文件访问（即使由root启动）。一个糟糕的替代品可能是使用 deny_file 设置如{/*,*..*}，但这种可靠性无法与chroot相比，不应该依赖。如果使用此选项，则适用对其他选项的许多限制。例如，需要权限的选项（例如非匿名登录，上载所有权更改，从端口20连接以及小于1024的侦听端口）预计不起作用。其他选项可能会受到影响。
  默认值：NO
  ```

- secure_email_list_enable

  ```text
  如果您只想接受匿名登录的指定电子邮件密码列表，请设置为YES。这非常有用，可以在不需要虚拟用户的情况下限制对低安全性内容的访问。启用后，将禁止匿名登录，除非在email_password_file 设置指定的文件中列出了提供的密码 。文件格式是每行一个密码，没有额外的空格。默认文件名为/etc/vsftpd.email_passwords。
  默认值：NO
  ```

- session_support

  ```text
  这可以控制vsftpd是否尝试维护登录会话。如果vsftpd正在维护会话，它将尝试更新utmp和wtmp。如果使用PAM进行身份验证，它也会打开pam_session，并且只有在注销时关闭它。如果您不需要会话日志记录，您可能希望禁用此功能，并希望为vsftpd提供更多机会以更少的进程和/或更少的权限运行。注 - utmp和wtmp支持仅在启用PAM的构建中提供。
  默认值：NO
  ```

- setproctitle_enable

  ```text
  如果启用，vsftpd将尝试在系统进程列表中显示会话状态信息。换句话说，报告的进程名称将更改以反映vsftpd会话正在执行的操作（空闲，下载等）。出于安全考虑，您可能希望将其关闭。
  默认值：NO
  ```

- ssl_enable

  ```text
  如果启用，并且vsftpd是针对OpenSSL编译的，则vsftpd将通过SSL支持安全连接。这适用于控制连接（包括登录）以及数据连接。您还需要一个支持SSL的客户端。注意！！请注意启用此选项。只有在需要时才启用它。vsftpd无法保证OpenSSL库的安全性。通过启用此选项，您声明您信任已安装的OpenSSL库的安全性。
  默认值：NO
  ```

- ssl_request_cert

  ```text
  如果启用，vsftpd会要求（但不一定需要;见 require_cert）一个证书上的传入 SSL 连接。通常这 不应该造成任何麻烦，但IBM zOS似乎有问题。（v2.0.7中的新功能）。
  默认值：YES
  ```

- ssl_sslv2

  ```text
  仅 在激活ssl_enable时适用 。如果启用，此选项将允许SSL v2协议连接。TLS v1连接是首选。
  默认值：NO
  ```

- ssl_sslv3

  ```text
  仅 在激活ssl_enable时适用 。如果启用，此选项将允许SSL v3协议连接。TLS v1连接是首选。
  默认值：NO
  ```

- ssl_tlsv1

  ```text
  仅 在激活ssl_enable时适用 。如果启用，此选项将允许TLS v1协议连接。TLS v1连接是首选。
  默认值：YES
  ```

- strict_ssl_read_eof

  ```text
  如果启用，则需要通过SSL终止SSL数据上载，而不是套接字上的EOF。需要此选项以确保攻击者未使用伪造的TCP FIN过早终止上载。不幸的是，默认情况下它没有启用，因为很少有客户端能够正确使用它。（v2.0.7中的新功能）。
  默认值：NO
  ```

- strict_ssl_write_shutdown

  ```text
  如果启用，则需要通过SSL终止SSL数据下载，而不是套接字上的EOF。默认情况下这是关闭的，因为我无法找到执行此操作的单个FTP客户端。这是次要的。它影响的是我们判断客户是否确认完全收到该文件的能力。即使没有此选项，客户端也能够检查下载的完整性。（v2.0.7中的新功能）。
  默认值：NO
  ```

- syslog_enable

  ```text
  如果启用，那么将转到/var/log/vsftpd.log的任何日志输出都将转到系统日志。记录在FTPD工具下完成。
  默认值：NO
  ```

- tcp_wrappers 的

  ```text
  如果启用，并且vsftpd是使用tcp_wrappers支持编译的，则传入连接将通过tcp_wrappers访问控制提供。此外，还有一种基于每个IP的配置机制。如果tcp_wrappers设置VSFTPD_LOAD_CONF环境变量，则vsftpd会话将尝试加载此变量中指定的vsftpd配置文件。
  默认值：NO
  ```

- text_userdb_names

  ```text
  默认情况下，数字ID显示在目录列表的用户和组字段中。您可以通过启用此参数来获取文本名称。出于性能原因，它默认是关闭的。
  默认值：NO
  ```

- tilde_user_enable

  ```text
  如果启用，vsftpd将尝试解析路径名，例如~chris/pics，即代字号后跟用户名。请注意，vsftpd将始终解析路径名~和~/something（在这种情况下，~解析为初始登录目录）。请注意，只有 在 _current_ chroot() 监狱中找到文件/etc/passwd时，~用户路径才会解析 。
  默认值：NO
  ```

- use_localtime

  ```text
  如果启用，vsftpd将显示当前时区中包含时间的目录列表。默认为显示GMT。MDTM FTP命令返回的时间也受此选项的影响。
  默认值：NO
  ```

- use_sendfile

  ```text
  用于测试在平台上使用sendfile（）系统调用的相对好处的内部设置。
  默认值：YES
  ```

- userlist_deny

  ```text
  如果 激活userlist_enable，则检查此选项 。如果将此设置设置为NO，则将拒绝用户登录，除非它们明确列在userlist_file指定的文件中 。拒绝登录时，将在要求用户输入密码之前发出拒绝。
  默认值：YES
  ```

- userlist_enable

  ```text
  如果启用，vsftpd将从userlist_file给出的文件名加载用户名列表 。如果用户尝试使用此文件中的名称登录，则在要求输入密码之前，他们将被拒绝。这可能有助于防止传输明文密码。另请参见 userlist_deny。
  默认值：NO
  ```

- validate_cert

  ```text
  如果设置为yes，则收到的所有SSL客户端证书都必须验证OK。自签名证书不构成OK验证。（v2.0.6中的新功能）。
  默认值：NO
  ```

- virtual_use_local_privs

  ```text
  如果启用，虚拟用户将使用与本地用户相同的权限。默认情况下，虚拟用户将使用与匿名用户相同的权限，这往往更具限制性（特别是在写访问方面）。
  默认值：NO
  ```

- write_enable

  ```text
  这可以控制是否允许任何更改文件系统的ftp命令。这些命令是：stor，dele，rnfr，rnto，mkd，rmd，appe和site。
  默认值：NO
  ```

- xferlog_enable

  ```text
  如果启用，将维护一个日志文件，详细说明上载和下载。默认情况下，此文件将放在/var/log/vsftpd.log中，但可以使用配置设置vsftpd_log_file覆盖此位置 。
  默认值：NO（但是示例配置文件启用它）
  ```

- xferlog_std_format

  ```text
  如果启用，传输日志文件将以标准xferlog格式写入，如wu-ftpd所使用。这很有用，因为您可以重用现有的传输统计信息生成器 但是，默认格式更具可读性。此样式的日志文件的缺省位置是/var/log/xferlog，但您可以使用xferlog_file设置进行 更改。
  默认值：NO
  ```

## 数字选项

> 以下是数字选项列表。必须将数字选项设置为非负整数。支持八进制数，以方便umask选项。要指定八进制数，请使用0作为数字的第一个数字。

- accept_timeout

  ```text
  远程客户端与PASV样式数据连接建立连接的超时（以秒为单位）。
  默认值：60
  ```

- anon_max_rate

  ```text
  匿名客户端允许的最大数据传输速率（以字节/秒为单位）。
  默认值：0（无限制）
  ```

- anon_umask

  ```text
  为匿名用户设置用于文件创建的umask的值。注意！如果要指定八进制值，请记住“0”前缀，否则该值将被视为基数为10的整数！
  默认值：077
  ```

- chown_upload_mode

  ```text
  要强制进行chown（）ed匿名上传的文件模式。（在v2.0.6中添加）。
  默认值：0600
  ```

- connect_timeout

  ```text
  远程客户端响应PORT样式数据连接的超时（以秒为单位）。
  默认值：60
  ```

- data_connection_timeout

  ```text
  超时（以秒为单位），大致是允许数据传输停止而没有进度的最长时间。如果超时触发，则启动远程客户端。
  默认值：300
  ```

- delay_failed_login

  ```text
  报告登录失败之前暂停的秒数。
  默认值：1
  ```

- delay_successful_login

  ```text
  允许成功登录之前暂停的秒数。
  默认值：0
  ```

- file_open_mode

  ```text
  用于创建上载文件的权限。Umasks应用于此值之上。如果您希望上传的文件可执行，您可能希望更改为0777。
  默认值：0666
  ```

- ftp_data_port

  ```text
  PORT样式连接源自的端口（只要命名不佳的 connect_from_port_20 已启用）。
  默认值：20
  ```

- idle_session_timeout

  ```text
  超时（以秒为单位），即远程客户端在FTP命令之间可能花费的最长时间。如果超时触发，则启动远程客户端。
  默认值：300
  ```

- listen_port

  ```text
  如果vsftpd处于独立模式，则它将侦听传入FTP连接的端口。
  默认值：21
  ```

- local_max_rate

  ```text
  本地身份验证用户允许的最大数据传输速率（以字节/秒为单位）。
  默认值：0（无限制）
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

- max_login_fails

  ```text
  在此多次登录失败后，会话被终止。
  默认值：3
  ```

- max_per_ip

  ```text
  如果vsftpd处于独立模式，则这是可以从同一源Internet地址连接的最大客户端数。如果客户端超过此限制，则会收到错误消息。
  默认值：0（无限制）
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

- trans_chunk_size

  ```text
  您可能不想更改此设置，但请尝试将其设置为8192，以获得更加平滑的带宽限制器。
  默认值：0（让vsftpd选择合理的设置）
  ```

## 字符串选项

> 以下是字符串选项列表

- anon_root

```text
此选项表示vsftpd在匿名登录后尝试更改的目录。失败被默默地忽略了。
默认值:(无）
```

- banned_email_file

  ```text
  此选项是包含不允许的匿名电子邮件密码列表的文件的名称。如果 启用了选项deny_email_enable，则会查询此文件 。
  默认值：/etc/vsftpd.banned_emails
  ```

- banner_file

  ```text
  此选项是包含要在有人连接到服务器时显示的文本的文件的名称。如果设置，它将覆盖ftpd_banner 选项提供的标题字符串 。
  默认值:(无）
  ```

- ca_certs_file

  ```text
  此选项是用于加载证书颁发机构证书的文件的名称，用于验证客户端证书。遗憾的是，由于vsftpd使用受限制的文件系统空间（chroot），因此未使用默认的SSL CA证书路径。（在v2.0.6中添加）。
  默认值:(无）
  ```

- chown_username

  ```text
  这是获得匿名上传文件所有权的用户的名称。仅当设置了另一个选项chown_uploads时，此选项才有意义 。
  默认值：root
  ```

- chroot_list_file

  ```text
  该选项是包含本地用户列表的文件的名称，该列表将放置在其主目录中的chroot()监狱中。仅当 启用了选项chroot_list_enable时，此选项才有意义 。如果 启用了chroot_local_user选项 ，则列表文件将成为不放在chroot()监狱中的用户列表。
  默认值：/etc/vsftpd.chroot_list
  ```

- cmds_allowed

  ```text
  此选项指定允许的FTP命令的逗号分隔列表（登录后.USER，PASS和QUIT以及其他始终允许在登录前使用）。其他命令被拒绝。这是一种真正锁定FTP服务器的强大方法。示例：cmds_allowed = PASV，RETR，QUIT
  默认值:(无）
  ```

- cmds_denied

  ```text
  此选项指定以逗号分隔的拒绝FTP命令列表（登录后。始终允许登录前使用USER，PASS，QUIT等）。如果此命令和cmds_allowed上都出现命令， 则拒绝优先。（在v2.1.0中添加）。
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

- dsa_cert_file

  ```text
  此选项指定用于SSL加密连接的DSA证书的位置。
  默认值:(无 - RSA证书就足够了）
  ```

- dsa_private_key_file

  ```text
  此选项指定用于SSL加密连接的DSA私钥的位置。如果未设置此选项，则预期私钥与证书位于同一文件中。
  默认值:(无）
  ```

- email_password_file

  ```text
  此选项可用于提供secure_email_list_enable 设置使用的备用文件 。
  默认值：/etc/vsftpd.email_passwords
  ```

- ftp_username

  ```text
  这是我们用于处理匿名FTP的用户的名称。该用户的主目录是匿名FTP区域的根目录。
  默认值：ftp
  ```

- ftpd_banner

  ```text
  此字符串选项允许您在首次进入连接时覆盖vsftpd显示的问候语横幅。
  默认值:(无 - 显示默认的vsftpd横幅）
  ```

- guest_username

  ```text
  有关guest虚拟机 登录的说明，请参阅boolean设置 guest_enable。此设置是访客用户映射到的真实用户名。
  默认值：ftp
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

- listen_address

  ```text
  如果vsftpd处于独立模式，则此设置可能会覆盖（所有本地接口的）默认侦听地址。提供数字IP地址。
  默认值:(无）
  ```

- listen_address6

  ```text
  与listen_address类似，但指定IPv6侦听器的默认侦听地址（如果设置了listen_ipv6，则使用该地址）。格式是标准IPv6地址格式。
  默认值:(无）
  ```

- local_root

  ```text
  此选项表示vsftpd在本地（即非匿名）登录后尝试更改的目录。失败被默默地忽略了。
  默认值:(无）
  ```

- message_file

  ```text
  此选项是输入新目录时我们查找的文件的名称。内容显示给远程用户。仅当 启用了选项dirmessage_enable时，此选项才有意义 。
  默认值：.message
  ```

- nopriv_user

  ```text
  这是vsftpd在完全没有特权的情况下使用的用户名。请注意，这应该是专用用户，而不是任何人。在大多数机器上，用户没有倾向于使用很多重要的东西。
  默认值：nobody
  ```

- pam_service_name

  ```text
  此字符串是vsftpd将使用的PAM服务的名称。
  默认值：ftp
  ```

- pasv_address

  ```text
  使用此选项可覆盖vsftpd将响应PASV命令而通告的IP地址。提供数字IP地址，除非 启用了pasv_addr_resolve，在这种情况下，您可以提供在启动时为您解析的DNS主机名。
  默认值:(没有默认值 - 地址来自传入的连接套接字）
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

- secure_chroot_dir

  ```text
  此选项应该是空目录的名称。此外，ftp用户不应该写入该目录。此目录有时用作安全chroot() 监狱，vsftpd不需要文件系统访问。
  默认值：/usr/share/empty
  ```

- 的ssl_ciphers

  ```text
  此选项可用于选择vsftpd允许加密SSL连接的SSL密码。有关 更多详细信息，请参见 密码手册页。请注意，限制密码可能是一种有用的安全预防措施，因为它可以防止恶意远程方强制使用已发现问题的密码。
  默认值：DES-CBC3-SHA
  ```

- user_config_dir

  ```text
  这个功能强大的选项允许基于每个用户覆盖手册页中指定的任何配置选项。用法很简单，最好用一个例子来说明。如果将 user_config_dir 设置为/etc/vsftpd_user_conf 然后以用户“chris”身份登录，则vsftpd将 在会话期间应用文件/etc/vsftpd_user_conf/chris中的设置。此文件的格式详见本手册页！请注意，并非所有设置都是基于每个用户有效。例如，许多设置仅在用户会话启动之前。不会影响每个用户的任何行为的设置示例包括listen_address，banner_file，max_per_ip，max_clients，xferlog_file等。
  默认值:(无）
  ```

- user_sub_token

  ```text
  此选项与虚拟用户结合使用非常有用。它用于根据模板为每个虚拟用户自动生成主目录。例如，如果通过guest_username指定的真实用户的主目录 是/home/virtual/$ USER，并且 user_sub_token 设置为 $ USER，那么当虚拟用户fred登录时，他将结束（通常是chroot()'ed ）在目录/home/virtual/fred中。如果local_root 包含 user_sub_token，则此选项也会 生效。
  默认值:(无）
  ```

- userlist_file

  ```text
  此选项是userlist_enable 选项处于活动状态时加载的文件的名称 。
  默认值：/etc/vsftpd.user_list
  ```

- vsftpd_log_file

  ```text
  此选项是我们编写vsftpd样式日志文件的文件的名称。仅当 设置了选项xferlog_enable并且未设置xferlog_std_format时， 才会写入此日志 。或者，如果已设置选项dual_log_enable，则会写入 。另一个复杂因素 - 如果您设置了 syslog_enable，则不会写入此文件，而是将输出发送到系统日志。
  默认值：/var/log/vsftpd.log
  ```

- xferlog_file

  ```text
  此选项是我们编写wu-ftpd样式传输日志的文件的名称。仅当 设置了 xferlog_enable选项以及xferlog_std_format时才会写入传输日志 。或者，如果已设置选项dual_log_enable，则会写入 。
  默认值：/var/log/xferlog
  ```
