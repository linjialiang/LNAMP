# 配置 Apache24

> Apache24 是当前最流行的 web 服务器软件之一，我们通常简写为 httpd。

```text
- 注意： httpd 配置文件只支持正斜杆 `/` 不允许出现反斜杠 `\`
```

## 主配置文件

> httpd.conf 是 httpd 的主配置文件，路径如下：

```text
- 路径： C:/wamp/apache24/conf/httpd.conf
- 提示：
    c:\wamp 是 wamp 开发环境的根目录；
    如果想要更改 wamp 所在目录只需将其改成真实路径即可；
    后面涉及到的 php、mariadb 也是同理的。
```

### 配置路径

> 为 httpd 配置正确路径

- 描述：默认情况下 apache24 路径是 `c:/Apache2.4` ，需要修改成 httpd 当前所在目录

| 替换前                         | 替换后                                   |
| ------------------------------ | ---------------------------------------- |
| `Define SRVROOT "c:/Apache24"` | `Define SRVROOT "${BASE_ROOT}/apache24"` |

### 设置环境变量

> 为 httpd 设置常用路径的环境变量

````text
- 环境变量定义格式： `Define 变量名 变量值`
- 环境变量输出格式： `${变量名}`
``

| 定义变量                                    | 变量输出         | 说明                 |
| ------------------------------------------- | ---------------- | -------------------- |
| `Define WAMP_ROOT "c:/wamp"`                | `${WAMP_ROOT}`   | wamp 根目录路径      |
| `Define WEB_ROOT "c:/wamp/web"`             | `${WEB_ROOT}`    | web 目录路径         |
| `Define BASE_ROOT "${BASE_ROOT}/base"`      | `${BASE_ROOT}`   | wamp 核心目录路径    |
| `Define SRVROOT "${BASE_ROOT}/apache24"`    | `${SRVROOT}`     | 阿帕奇自带           |
| `Define PHP_VERSION "php7"`                 | `${PHP_VERSION}` | wamp 的 php 主版本号 |
| `Define HTDOCS "${WEB_ROOT}/www"`           | `${HTDOCS}`      | 站点主目录           |
| `Define HTLOGS "${WEB_ROOT}/logs/apache24"` | `${HTLOGS}`      | 阿帕奇日志目录       |

```text
- 警告：如不需要，尽量少的定义环境变量，这会提高httpd的负荷；
- 提示：由于 Define 是 apache24 自带的变量，并不需要其它模块支持，因此定义到配置文件最前面即可！
```

### 增加子配置文件

> httpd.conf 文件下增加 httpd 的子配置文件

```text
- 描述： httpd 支持定义子孙配置文件，支持相对路径和绝对路径，我们这里会用到绝对路径
- 格式： Include 自配置文件路径
```

```shell
<IfModule include_module>
    Include "${BASE_ROOT}/conf/apache24.conf"
</IfModule>
````

```text
- 警告：由于 `Include` 需要模块 `include_module` 支持，所以我们需要在模块定义之后添加
- 提示：由于自定义的 apache24.conf 文件会有各种配置，我们建议在模块定义后第一个出现就是该配置文件
```

### 清理多余配置项目

> 删除 httpd.conf 多余配置项目

```text
- 删除 1：文件里所有注释的行都可以被删除掉
- 删除 2：由于 httpd 支持相对路径，因此 `定义模块之后的内容` 都可以删除或转移到 apache24.conf
- 福利：为了能更直观理解 httpd 配置，我会将模块往后的内容全部挪移到 apache24.conf 这个子配置文件里
```

### 主配置文件源码

> 点击查看 [httpd 主配置文件](./source/httpd.conf)

### 子配置文件源码

> 点击查看 [httpd 子配置文件](./source/apache24.conf)

## 配置详解

> 从下面开始我们讲解的都是 httpd 配置文件的内部配置了

1.  加载必要模块

    > 默认并没有将模块全部开启，需要的模块在 apache24.conf 下加载即可，下面是我经常使用的模块

    | 模块名        | 加载模块                                                   |
    | ------------- | ---------------------------------------------------------- |
    | `mod_alias`   | `LoadModule vhost_alias_module modules/mod_vhost_alias.so` |
    | `mod_rewrite` | `LoadModule rewrite_module modules/mod_rewrite.so`         |

    > 加载模块格式 `LoadModule 模块标识符 模块路径（支持相对路径和绝对路径）`

2.  为 apache24 绑定 php

    > 绑定 php 需要分两步操作：1）加载 php 模块；2）获取 php 配置文件所在目录

    - 解决：php 大版本升迁问题（配置文件：httpd.conf）

      > 由于推荐版和兼容版 php 版本差异，导致模块标识符不一致，需要通过设置变量来解决

      ```shell
      # 设置变量
      Define PHP_VERSION "php7"
      ```

      > 加载 php 模块

      ```shell
      LoadModule ${PHP_VERSION}_module ${BASE_ROOT}/php/${PHP_VERSION}apache2_4.dll
      ```

      > 获取 php 配置文件所在目录（php.ini）

      ```shell
      <IfModule ${PHP_VERSION}_module>
          PHPINIDir "${BASE_ROOT}/php"
      </IfModule>
      ```

      - 题外话： `mod_unixd` 模块

      > 这是 Unix 系列平台的基本（必需）安全性模块，类 unix 下属于必须配置项（windows 不需要这个）

      | 属性             | 描述                     |
      | ---------------- | ------------------------ |
      | `User 用户名`    | 指定 apache24 的用户     |
      | `Group 用户组名` | 指定 apache24 的用户群组 |

      > 代码案例

      ```shell
      # <IfModule unixd_module>
      #     User www
      #     Group www
      # </IfModule>
      ```

3.  设置 apache24 站点默认配置

    > 任何未由 virtualhost 定义处理的请求都会由该配置响应。这些值会为稍后在文件中定义的任何虚拟主机容器提供缺省值。

    - 设置默认邮箱地址

      > 这个地址出现在一些服务器生成的页面上，比如错误文档。

      ```shell
      ServerAdmin admin@example.com
      ```

    - 设置全局主机名

      > 一般情况下这个不需要配置，除非个人有特殊需要

      ```shell
      # ServerName www.example.com:80
      ```

    - 拒绝访问整个服务器的文件系统

      > 如果是服务器这个必须配置，否则整个服务器文件系统都将对访问者开放

      ```shell
      <Directory />
          AllowOverride none
          Require all denied
      </Directory>
      ```

    - 为 apache24 指定站点缺省位置

      ```text
      - apache24 未配置 VirtualHost 的域名会访问第一个 VirtualHost 配置下的站点目录
      - DocumentRoot 是会被探针识别为站点目录的，安全起见不应该与其它站点设置在同一个根目录下
      ```


      ```shell
      DocumentRoot "${BASE_ROOT}/default"
      ```

      > 为站点缺省位置配置访问权限（不配置会禁止所有人访问--继承于 `<Directory />` 的配置，）

      ```shell
      <Directory "${BASE_ROOT}/default">
          Options FollowSymLinks
          AllowOverride None
          Require all granted
      </Directory>
      ```

      > 由于 apache24 的第一个 `<VirtualHost>` 设置的站点目录为 `${BASE_ROOT}/www-default` ，因此缺省站点都会访问该目录！

      ```shell
      <VirtualHost *:80>
          DocumentRoot "${BASE_ROOT}/default"
      </VirtualHost>
      ```

    - 特定区块开放访问权限

      > 通俗讲：指定一个位置，允许访问者访问

      ```shell
      <Directory "${HTDOCS}">
          Options Indexes FollowSymLinks
          AllowOverride All
          Require all granted
      </Directory>
      ```

      > 提示：一般情况下，我们会指定 1 个存放所有站点的根目录

    - 本节附录：

        > `Options` 部分属性值

        | Options 属性值   | 描述               | 服务器建议 |
        | ---------------- | ------------------ | ---------- |
        | `Indexes`        | 允许展示目录式列表 | 关闭       |
        | `FollowSymLinks` | 允许访问 url 链接  | 开启       |

        > `AllowOverride` 部分属性值

        | AllowOverride 属性值 | 描述                     | 考虑与建议 |
        | -------------------- | ------------------------ | ---------- |
        | `None`               | 不允许任何.htaccess 规则 | 更安全     |
        | `All`                | 允许任何.htaccess 规则   | 更方便     |

4. 设置 apache24 在请求目录时将服务的文件

   > 我们经常说的，默认文件就是这个这个了

   ```shell
   <IfModule dir_module>
   DirectoryIndex index.html index.htm index.php
   </IfModule>
   ```

   > 提示：配置多个默认文件，会从左往右索引文件，直到找到为止。无法找到页面将无法显示或输出文件列表

5. 阻止客户端查看特殊文件

   > 一般情况下我们需要阻止 `.htaccess` 和 `.htpasswd` 文件被 Web 客户端查看

   ```shell
   <Files ".ht*">
   Require all denied
   </Files>
   ```

6. 三 组不需要特别修改的默认配置

   > 这几组都是默认配置，我们将配置移除掉了

   ```shell
   <IfModule alias_module>
       ScriptAlias /cgi-bin/ "${SRVROOT}/cgi-bin/"
   </IfModule>

   <Directory "${SRVROOT}/cgi-bin">
       AllowOverride None
       Options None
       Require all granted
   </Directory>

   <IfModule headers_module>
       RequestHeader unset Proxy early
   </IfModule>
   ```

7. 为 php 关联扩展名（支持多个扩展名）

   > 操作：在 `<IfModule mime_module>` 内新增一行代码

   ```shell
   <IfModule mime_module>
       TypesConfig conf/mime.types

       AddType application/x-compress .Z
       AddType application/x-gzip .gz .tgz
       AddType application/x-httpd-php .php
   </IfModule>
   ```

   > 格式： `AddType application/x-httpd-php [.扩展名1] [.扩展名2] ...`

8. 两组组不需要特别修改的默认配置

   ```shell
   <IfModule proxy_html_module>
       Include conf/extra/proxy-html.conf
   </IfModule>

   <IfModule ssl_module>
       SSLRandomSeed startup builtin
       SSLRandomSeed connect builtin
   </IfModule>
   ```

9. 为 apache24 虚拟主机配置文件指定存放目录

   > 说明：虚拟主机配置文件其实就是，apache24 的子孙配置文件

   ```shell
   <IfModule include_module>
       Include "${WEB_ROOT}/sites/*.conf"
   </IfModule>
   ```

   > 提示：Include 支持简单的正则表达式

## apache24.conf 内容

> 兼容版和推荐版用的都是同一个 [apache24.conf](./soure/apache24.conf) 配置文件

## 虚拟主机相关配置

> 这里我主要讲解 2 个内容：1）别名配置；2）虚拟主机配置

## 一、别名配置

> 以 `phpmtadmin` 和 `adminer.php` 为例：
>
> - 站点配置目录下新建文件 `phpmyadmin.conf` ，下面直接贴代码：

```shell
Alias /phpmyadmin ${BASE_ROOT}/phpmyadmin
<Directory ${BASE_ROOT}/phpmyadmin>
    Options FollowSymLinks
    DirectoryIndex index.php
    <RequireAll>
        Require local
    </RequireAll>
</Directory>
<Directory ${BASE_ROOT}/phpmyadmin/libraries>
    Require all denied
</Directory>
<Directory ${BASE_ROOT}/phpmyadmin/setup/lib>
    Require all denied
</Directory>
Alias /adminer ${BASE_ROOT}/phpmyadmin/adminer.php
```

## 二、配置虚拟主机

> 站点配置目录下新建 `.conf` 扩展的文件，下面直接贴代码：

```shell
<VirtualHost *:80>
    ServerAdmin admin@example.com
    DocumentRoot "${HTDOCS}/www_test_com"
    ServerName www.test1.com
    ServerAlias www.test1.com test1.com www.test2.com test2.com
    ErrorDocument 404 /Error.html

    ErrorLog "${HTLOGS}/error/test.log"
    CustomLog "${HTLOGS}/access/test.log" common

    RewriteEngine on
    RewriteCond %{HTTP_HOST} ^test1.com$ [NC]
    RewriteRule ^(.*)$ http://www.%{HTTP_HOST}$1 [R=301,L]
    RewriteCond %{HTTP_HOST} ^test2.com$ [NC]
    RewriteRule ^(.*)$ http://www.%{HTTP_HOST}$1 [R=301,L]
</VirtualHost>
```

> 最简洁虚拟主机配置

```shell
<VirtualHost *:80>
    DocumentRoot "${HTDOCS}/www_test_com"
    ServerName www.test1.com
</VirtualHost>
```

> ssl 版配置

```shell
<VirtualHost *:80>
    ServerName www.test.com
    ServerAlias test.com www.test.com
    DocumentRoot "${HTDOCS}/www_test_com"

    RewriteEngine on
    RewriteCond %{SERVER_PORT} 80 [NC]
    RewriteRule ^(.*)$ https://%{HTTP_HOST}$1 [R=301,L]
</VirtualHost>

<virtualhost *:443>
    ServerName www.test.com
    ServerAlias test.com www.test.com
    DocumentRoot "${HTDOCS}/www_test_com"

    RewriteEngine on
    RewriteCond %{HTTP_HOST} ^test.com$ [NC]
    RewriteRule ^(.*)$ https://www.%{HTTP_HOST}$1 [R=301,L]

    SSLEngine on
    SSLCertificateFile 路径/2_www.test.com.crt
    SSLCertificateKeyFile 路径/3_www.test.com.key
    SSLCertificateChainFile 路径/1_root_bundle.crt
</virtualhost>
```

## 三、将域名绑定到本地

> windows 开发环境只有在系统文件 `hosts` 下加入指定的域名，网站才能正常访问！

```hosts
# 在底部新增几行内容
127.0.0.1 test.com www.test.com
127.0.0.1 test1.com www.test1.com
127.0.0.1 test2.com www.test2.com
```

> 文件路径： `c:\Windows\System32\drivers\etc\hosts`

## httpd 日志

> 点击查看详情 [httpd 日志](./info/httpd日志.md)

## httpd 访问控制

> 点击查看详情 [httpd 访问控制](./info/httpd访问控制.md)

## 结束语

> 关于 apache24 的配置讲解到此就为止，想要深入学习，建议去[apache24 官网查看手册](https://httpd.apache.org/docs/2.4/)！
