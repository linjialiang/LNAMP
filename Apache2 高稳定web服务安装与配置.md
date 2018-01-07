# **`Apache2` 高稳定web服务安装与配置**
> 这是非常稳定的web服务器，在php动态处理上，超出nginx很多，在这里我们主要用它来处理动态请求

## **`Apache2` 安装**
> 在安装php的时候，默认就将`Apache2`给安装了，在这里就不再简介安装这一步骤

```shell
# apt-get install apache2
```

## **`Apache2` 配置**
> `Apache2` 配置文件主要都在 `/etc/apache2` 目录下

### **修改 `Apache2` 默认侦听端口为8080**
> 因为在这里我们主要是用 `Nginx` 服务器

1. 打开配置文件 `/etc/apache2/ports.conf`
```shell
# cp /etc/apache2/posts.conf{,.backup}
# vim /etc/apache2/ports.conf
```

2.修改配置文件
```conf
## 找到下面行，注释掉，并在下面添加一行
## Listen 80
Listen 8080
```

### **为 `Apache2` 新的网站目录授权**
> `Apache2` 不同于 `Nginx` 没有授权的目录是无法访问的

1. 打开主配置文件 `/etc/apache2/apache2.conf`
```shell
# cp /etc/apache2/apache2.conf{,.backup}
# vim /etc/apache2/apache2.conf
```

2. 修改配置文件
```conf
## 找到这些内容：
<Directory />
    Options FollowSymLinks
    AllowOverride None
    Require all denied
</Directory>

<Directory /usr/share>                                                             
    AllowOverride None
    Require all granted
</Directory>

<Directory /var/www/>
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
</Directory>

## 修改成如下内容：

<Directory />
    Options FollowSymLinks
    AllowOverride None
    Require all denied
</Directory>

## 这个被注释掉
## <Directory /usr/share>                                                             
##     AllowOverride None
##     Require all granted
## </Directory>

<Directory /var/www/>
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
</Directory>

## 这个是新增的
<Directory /alidata/www/>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>
```

### **增加 `Apache2` 站点配置文件的存放目录**
> 和 `Nginx` 一样， `Apache2` 也可以自行配置多个站点配置文件存放目录和文件类型

1. 打开主配置文件 `/etc/apache2/apache2.conf`
```shell
# vim /etc/apache2/apache2.conf
```

2. 配置文件
```conf
## 找到以下行，并添加一行
IncludeOptional sites-enabled/*.conf
## 添加的行
IncludeOptional /alidata/sites/apache2/*.conf
```
### **修改 `Apache2` 用户及用户组**
> `Apache2` 默认用户和用户组和 `nginx` 一样，都是 `www-data:www-data`

1. 打开配置文件 `/etc/apache2/envvars`
```shell
# cp /etc/apache2/envvars{,.backup}
# vim /etc/apache2/envvars
```

2. 配置文件
```conf
## 找到这两行注释掉，并添加两行
## export APACHE_RUN_USER=www-data
## export APACHE_RUN_GROUP=www-data
## 下面这两行是添加的
export APACHE_RUN_USER=www
export APACHE_RUN_GROUP=www
```

### **修改 `Apache2` 日志路径**
> `Apache2` 日志路径有一个变量，在 `envvars` 配置文件里面

1. 打开配置文件 `/etc/apache2/envvars`
```shell
# vim /etc/apache2/envvars
```

2. 配置文件
```conf
## 找到下面这行注释掉，并添加一行
## export APACHE_LOG_DIR=/var/log/apache2$SUFFIX
export APACHE_LOG_DIR=/alidata/log/apache2$SUFFIX
```

3. 拷贝文件
> 将 `/var/log/apache2/` 下面所有的所有文件拷贝到 `/alidata/log/apche2`
```conf
# rm -rf /alidata/log/apache2
# cp -p -r /var/log/apache2 /alidata/log/apache2
# /etc/init.d/apache2 restart
```

## **网站配置文件格式**
> 在 `/alidata/sites/apache2/` 目录下新建网站配置文件 `nginx_kcstatic_top.conf`

1. 新建并打开
```shell
# touch /alidata/sites/apache2/nginx_kcstatic_top.conf
# vim /alidata/sites/apache2/nginx_kcstatic_top.conf
```

2. vhosts 文件配置模版
```conf
<VirtualHost *:8080>
    ServerAdmin linjialiang@163.com
    ServerName www.test.com
    ServerAlias test.com www.test.com
    DocumentRoot /alidata/www/www_test_com/
    ErrorLog ${APACHE_LOG_DIR}/www_test_com-error.log
    CustomLog ${APACHE_LOG_DIR}/www_test_com-access.log combined
    
    RewriteEngine on
    RewriteCond %{HTTP:Host} ^test\.com$ [NC]
    RewriteRule (.*) http://www\.test\.com$1 [NC,R=301]

    ErrorDocument 404 /404.html
</VirtualHost>

# `Apache2` 配置别名（针对与phpMyAmin）
Alias /phpmyadmin "/alidata/www/phpMyAdmin/"
<Directory "/alidata/www/phpMyAdmin/">
    AllowOverride AuthConfig
    Require local
    ErrorDocument 403 /error/XAMPP_XAMPP_FORBIDDEN.html.var
</Directory>
```

---
