# 配置apache24

- `httpd.conf` 是apache24的主配置文件，基本上我们都会在该文件上完成配置
- 注意：apache24下只有正斜杆 `/` 没有反斜杠 `\` （路径都要替换成正斜杆的方式）

## apache24主配置文件 `httpd.conf`

> httpd.conf路径

位数 | 路径
-- | ----------------------------------
32 | `C:/wamp/32/httpd/conf/httpd.conf`
64 | `C:/wamp/64/httpd/conf/httpd.conf`

### httpd.conf下配置apache24正确路径

- 描述：默认情况下apache24路径是 `c:/Apache2.4` ，需要修改成apache24当前所在目录
- 注意：新版本开始引入了 `Define` 变量定义，所以我们只需要修改一个位置

位数 | 替换前                            | 替换后
-- | ------------------------------ | --------------------------------------
32 | `Define SRVROOT "c:/Apache24"` | `Define SRVROOT "c:/wamp/32/apache24"`
64 | `Define SRVROOT "c:/Apache24"` | `Define SRVROOT "c:/wamp/64/apache24"`

### httpd.conf下设置路径变量

- 描述：新版apache24推荐使用 `Define` 来定义变量，让配置环境更加清晰、直观！
- 定义格式： `Define 变量名 变量值`
- 使用格式： `${变量名}`

> 定义变量：wamp开发环境根目录变量（ `${WAMPROOT}` ）

位数 | 设置变量
-- | ---------------------------
32 | `Define WAMPROOT "c:/wamp"`
64 | `Define WAMPROOT "c:/wamp"`

> 定义变量：版本目录变量（ `${BITPATH}` ）

位数 | 设置变量
-- | ---------------------------------
32 | `Define BITPATH "${WAMPROOT}/32"`
64 | `Define BITPATH "${WAMPROOT}/64"`

- 说明：如不需要，尽量不要定义变量
- 注意：至少要保证变量 `${WAMPROOT}` `${BITPATH}` 是第一次出现，这是符合逻辑的定义方式！
- 提示：由于 `Define` 是apache24自带的，并不需要模块支持，所以允许定义到配置文件最顶部！

### httpd.conf下为apache24增加子配置文件

- 描述：apache24支持定义子孙配置文件，支持相对路径和绝对路径，我们这里会用到绝对路径
- 格式： `Include 自配置文件路径`

```shell
<IfModule include_module>
    Include "${WAMPROOT}/conf/apache24.conf"
</IfModule>
```

- 警告：由于 `Include` 需要模块 `include_module` 支持，所以我们需要在模块定义之后添加
- 注意：由于自定义的apache24.conf文件会有各种配置，我们建议在模块定义后第一个出现就是该配置文件，这是符合逻辑的定义方式

### 删除httpd.conf多余配置项目

- 删除1：文件里所有注释的行都可以被删除掉
- 删除2：由于apache24支持相对路径，因此 `定义模块之后的内容` 都可以删除或转移到apache24.conf
- 福利：为了能更直观理解apache24配置，我会将模块往后的内容全部挪移到apache24.conf这个子配置文件里

> 兼容版 httpd.conf 内容

```shell
Define WAMPROOT "c:/wamp"
Define BITPATH "${WAMPROOT}/32"
Define SRVROOT "${BITPATH}/apache24"
Define PHPVERSION "php5"

ServerRoot "${SRVROOT}"

Listen 80

LoadModule access_compat_module modules/mod_access_compat.so
LoadModule actions_module modules/mod_actions.so
LoadModule alias_module modules/mod_alias.so
LoadModule allowmethods_module modules/mod_allowmethods.so
LoadModule asis_module modules/mod_asis.so
LoadModule auth_basic_module modules/mod_auth_basic.so
LoadModule authn_core_module modules/mod_authn_core.so
LoadModule authn_file_module modules/mod_authn_file.so
LoadModule authz_core_module modules/mod_authz_core.so
LoadModule authz_groupfile_module modules/mod_authz_groupfile.so
LoadModule authz_host_module modules/mod_authz_host.so
LoadModule authz_user_module modules/mod_authz_user.so
LoadModule autoindex_module modules/mod_autoindex.so
LoadModule cgi_module modules/mod_cgi.so
LoadModule dir_module modules/mod_dir.so
LoadModule env_module modules/mod_env.so
LoadModule include_module modules/mod_include.so
LoadModule isapi_module modules/mod_isapi.so
LoadModule log_config_module modules/mod_log_config.so
LoadModule mime_module modules/mod_mime.so
LoadModule negotiation_module modules/mod_negotiation.so
LoadModule setenvif_module modules/mod_setenvif.so

<IfModule include_module>
    Include "${SRVROOT}/conf/apache24.conf"
</IfModule>
```

> 推荐版 httpd.conf 内容

```shell
Define WAMPROOT "c:/wamp"
Define BITPATH "${WAMPROOT}/64"
Define SRVROOT "${BITPATH}/apache24"
Define PHPVERSION "php7"

ServerRoot "${SRVROOT}"

Listen 80

LoadModule access_compat_module modules/mod_access_compat.so
LoadModule actions_module modules/mod_actions.so
LoadModule alias_module modules/mod_alias.so
LoadModule allowmethods_module modules/mod_allowmethods.so
LoadModule asis_module modules/mod_asis.so
LoadModule auth_basic_module modules/mod_auth_basic.so
LoadModule authn_core_module modules/mod_authn_core.so
LoadModule authn_file_module modules/mod_authn_file.so
LoadModule authz_core_module modules/mod_authz_core.so
LoadModule authz_groupfile_module modules/mod_authz_groupfile.so
LoadModule authz_host_module modules/mod_authz_host.so
LoadModule authz_user_module modules/mod_authz_user.so
LoadModule autoindex_module modules/mod_autoindex.so
LoadModule cgi_module modules/mod_cgi.so
LoadModule dir_module modules/mod_dir.so
LoadModule env_module modules/mod_env.so
LoadModule include_module modules/mod_include.so
LoadModule isapi_module modules/mod_isapi.so
LoadModule log_config_module modules/mod_log_config.so
LoadModule mime_module modules/mod_mime.so
LoadModule negotiation_module modules/mod_negotiation.so
LoadModule setenvif_module modules/mod_setenvif.so

<IfModule include_module>
    Include "${SRVROOT}/conf/apache24.conf"
</IfModule>
```

## 配置apache24的子配置文件 `apache24.conf`

> apache24.conf路径

位数 | 路径
-- | ----------------------------
32 | `C:/wamp/conf/apache24.conf`
64 | `C:/wamp/conf/apache24.conf`

### 一、加载必要模块

> 默认并没有将模块全部开启，需要的模块在apache24.conf下加载即可，下面是我经常使用的模块

模块名           | 加载模块
------------- | ----------------------------------------------------------
`mod_alias`   | `LoadModule vhost_alias_module modules/mod_vhost_alias.so`
`mod_rewrite` | `LoadModule rewrite_module modules/mod_rewrite.so`

> 加载模块格式 `LoadModule 模块标识符 模块路径（支持相对路径和绝对路径）`

### 二、为apache24绑定php

> 绑定php需要分两步操作：1）加载php模块；2）获取php配置文件所在目录

#### 解决：php版本差异（配置文件：httpd.conf）

> 由于推荐版和兼容版php版本差异，导致模块标识符不一致，需要通过设置变量来解决

位数 | 设置变量
-- | --------------------------
32 | `Define PHPVERSION "php5"`
64 | `Define PHPVERSION "php7"`

1. 加载php模块

  ```shell
  LoadModule ${PHPVERSION}_module ${BITPATH}/php/${PHPVERSION}apache2_4.dll
  ```

2. 获取php配置文件所在目录（php.ini）

  ```shell
  <IfModule ${PHPVERSION}_module>
  PHPINIDir "${BITPATH}/php"
  </IfModule>
  ```

### ~~题外话： `mod_unixd` 模块~~

> ~~这是Unix系列平台的基本（必需）安全性模块，类unix下属于必须配置项（windows不需要这个）~~

~~属性~~           | ~~描述~~
---------------- | -------------------
~~`User 用户名`~~   | ~~指定apache24的用户~~
~~`Group 用户组名`~~ | ~~指定apache24的用户群组~~

> ~~代码案例~~

```shell
# <IfModule unixd_module>
#     User www
#     Group www
# </IfModule>
```

### 三、设置apache24站点默认配置

> 任何未由virtualhost定义处理的请求都会由该配置响应。这些值会为稍后在文件中定义的任何虚拟主机容器提供缺省值。

1. 设置默认邮箱地址

  > 这个地址出现在一些服务器生成的页面上，比如错误文档。

  ```shell
  ServerAdmin admin@example.com
  ```

2. ~~设置全局主机名~~

  > ~~一般情况下这个不需要配置，除非个人有特殊需要~~

  ```shell
  # ServerName www.example.com:80
  ```

3. 拒绝访问整个服务器的文件系统

  > 如果是服务器这个必须配置，否则整个服务器文件系统都将对访问者开放

  ```shell
  <Directory />
  AllowOverride none
  Require all denied
  </Directory>
  ```

4. 为apache24指定缺省位置

  > `DocumentRoot` 默认情况下，所有的请求都是从这个目录中获取的，安全起见不应该与其它站点设置在同一个目录下

  ```shell
  DocumentRoot "${WAMPROOT}/www-default"
  ```

5. 特定区块开放访问权限

  > 通俗讲：指定一个位置，允许访问者访问

  ```shell
  <Directory "${WAMPROOT}/www">
  Options Indexes FollowSymLinks
  AllowOverride All
  Require all granted
  </Directory>
  ```

  > 提示：一般情况下，我们会指定1个存放所有站点的根目录

### 四、设置apache24在请求目录时将服务的文件

> 我们经常说的，默认文件就是这个这个了

```shell
<IfModule dir_module>
DirectoryIndex index.html index.htm index.php
</IfModule>
```

> 提示：配置多个默认文件，会从左往右索引文件，直到找到为止。无法找到页面将无法显示或输出文件列表

### 五、阻止客户端查看特殊文件

> 一般情况下我们需要阻止 `.htaccess` 和 `.htpasswd` 文件被Web客户端查看

```shell
<Files ".ht*">
Require all denied
</Files>
```

### 六、apache24日志
> 为了有效地管理Web服务器，有必要获得有关服务器的活动和性能以及可能发生的任何问题的反馈。 `Apache HTTP Server` 提供了非常全面和灵活的日志记录功能。
