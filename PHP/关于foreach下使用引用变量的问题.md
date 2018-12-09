<!--
@Author: madnesslin
@Date:   2018-12-09 16:22:45
@Email:  linjialiang@163.com
@Filename: foreach引用value值的后果.md
@Last modified by:   madnesslin
@Last modified time: 2018-12-09 16:23:31
-->

# 《关于foreach下使用引用变量的问题》

> 今天有群友提问了一个关于foreach下使用了引用变量的问题

## 问题描述

> 源码：群友的源代码

```php
public function demo()
{
    $a = [1, 2, 3];

    foreach ($a as $key => &$value) {}
    dump($a);

    foreach ($a as $key => $value) {}
    dump($a);

}
```

> 疑问：第二次foreach()输出的值为什么是 【1、2、2】 而不是 【1、2、3】？

```html
C:\wamp\www\tp5\thinkphp\library\think\Debug.php:226:
array (size=3)
  0 => int 1
  1 => int 2
  2 => int 3

C:\wamp\www\tp5\thinkphp\library\think\Debug.php:226:
array (size=3)
  0 => int 1
  1 => int 2
  2 => int 2
```

## 分析

> 首先我们要理解两个概念：
> 1\. 引用是什么?
> 2\. foreach() 是如何执行的？

### 引用是什么？

> 在 PHP 中引用意味着用不同的名字访问同一个变量内容。

| 定义         | 描述                               |
| ---------- | -------------------------------- |
| `$a = &$b` | `$a 或 $b` 其中一个发生改变，另一个也会跟着做相同的变化 |

> 最接近的比喻对应关系：

| 对应关系1     | 对应关系2 | 对应关系3 | 对应关系4 |
| --------- | ----- | ----- | ----- |
| linux的文件名 | 原目录   | 硬链接目录 | 文件本身  |
| 引用变量      | 变量名   | 引用变量名 | 变量内容  |

> 【文件内容】发生了变化，我们【进入原目录】或【进入硬链接目录】打开该文件，文件内容都会发生相同的改变
