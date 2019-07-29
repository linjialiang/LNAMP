# mail 块相关选项

1.  `--with-mail`

    > 启用构建 ngx_mail_core_module 模块,该模块会启用 POP3/IMAP4/SMTP 邮件代理服务。

    - 使用 `--with-mail=dynamic` 可以动态启用 POP3/IMAP4/SMTP 邮件代理服务

2.  `--with-mail_ssl_module`

    > 启用构建 ngx_mail_ssl_module 模块，默认情况下不构建此模块，需要 OpenSSL 库来构建和运行此模块。

        - 该模块将 SSL/TLS 协议支持添加到邮件代理服务器。

3.  `--without-mail_pop3_module`

    > 禁用邮件代理服务器中的 POP3 协议。

4.  `--without-mail_imap_module`

    > 禁用邮件代理服务器中的 IMAP4 协议。

5.  `--without-mail_smtp_module`
    > 禁用邮件代理服务器中的 SMTP 协议。
