# **`openssl` 简明手册**

> `OpenSSL` 是一个安全套接字层密码库，囊括主要的密码算法、常用的密钥和证书封装管理功能及SSL协议，并提供丰富的应用程序供测试或其它目的使用。

> - 我们用它就是为了让网站实现 `https` 这个协议

## **什么是 `SSL` `TLS`**

> - SSL是Netscape开发的专门用户保护Web通讯的，目前版本为3.0。
> - 最新版本的TLS 1.0是IETF(工程任务组)制定的一种新的协议，它建立在SSL 3.0协议规范之上，是SSL 3.0的后续版本。
> - 两者差别极小，可以理解为SSL 3.1，它是写入了RFC的。

## **颁发证书**

### **第一种：自行颁发不受浏览器信任的证书**

> 主要针对 `Nginx` ，在 `Apache2` 上使用会有问题，因为这种方式不被浏览器认可，所以暂时没有去解决

> - 选择域名的 `ssl` 证书存放目录

```shell
# mkdir /alidata/ssl/
# mkdir /alidata/ssl/www_test_com
# cd /alidata/ssl/www_test_com
```

- 创建服务器私钥，并输入口令

```shell
# openssl genrsa -des3 -out www.test.com.key 1024
```

- 创建签名请求的csr证书

```shell
# openssl req -new -key www.test.com.key -out www.test.com.csr
```

- 加载ssl支持的 `Nginx` `apache2` 等 WEB 服务器，并使用私钥是除去必须的口令

```shell
# cp www.test.com.key www.test.com.key.org
# openssl rsa -in www.test.com.key.org -out www.test.com.key
```

- 如果是自己用 `openssl` 生成的域名证书，需要这一步**

```shell
# openssl x509 -req -days 365 -in www.test.com.csr -signkey www.test.com.key -out www.test.com.crt
```

### **第二种：去购买受浏览器信任的证书**

> 购买后会让我们去下载证书压缩包，里面一般含有 `Nginx` `apache2` `IIS` 等服务器匹配的证书

> - 将购买过来的证书，拷贝进服务器，一般不需要特别的操作，看官方教程搭建即可

## **`Nginx` 证书部署**

### **查看 `http_ssl_module` 扩展是否安装**

- 查看指令

  ```shell
  # 2>&1 nginx -V | tr ' ' '\n'|grep ssl
  ```

- 如果安装则会显示下面信息

  ```shell
  --with-http_ssl_module
  --with-stream_ssl_module
  --with-mail_ssl_module
  ```

### **配置 `Nginx` 站点配置文件**

```conf
server {
    listen 80;
    listen 443;
    server_name test.com www.test.com;
    root /alidata/www/www_test_com;
    index index.html index.htm index.php;

    error_page 404 = /404.html;

    location ~ {                            
        ## https 与 http 代理只能二选一
        proxy_pass http://www.test.com:8080;
        ## proxy_pass https://www.test.com:4430;
    }

    ssl on;
    ssl_certificate /alidata/ssl/www_test_com/Nginx/www.test.com.crt;
    ssl_certificate_key /alidata/ssl/www_test_com/Nginx/www.test.com.key;
    ssl_session_timeout 5m;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
    ssl_prefer_server_ciphers on;
}
```

配置文件参数                | 说明
--------------------- | --------------------
`listen 443`          | SSL访问端口号为443
`ssl on`              | 启用SSL功能
`ssl_certificate`     | 证书文件
`ssl_certificate_key` | 私钥文件
`ssl_protocols`       | 使用的协议
`ssl_ciphers`         | 配置加密套件，写法遵循openssl标准

## **`Apache 2.x` 证书部署**

> 首先要启动 `ssl` 扩展 ```shell

- 查看是否启动 ssl 扩展

  ```sehll
  # apache2ctl -t -D DUMP_MODULES | grep 'ssl'
  ```

- 启动ssl扩展

  ```conf
  # a2enmod ssl
  ```

- `Apache2` 站点配置文件

  ```conf
  <virtualhost *:4430>
    ServerAdmin linjialiang@163.com
    ServerName www.test.com
    ServerAlias test.com www.test.com
    DocumentRoot /alidata/www/yhz/www_test_com
    ErrorDocument 404 /404.html

    ## 这段一般都不需要特别申明， /etc/apache2/apache2.conf 已经配置
    <directory "/alidata/www/yhz/www_test_com">
      Options Indexes FollowSymLinks
      AllowOverride All
      Require all granted
      DirectoryIndex index.php index.html
    </directory>

    ErrorLog ${APACHE_LOG_DIR}/www_test_com-error.log
    CustomLog ${APACHE_LOG_DIR}/www_test_com-access.log combined

    RewriteEngine on
    RewriteCond %{HTTP:Host} ^test\.com$ [NC]
    RewriteRule (.*) https://www\.test\.com$1 [NC,R=301]

    SSLEngine on
    SSLCertificateFile /alidata/ssl/www_test_com/Apache2/2_www.test.com.crt
    SSLCertificateKeyFile /alidata/ssl/www_test_com/Apache2/3_www.test.com.key
    SSLCertificateChainFile /alidata/ssl/www_test_com/Apache2/1_root_bundle.crt
  </virtualhost>
  ```

配置文件参数                  | 说明
----------------------- | -------
SSLEngine on            | 启用SSL功能
SSLCertificateFile      | 证书文件
SSLCertificateKeyFile   | 私钥文件
SSLCertificateChainFile | 证书链文件

--------------------------------------------------------------------------------
