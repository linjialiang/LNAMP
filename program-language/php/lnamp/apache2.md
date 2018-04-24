# **`Apache2` 高稳定web服务安装与配置**

> 这是非常稳定的web服务器，在php动态处理上，超出nginx很多，在这里我们主要用它来处理动态请求

## **`Apache2` 安装**

> 在安装php的时候，默认就将`Apache2`给安装了，在这里就不再简介安装这一步骤

```shell
# apt-get install apache2
```

## **`Apache2` 配置**

> `Apache2` 配置文件主要都在 `/etc/apache2` 目录下

### **修改 `Apache2` 默认侦听端口为8080 ssl侦听端口为4430**

> 因为在这里我们主要是用 `Nginx` 服务器

1. 打开配置文件 `/etc/apache2/ports.conf`

  ```shell
  # cp /etc/apache2/posts.conf{,.backup}
  # vim /etc/apache2/ports.conf
  ```

2. 修改配置文件

  ```conf
  ## 找到下面行，注释掉，并在下面添加一行
  ## Listen 80
  ## Listen 443
  Listen 8080
  Listen 4430
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

  ## Options 需要去掉 Indexes 权限
  <Directory /var/www/>
  Options FollowSymLinks
  AllowOverride None
  Require all granted
  </Directory>

  ## 这个是新增的
  <Directory /alidata/www/>
  Options FollowSymLinks
  AllowOverride All     ## 这个需要开启 `rewrite` 模块
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
     DocumentRoot /alidata/www/yhz/www_test_com
     ErrorDocument 404 /404.html

     ## 这段一般都不需要特别申明， /etc/apache2/apache2.conf 已经配置
     <Directory "/alidata/www/yhz/www_test_com">
         Options Indexes FollowSymLinks
         AllowOverride All
         Require all granted
         DirectoryIndex index.php index.html
     </Directory>

     ErrorLog ${APACHE_LOG_DIR}/www_test_com-error.log
     CustomLog ${APACHE_LOG_DIR}/www_test_com-access.log combined

     RewriteEngine on
     RewriteCond %{HTTP_HOST} ^test.com$ [NC]
     RewriteRule ^(.*)$ http://www.%{HTTP_HOST}$1 [R=301,L]
  </VirtualHost>
  ```

3. `Apache2` 配置别名（针对与phpMyAmin）

  ```conf
  Alias /phpmyadmin /usr/share/phpmyadmin

  <Directory /usr/share/phpmyadmin>
     Options FollowSymLinks
     DirectoryIndex index.php
     <RequireAll>
         Require ip 60.181.0.0/16
     </RequireAll>
  </Directory>

  <Directory /usr/share/phpmyadmin/libraries>
     Require all denied
  </Directory>
  <Directory /usr/share/phpmyadmin/setup/lib>
     Require all denied
  </Directory>
  ```

## **`/etc/apache2` 目录下说明**

> `*-enabled` 里面的文件都是 `x-available` 的一个软链接

> - `Apache2` 扩展模块 >> `mods-available` + `mods-enabled`
> - `Apache2` 站点配置文件 >> `sites-available` + `sites-enabled`
> - `Apache2` 子配置文件 >> `conf-available` + `conf-enabled`

### **`扩展模块`**

> 启动 `a2enmod 模块名（或者简写）` 启动 `a2dismod 模块名（或者简写）`

```shell
# a2enmod rewrite
# a2dismod rewrite.load

## 开启模块，只需要在 `mods-enabled` 目录下创建快捷键, 并重启 `Apache2`
# ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
## 禁用模块,只需要在 `mods-enabled` 目录下删除指定快捷键，并重启 `Apache2`
# rm -f /etc/apache2/mods-enabled/rewrite.load

# /etc/init.d/apache2 restart
```

### **站点配置文件**

> 启动 `a2ensite 配置文件名（或者简写）` 启动 `a2dissite 配置文件名（或者简写）`

```shell
# a2dissite 000-default
# a2dissite 000-default.conf

## 开启一个站点，只需要在 `sites-enabled` 目录下创建快捷键, 并重启 `Apache2`
# ln -s /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-enabled/000-default.conf
## 禁用一个站点,只需要在 `sites-enabled` 目录下删除指定快捷键，并重启 `Apache2`
# rm -f /etc/apache2/sites-enabled/000-default.conf

# systemctl restart apache2
```

## **`Apache2` 下 `AllowOverride` 属性**

```conf
## 支持所有指令，如：支持.htaccess文件的伪静态，需要开启apache2的rewrite模块
# AllowOverride All
## 不支持任何指令
# AllowOverride None
## 允许使用所有的权限指令, phpmyadmin目录一般是这个权限
# AllowOverride AutoConfig
## 允许使用文件控制类型的指令
# AllowOverride FileInfo
## 允许使用目录控制类型的指令
# AllowOverride Indexes
## 允许使用权限控制指令
# AllowOverride Limit
## 允许使用控制目录特征的指令
# AllowOverride Indexes
```

## **`apache2` 下 `option` 属性**

```conf
## 准许以下除MultiViews以外所有功能
# All
## 允许多重内容被浏览，如果你的目录下有一个叫做foo.txt的文件，那么你可以通过/foo来访问到它，这对于一个多语言内容的站点比较有用
# MultiViews
## 若该目录下无index文件，则准许显示该目录下的文件以供选择
# Indexes
## 准许SSI，但不可使用#exec和#include功能
# IncludesNOEXEC
## 准许SSI
# Includes
## 在该目录中，服务器将跟踪符号链接。注意，即使服务器跟踪符号链接，它也不会改变用来匹配不同区域的路径名，如果在<Local>;标记内设置，该选项会被忽略
# FollowSymLinks
## 在该目录中仅仅跟踪本站点内的链接
# SymLinksIfOwnerMatch
## 在该目录下准许使用CGI
# ExecCGI
```

## **`Apache2.4` 访问日志**

### **`Apache2.4 访问日志` 按天分割日志文件，并不记录图片、css、js**

```conf
<VirtualHost *:80>
    DocumentRoot /www/www_test_com/
    ServerName www.test.com
    ServerAlias test.com www.test.com
    ErrorLog "/logs/apache2/www_test_com-error.log"  common
    # CustomLog "/logs/apache2/www_test_com-access.log"  common
    <FilesMatch ".(ico|gif|jpg|png|swf|css|js)">
        SetEnv IMAG 1
    </FilesMatch>
    CustomLog "|/usr/bin/rotatelogs /logs/apache2/www_test_com/www_test_com-%Y-%m-%d-access.log 86400" combined env=!IMAG
</VirtualHost>
```

1. `rotatelogs` 是 `Apache2.4` 中自带的管道日志程序

  > 如果你不知道 `rotatelogs` 所在位置，可以在终端通过以下方式查找所在位置

  ```shell
  # locate rotatelogs
  ```

2. `FilesMatch` 里面是要过滤的文件格式

3. 86400 这个是1天是秒数，代表1天后自动生成新的日志文件

4. 组合日志 `combined` ，通用日志 `common`

  - 许多时候，根据与请求特征相关的环境变量来有选择地记录某些客户端请求会带来便利；
  - 首先，需要使用 `SetEnvIf` 指令来设置特定的环境变量以标识符合某种特定条件的请求；
  - 然后用 `CustomLog` 指令的 `env=` 子句，根据这些环境变量来决定记录或排除特定的请求。

5. 分割日志文件 `CustomLog（访问日志）` 支持 `rotatelogs` 来分割日志文件； `ErrorLog（错误）` 无法使用 `rotatelogs` 来分割日志文件；

### **`apache2.4 访问日志` 按天分割日志文件**

```conf
<VirtualHost *:8080>
    DocumentRoot /www/www_test_com/
    ServerName www.test.com
    ServerAlias test.com www.test.com
    ErrorLog "/logs/apache2/www_test_com-error.log"  common
    # CustomLog "/logs/apache2/www_test_com-access.log"  common
    CustomLog "|/usr/bin/rotatelogs /logs/apache2/www_test_com/www_test_com-%Y-%m-%d-access.log 86400" common
</VirtualHost>
```

### **`apache2.4 访问日志` 不记录图片、css、js**

```conf
<VirtualHost *:8080>
    DocumentRoot /www/www_test_com/
    ServerName www.test.com
    ServerAlias test.com www.test.com
    ErrorLog "/logs/apache2/www_test_com-error.log"  common
    # CustomLog "/logs/apache2/www_test_com-access.log"  common
    <FilesMatch ".(ico|gif|jpg|png|swf|css|js)">
        SetEnv IMAG 1
    </FilesMatch>
    CustomLog "/logs/apache2/www_test_com/www_test_com-access.log" combined env=!IMAG
</VirtualHost>
```

## **`apache2.4` 跨域访问资源（如字体）**

### **首先 `apache2.4` 要开启 `mod_headers` 模块**

```shell
# a2enmod headers
# /etc/init.d/apache2 restart
```

### **在vhosts下为指定网站开启跨域头读取权限**

```shell
<VirtualHost *:8080>
    ...
    <IfModule mod_headers.c>
        <FilesMatch "\.(svg|eot|otf|ttf|woff|woff2)$">
        Header set Access-Control-Allow-Origin "*"
        </FilesMatch>
    </IfModule>
    ...
</VirtualHost>
```

> 注意事项：

> 1. `*` 代表所有ip都允许访问
> 2. 安全起见，最好指定ip地址

## **`Apache2.4` 和 `Apache2.2` 访问控制配置语法对比**

### **拒绝所有请求**

1. `Apache2.2` 配置

  ```conf
  Order deny,allow            # 排序，先拒绝后允许
  Deny from all               # 拒绝所有
  ```

2. `Apache2.4` 配置

  ```conf
  <RequireAll>
  Require all denied      # 拒绝所有
  </RequireAll>
  ```

### **允许所有请求**

1. `Apache2.2` 配置

  ```conf
  Order allow,deny            # 排序，先允许后拒绝
  Allow from all              # 允许所有
  ```

2. `Apache2.4` 配置

  ```conf
  <RequireAll>
  Require all granted     # 允许所有
  </RequireAll>
  ```

--------------------------------------------------------------------------------
