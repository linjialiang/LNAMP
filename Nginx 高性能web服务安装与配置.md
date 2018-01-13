# **`Nginx` 高性能web服务安装与配置**

> `Nginx` 作为现在非常流行，并且具有优良的处理高并发能力，是每个php程序员应该掌握的！

## **安装 `Nginx`**

```shell
#apt-get install nginx
```

## **`Nginx` 配置文件**

> 大致上和 `apache2` 类似，说不同的就是写法与语法的区别

> 1. `Nginx` 常用的配置文件都在 `/etc/nginx/` 下面
> 2. `/etc/nginx/nginx.conf` 是 `Nginx` 主配置文件
> 3. `sites-enabled` 是站点配置文件存放目录

- 备份并打开配置文件

  ```shell
  # cp /etc/nginx/nginx.conf{,.backup}
  # vim /etc/nginx/nginx.conf
  ```

### **更改 `Ngnix` 用户及用户组**

- 找到 `user www-data;` 注释并在下面增加一行

  ```conf
  ## user www-data;
  user www www;
  ```

- 保存并重启

  ```shell
  # /etc/init.d/nginx restart
  ```

### **增加站点配置文件目录**

- 找到 `include /etc/nginx/sites-enabled/*;` 在下面增加一行

  ```conf
  ## 找到下面这行
  include /etc/nginx/sites-enabled/*;
  ## 增加下面这行
  include /alidata/conf/nginx-sites/*.conf;
  ```

- 新建目录并重启

```shell
# mkdir /alidata
# mkdir /alidata/conf
# mkdir /alidata/conf/nginx-sites

# /etc/init.d/nginx restart
```

### **`Nginx` 修改日志路径**

> 在 `/etc/nginx/nginx.cong` 下配置

```conf
## 找到下面这2行，注释并在下面添加自己的日志路径
## access_log /var/log/nginx/access.log
## error_log /var/log/nginx/error.log

access_log /alidata/log/nginx/access.log
error_log /alidata/log/nginx/error.log
```

- 拷贝文件并重启

```shell
# mkdir /alidata/log/nginx
# cp -p -r /{var,alidata}/log/nginx/access.log
# cp -p -r /{var,alidata}/log/nginx/error.log
# chown www:www /alidata/log/nginx/{access,error}.log

# /etc/init.d/nginx restart
```

## ** `nginx` 站点配置文件**

### **`nginx` 普通站点配置文件**

```conf
server {
    listen 80;
    server_name test.com www.test.com;
    root /alidata/www/www_test_com;
    index index.html index.htm

    error_page 404 = /404.html;
}
```

### **`nginx` 支持 php 的站点配置文件**

```conf
server {
    listen 80;
    server_name test.com www.test.com;
    root /alidata/www/www_test_com;
    index index.html index.htm index.php;

    error_page 404 = /404.html;

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
    }
}
```

### **`Nginx` php反向代理 php，由 `apache2` 执行 php **

1. `nginx` 站点配置文件

```conf
server {
    listen 80;
    server_name test.com www.test.com;
    root /alidata/www/www_test_com;
    index index.html index.htm index.php;

    error_page 404 = /404.html;

    location ~ ^(.+\.php)(.*)$ {
        proxy_pass http://www.test.com:8080;
    }
}
```

2. `apache2` 站点配置文件

```conf
<VirtualHost *:8080>
    ServerAdmin linjialiang@163.com
    ServerName www.test.com
    ServerAlias test.com www.test.com
    DocumentRoot /alidata/www/yhz/www_test_com
    DirectoryIndex index.php
    
    ErrorDocument 404 /404.html
</VirtualHost>
```

### **`Nginx` 做反向代理， 所有文件全部由 `apache2` 执行**

1. `nginx` 站点配置文件

```conf
server {
    listen 80;
    server_name test.com www.test.com;
    root /alidata/www/www_test_com;
    index index.html index.htm index.php;
    
    error_page 404 = /404.html;
    
    location ~ {                                                                                     
        proxy_pass http://www.test.com:8080;
    }
}
```

2. `apache2` 站点配置文件

```conf
<VirtualHost *:8080>
    ServerAdmin linjialiang@163.com
    ServerName www.test.com
    ServerAlias test.com www.test.com
    DocumentRoot /alidata/www/yhz/www_test_com
    DirectoryIndex index.php
    
    ErrorDocument 404 /404.html
</VirtualHost>
```

---
