# ngx_http_access_module

> ngx_http_access_module 模块允许限制对某些客户机地址的访问。

- 访问除了收到此模块的限制，还可以通过 `ngx_http_auth_basic_module`、`ngx_http_auth_request_module`或 `ngx_http_auth_jwt_module` 的限制。
- http 核心模块的 `satisfy` 指令，可以让这些模块的指令同时控制访问。

## 模块指令

> 该模块就两条指令： `allow` 和 `deny`

1. `allow`

   > 允许访问指定的网络或地址。如果指定了特殊值 `unix:`，则允许访问所有 unix 域套接字。

   | Syntax  | `allow address | CIDR | unix: | all;` |
   | ------- | ------------------------------------- |
   | Default | —                                     |
   | Context | http, server, location, limit_except  |

2. `deny`

   > 拒绝访问指定的网络或地址。如果指定了特殊值`unix:`，则拒绝访问所有 unix 域套接字。

   | Syntax  | `deny address | CIDR | unix: | all;` |
   | ------- | ------------------------------------ |
   | Default | —                                    |
   | Context | http, server, location, limit_except |

## 案例分析

> 配置文件：

```conf
location / {
    deny  192.168.1.1;
    allow 192.168.1.0/24;
    allow 10.1.1.0/16;
    allow 2001:0db8::/32;
    deny  all;
}
```

> 解释：

```text
规则按顺序检查，直到找到第一个匹配项为止。
在本例中：
    - 只允许访问IPv4网络10.1.1.0/16和192.168.1.0/24(不包括地址192.168.1.1)，以及IPv6网络 2001:0db8::/32 。
    - 对于很多规则，最好使用ngx_http_geo_module模块变量。
```
