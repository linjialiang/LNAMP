# 使用 Git 前的准备工作

> 假设我们已经安装好了 Git ，接下来我们就要先对 Git 进行设置, 以便 Git 正常工作。

## 设置用户及电子邮件

> 这是必须要设置的，否则 Git 无法正常工作

```shell
$ git config --global user.name <"Your Name">
$ git config --global user.email <"Your Email">
```

## 颜色支持

> Git 可以按自己要求，开启和关闭颜色高亮

1. 开启默认颜色支持

   ```shell
   $ git config --global color.ui true
   ```

2. 关闭颜色支持

   ```shell
   $ git config --global color.ui false
   ```

3. 自定义颜色值

   > 如果更改具体属性的输出高亮颜色值，可如下设置：

   ```shell
   $ git config --global color.<属性>.meta <"前景色 背景色 字体效果">
   ```

   | 属性列表     | 属性列表          | 属性列表   | 属性列表     |
   | ------------ | ----------------- | ---------- | ------------ |
   | color.branch | color.interactive | color.diff | color.status |

   | 颜色值列表 | 颜色值列表 | 颜色值列表 | 颜色值列表 | 颜色值列表 |
   | ---------- | ---------- | ---------- | ---------- | ---------- |
   | normal     | white      | cyan       | magenta    | red        |
   | black      | blue       | yellow     | green      |

   | 字体效果 | 字体效果 | 字体效果     | 字体效果 | 字体效果                  |
   | -------- | -------- | ------------ | -------- | ------------------------- |
   | bold     | dim      | ul（下划线） | blink    | reverse（交换前、背景色） |
