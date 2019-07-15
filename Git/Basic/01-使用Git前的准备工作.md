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

## 中文乱码

> 如果涉及到中文，请关闭路径引用 quotepath ，以便支持 0x80 以后的编码正常显示

```shell
$ git config --global core.quotepath false
```

## 换行符

> Git 可以自由的操作换行符。

1. 拒绝提交包含混合换行符的文件

   > 确保文件中的换行符一致。

   ```shell
   $ git config --global core.safecrlf true
   ```

2. 换行符的转换方式

   > Git 中对换行符的转换方式有 3 种（推荐 input）：

   ```shell
   # 提交时自动地把回车和换行转换成换行，而在检出代码时把换行转换成回车和换行
   $ git config --global core.autocrlf true
   # 提交时将回车和换行转换成换行，而在检出代码时不做处理
   $ git config --global core.autocrlf input
   # 如果程序仅运行在 Windows 上的项目，可以设置 false 取消此功能，把回车保留在版本库中：
   $ git config --global core.autocrlf false
   ```

   | 名词 | 解释 |
   | ---- | ---- |
   | CR   | 回车 |
   | LF   | 换行 |

## 编辑器

> 编辑器一般都是使用 vim，默认即可：

```shell
$ git config --global core.editor <editor_name>
```

## 忽略文件

> 项目中的 `.gitignore` 文件可以指定不需要 Git 跟踪的文件。

1. `.gitignore` 文件语法规则：

   ```ini
   - 所有空格或者以 # 开头的行都会被 Git 忽略；
   - 可以使用标准的 glob 模式匹配；
   - 匹配 glob 模式可以以 / 开头防止递归；
   - 匹配 glob 模式可以以 / 结尾指定目录；
   - 要忽略指定模式意外的文件或目录，可以在模式前面加上感叹号 ! 取反；
   - glob 模式，指的是 shell 所使用的简化了的正则表达式，规则如下：
      1. 星号 * 匹配 0 个或多个任意字符；
      2. [abd] 要嘛匹配 a，要嘛匹配 b，要嘛匹配 c；
      3. 问好 ? 只匹配一个任意字符；
      4. [0-9] 表示匹配所有 0 到 9 的数字组合；
      5. a/**/z 表示可以匹配 a/z a/b/z a/b/c/z 等（两个星号 * 匹配任意中间目录）。
   ```

2. 案例一、使用 vim 编辑器需要忽略的文件：

   ```shell
   # Swap
   [._]*.s[a-v][a-z]
   [._]*.sw[a-p]
   [._]s[a-v][a-z]
   [._]sw[a-p]
   # Session
   Session.vim
   # Temporary
   .netrwhist
   *~
   # Auto-generated tag files
   tags
   ```

## Git 配置文件

> 下面列举 Git 允许读取的配置文件路径：

| 路径                                 | 范围         | 优先级 |
| ------------------------------------ | ------------ | ------ |
| /etc/gitconfig                       | 全局         | 最低   |
| ~/.gitconfig 或 ~/.config/git/config | 系统当前用户 | 较低   |
| .git/config                          | 当前仓库     | 最高   |

### Windows 下快速配置

> Windows 下直接将 `~/.gitconfig` 文件的内容替换如下代码即可：

```shell
[user]
	email = Your_Email
	name = Your_Name
[color]
    ui = true
[core]
    autocrlf = input
    quotePath = false
    ignorecase = false
```

## Git 概念

> 如果你希望后面的学习更顺利，记住下面这些关于 Git 的概念。

### 三种状态

> Git 有三种状态，你的文件可能处于其中之一：

| 三种状态            | 描述                                                                 |
| ------------------- | -------------------------------------------------------------------- |
| 已提交（committed） | 表示数据已经安全的保存在本地数据库中。                               |
| 已修改（modified）  | 表示修改了文件，但还没保存到数据库中。                               |
| 已暂存（staged）    | 表示对一个已修改文件的当前版本做了标记，使之包含在下次提交的快照中。 |

### 三个工作区域

> 由三种状态引入 Git 项目的三个工作区域的概念：

| 三个工作区域 | 描述                                                                        |
| ------------ | --------------------------------------------------------------------------- |
| Git 仓库目录 | Git 用来保存项目的元数据和对象数据库的地方。                                |
| 工作目录     | 工作目录是对项目的某个版本独立提取出来的内容。                              |
| 暂存区域     | 暂存区域是一个文件，保存了下次将提交的文件列表信息，一般在 Git 仓库目录中。 |
