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

位数 | 代码
-- | ---------------------------
32 | `Define WAMPROOT "c:/wamp"`
64 | `Define WAMPROOT "c:/wamp"`

> 定义变量：版本目录变量（ `${VERSIONPAHT}` ）

位数 | 代码
-- | ---------------------------------
32 | `Define VERSIONPAHT "${WAMPROOT}/32"`
64 | `Define VERSIONPAHT "${WAMPROOT}/64"`

- 说明：如不需要，尽量不要定义变量
- 注意：至少要保证变量 `${WAMPROOT}` `${VERSIONPAHT}` 是第一次出现，这是符合逻辑的定义方式！
- 提示：由于 `Define` 是apache24自带的，并不需要模块支持，所以允许定义到配置文件最顶部！

### httpd.conf下为apache24增加子配置文件

- 描述：apache24支持定义子孙配置文件，支持相对路径和绝对路径，我们这里会用到绝对路径
- 格式： `Include 自配置文件路径`

```conf
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

```conf
Define WAMPROOT "c:/wamp"
Define VERSIONPAHT "${WAMPROOT}/64"
Define SRVROOT "${VERSIONPAHT}/apache24"

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

```conf
Define WAMPROOT "c:/wamp"
Define VERSIONPAHT "${WAMPROOT}/64"
Define SRVROOT "${VERSIONPAHT}/apache24"

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

模块名           | 贴代码
------------- | ----------------------------------------------------------
`mod_alias`   | `LoadModule vhost_alias_module modules/mod_vhost_alias.so`
`mod_rewrite` | `LoadModule rewrite_module modules/mod_rewrite.so`

> 加载模块格式 `LoadModule 模块标识符 模块路径（支持相对路径和绝对路径）`

### ~~题外话： `unixd_module` 模块~~

> 这是Unix系列平台的基本（必需）安全性模块，类unix下属于必须配置项（windows不需要配置）

属性           | 描述
------------ | ---------------
`User 用户名`   | 指定apache24的用户
`Group 用户组名` | 指定apache24的用户群组

> 代码案例

```conf
<IfModule unixd_module>
    User www
    Group www
</IfModule>
```
