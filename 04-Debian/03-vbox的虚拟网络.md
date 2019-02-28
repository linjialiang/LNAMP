# <center>vbox 的虚拟网络</center>

> vbox 的虚拟网络有 6 种模式，并且功能也不尽相同：

| 序号 | vbox 中文版           | vbox 英文版       | vbox 官方手册版                     |
| ---- | --------------------- | ----------------- | ----------------------------------- |
| 01   | 网络地址转换模式(NAT) | NAT               | Network Address Translation (NAT)   |
| 02   | NAT 网络              | NAT Network       | Network Address Translation Service |
| 03   | 桥接网卡              | Bridged Adapter   | Bridged networking                  |
| 04   | 内部网络              | Internal Network  | Internal networking                 |
| 05   | 仅主机(Host-Only)网络 | Host-only Adapter | Host-only networking                |
| 06   | 通用驱动              | Generic Driver    | Generic networking                  |

> vbox 重要虚拟网络模式的联网状态：

| 虚拟网络模式     | NAT      | NAT 网络 | 桥接    | Internal | Host-only |
| ---------------- | -------- | -------- | ------- | -------- | --------- |
| 虚拟电脑`->`宿主 | &#8730;  | &#8730;  | &#8730; | &#215;   | &#8730;   |
| 虚拟电脑`<-`宿主 | 端口转发 | 端口转发 | &#8730; | &#215;   | &#8730;   |
| 虚拟电脑之间     | &#215;   | &#8730;  | &#8730; | &#8730;  | &#8730;   |
| 虚拟电脑`->`外网 | &#8730;  | &#8730;  | &#8730; | &#215;   | &#215;    |
| 虚拟电脑`<-`外网 | 端口转发 | 端口转发 | &#8730; | &#215;   | &#215;    |

## `NAT` 模式

> `NAT` 模式，是从虚拟机访问外部网络的最简单方法。通常，它不需要主机网络和虚拟机上配置什么东西。出于这个原因，它是 vbox 中默认的虚拟网络模式。
