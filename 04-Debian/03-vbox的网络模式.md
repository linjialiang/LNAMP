# <center>vbox 的网络模式</center>

> vbox 的网络模式有 6 种，并且功能也不尽相同：

| 序号 | vbox 中文版           | vbox 英文版       |
| ---- | --------------------- | ----------------- |
| 01   | 网络地址转换模式(NAT) | NAT               |
| 02   | NAT 网络              | NAT Network       |
| 03   | 桥接网卡              | Bridged Adapter   |
| 04   | 内部网络              | Internal Network  |
| 05   | 仅主机(Host-Only)网络 | Host-only Adapter |
| 06   | 通用驱动              | Generic Driver    |

## `NAT` 模式

> `NAT` 模式，是从虚拟机访问外部网络的最简单方法。通常，它不需要主机网络和虚拟机上配置什么东西。出于这个原因，它是 vbox 中默认的网络模式。
