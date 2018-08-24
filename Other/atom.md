# <center>Atom 使用手册</center>

> atom 是一个界面非常优雅，功能也及其丰富的编辑器，当然不可否认的是它也是非常多的缺点，不过着并不影响码农们对它的喜爱！

## atom的基本设置

> 下面是录制的基本设置以及一些截图

-   动画-atom基本设置

    ![动画-atom基本设置](./atom/atom基本设置.gif)

-   设置界面

    ![设置界面](./atom/设置界面.png)

-   设置界面-1

    ![设置界面-1](./atom/设置界面-1.png)

-   设置界面-2

    ![设置界面-2](./atom/设置界面-2.png)

-   设置界面-3

    ![设置界面-3](./atom/设置界面-3.png)

-   设置界面-4

    ![设置界面-4](./atom/设置界面-4.png)

-   设置界面-5

    ![设置界面-5](./atom/设置界面-5.png)

## atom 插件|主题汇总

> 这里罗列了我经常会用到的插件，同学们按需自己下载

| 主题                     | 主题说明  |
| ---------------------- | ----- |
| `monokai`              | 代码样式1 |
| `nord-atom-syntax`     | 代码样式2 |
| `atom-material-syntax` | 代码样式3 |

| git相关插件                | 插件说明                  |
| ---------------------- | --------------------- |
| `git-plus`             | 增强git功能               |
| `git-time-machine`     | 近期提交的时间列表，并支持与当前内容做对比 |
| `merge-conflicts`      | 优秀的git合并视图            |
| `tree-view-git-status` | git相关                 |
| `split-diff`           | 可以根任何文件做对比，不需要git支持   |

| 其它实用插件                           | 插件说明                  |
| -------------------------------- | --------------------- |
| `highlight-selected`             | 选择高亮                  |
| `advanced-open-file`             | 打开、创建文件的另一种方式         |
| `atom-beautify`                  | 格式化源代码                |
| `docblockr`                      | 注释神器                  |
| `Sublime-Style-Column-Selection` | 复制任意区域，比如：复制联系数行的中间区域 |
| `autocomplete-paths`             | 文件自动不全插件              |
| `project-viewer`                 | 项目管理插件                |
| `sync-settings`                  | atom配置同步插件            |
| `markdown-scroll-sync`           | markdown文件预览时同步       |
| `regex-railroad-diagram`         | 正则表达式图形界面             |
| `platformio-ide-terminal`        | 比较好用的控制台              |

| minimap相关插件                  | 插件说明          |
| ---------------------------- | ------------- |
| `minimap`                    | 代码小窗口         |
| `minimap-bookmarks`          | 代码小窗口-书签高亮    |
| `minimap-cursorline`         | 代码小窗口-当前行高亮   |
| `minimap-find-and-replace`   | 代码小窗口-搜索高亮    |
| `minimap-git-diff`           | 代码小窗口-git对比高亮 |
| `minimap-highlight-selected` | 代码小窗口-选择高亮    |
| `minimap-selection`          | 代码小窗口-选择块高亮   |
| `minimap-split-diff`         | 代码小窗口-对比高亮    |

| ide相关插件          | 插件说明           |
| ---------------- | -------------- |
| `atom-ide-ui`    | atom的ide基础包    |
| `ide-php`        | php的ide        |
| `ide-typescript` | JavaScript的ide |

| 符号对齐相关插件             | 插件说明    |
| -------------------- | ------- |
| `aligner`            | 符号对齐基础包 |
| `aligner-css`        | css对齐   |
| `aligner-javascript` | js对齐    |
| `aligner-php`        | php对齐   |

| 语法相关插件            | 插件说明           |
| ----------------- | -------------- |
| `language-apache` | apache配置文件语法高亮 |
| `language-ini`    | ini扩展文件语法高亮    |
| `language-nginx`  | nginx配置文件语法高亮  |

| 界面优化插件                | 插件说明 |
| --------------------- | ---- |
| `atom-clock`          | 时钟   |
| `file-icons`          | 文件图标 |

| html相关插件                    | 插件说明           |
| --------------------------- | -------------- |
| `atom-html-preview`         | atom内嵌浏览器      |
| `autoprefixer`              | css3后缀自动完成     |
| `open-in-browser`           | html页面从默认浏览器打开 |
| `color-picker`              | 颜色选择           |
| `autocomplete-font-awesome` | 字体图标库          |

| vim相关插件            | 插件说明           |
| ------------------ | -------------- |
| `vim-mode-plus`    | vim插件基础包       |
| `relative-numbers` | vim普通模式下显示先对行号 |
| `ex-mode`          | atom下的ex单行编辑器  |

> 插件管理

| 说明   | 指令                                             |
| ---- | ---------------------------------------------- |
| 安装插件 | `apm install package1 [package2 package3 ...]` |
| 卸载插件 | `apm remove package1 [package2 package3 ...]`  |
| 禁用插件 | `apm disable package1 [package2 package3 ...]` |

## 配置插件

> 有些插件需要我们进一步配置，才能更有效提升工作效率

1.  `sync-settings` 插件配置

> 这是atom配置同步插件配置也很简单，填入正确的token跟gistid即可

| 命令                           | 说明                                           |
| ---------------------------- | -------------------------------------------- |
| `sync-settings:backup`       | 这条命令是备份当前的配置                                 |
| `sync-settings:restore`      | 这条命令是回复配置,是直接覆盖的;                            |
| `sync-settings:view-backup`  | 这条是当你执行备份后到线上查询你的备份的,也就是到你的 `gist code` 里的内容 |
| `sync-settings:check-backup` | 这条是查询最后一次是否正常                                |

2. `atom-beautify` 插件配置

> `atom-beautify` 有些语言的格式化需要依赖与其它工具，遇到问题可以查看插件说明


## atom 实用快捷键

> 网上关于atom快捷键的文章都有问题，所以我这里整理了一些常用的快捷键（包含插件的快捷键）

| 快捷键 | 快捷键功能 |
| --- | ----- |
| `C-k C-u`  | 使当前字符大写 |
| `C-k C-l`  | 使当前字符小写 |
