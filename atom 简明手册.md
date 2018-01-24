# **`atom` 简明手册**

> - `atom` 是一个十分优秀的编辑器，现在已经是不多数程序员的主流编辑器
> - 该篇文章测试环境为 `win10` 系统，如果需要在其它系统上完成以下操作，可能需要一些变通

## **`atom` 安装**

> - 安装很简单，就是下载后，双击等待安装完成！
> - 不重点讲解

## **`atom` 配置**

> - 安装好后就需要配置编辑器，让其更加符合自己的要求，因为都是英文的，如果英文功底不足，可以安装一个中文插件（见插件篇）
> - `atom` 支持多字体模式： `DejaVu Sans Mono, Microsoft YaHei Mono`
> - 不重点讲解

## **`atom` 翻墙**

> `atom` 不翻墙就不能正常下载、更新插件。

1. 首先查看 `atom` 是否正确配置到系统环境变量

  > 打开 `cmd` ， 如果正常会显示软件版本，否则请检查以上操作是否正确

  ```shell
  atom -v
  ```

2. 修改 `.apmrc` 配置文件

  > - 修改或新建 `.apmrc`
  > - 所在目录 `C:\Users\username\.atom\.apmrc`
  > - `http-proxy` `https-proxy` 这两个都是 `http://` 协议

  ```apmrc
  strict-ssl = false
  http-proxy = http://127.0.0.1:1080
  https-proxy = http://127.0.0.1:1080
  ```

3. 下载插件安装组件，在 `cmd` 上操作

  > `atom` 安装插件是需要专门的组件支持的

  > - 成功标志：Checking for native build tools `done`

  ```shell
  apm install --check
  ```

## **`atom` 插件安装**

> `atom` 主要就是对插件的选择和配置：

> 1. 根据自己的需要下载插件，以尽量减少插件量为原则
> 2. 根据自己语言，下载对应的插件，可能我这里的插件并不是你需要的，但是安装和配置的窍诀都是相通的

### `插件安装方式`

> 安装插件方式有好几种，这里只介绍 `cmd` 下 `apm` 的安装方式

1. 插件安装

  ```shell
  apm install packageName
  ```

2. 插件卸载

  ```shell
  apm remove packageName
  ```

3. 清理插件痕迹

  ```shell
  apm clean
  ```

### `atom` 插件列表

> 将我正在使用的插件罗列在此（不代表其它插件不优秀）

```shell
Community Packages (38) C:\Users\username\.atom\packages
├── activate-power-mode@2.7.0
├── advanced-open-file@0.16.7
├── atom-autocomplete-php@0.25.6
├── atom-beautify@0.30.9
├── atom-clock@0.1.16
├── atom-ide-ui@0.7.2
├── atom-ternjs@0.18.3
├── autoclose-html@0.23.0
├── autocomplete-paths@2.12.2
├── autoprefixer@3.7.1
├── color-picker@2.2.5
├── docblockr@0.13.6
├── emmet@2.4.3
├── ex-mode@0.18.0
├── file-icons@2.1.16
├── highlight-line@0.12.0
├── highlight-selected@0.13.1
├── ide-php@0.7.4
├── ide-typescript@0.7.2
├── markdown-scroll-sync@2.1.2
├── minimap@4.29.7
├── minimap-bookmarks@0.4.2
├── minimap-cursorline@0.2.0
├── minimap-find-and-replace@4.5.2
├── minimap-highlight-selected@4.6.1
├── minimap-pigments@0.2.2
├── minimap-split-diff@0.3.7
├── monokai@0.24.0
├── native-ui@0.25.2
├── open-in-browser@0.5.2
├── pigments@0.40.2
├── platformio-ide-terminal@2.8.0
├── project-viewer@1.2.5
├── relative-numbers@0.9.0
├── script@3.17.3
├── split-diff@1.5.2
├── sync-settings@0.8.3
└── vim-mode-plus@1.26.0
```

### 让 `atom` 支持简体中文

> - `simplified-chinese-menu` 这是 `atom` 上简体中文菜单插件
> - 安装之后菜单全部变成，中文界面

```shell
apm install simplified-chinese-menu
```

### 让 `atom` 同步

> - `sync-settings` 可以支持同步界面配置、插件配置
> - 在配置界面写入 `Personal Access Token` 和 `gistID`

>   1. 备份： `sync-settings:backup`
>   2. 恢复： `sync-settings:restore`
>   3. 查看在线备份： `sync-settings:view-backup`
>   4. 检查最新的备份应用： `sync-settings:check-backup`

```shell
apm install sync-settings
```

### 让 `atom` 支持小窗口预览

> - `minimap` 这个是小窗口预览插件
> - 有写插件基于此插件写的，并且非常优秀

```shell
apm install minimap
```

### 让 `atom` 图标个性化

> `file-icons` 这个插件可以让不同格式文件直观显示

```shell
apm install file-icons
```

### 让 `atom` 高亮当前行

> - `highlight-line` 这是高亮当前行插件
> - `highlight-column` 这是高亮当前列插件（用处不大）

```shell
apm install highlight-line
```

### 让 `atom` 高亮选择文字

> - `atom` 自带搜索高亮，但是选择高亮需要插件
> - `highlight-selected` 这是高亮选择插件

```shell
apm install highlight-selected
```

### 让 `atom` 快捷创建目录和文件

> - `advanced-open-file` 支持快捷创建目录和文件
> - 快捷键： `Ctrl-Alt-O`

```shell
apm install advanced-open-file
```

### 让 `atom` 支持文件对比

> - `split-diff` 是对比插件
> - `minimap-split-diff` 基于 `minimap` 的小窗口对比高亮插件

>   1. `Split Diff: Enable` 启用两个并排窗格之间的文本差异。根据需要创建窗格。。
>   2. `Split Diff: Toggle` 在两个并排的窗格之间切换文本的差异。根据需要创建窗格
>   3. `Split Diff: Disable` 禁用创建的窗格，禁用文件差异对比
>   4. `split-diff:ignore-whitespace` 切换忽略空格插件高亮
>   5. `split-diff:next-diff` 移动到后一个差异，并选择，便于复制
>   6. `split-diff:prev-diff` 移动到前一个差异，并选择，便于复制
>   7. `split-diff:copy-to-left` 将包含光标的所有差异复制到左侧窗格。
>   8. `split-diff:copy-to-right` 将包含光标的所有差异复制到右侧窗格。
>   9. `minimap: Toggle Split Diff` 切换小窗口对比高亮效果

```shell
apm install split-diff minimap-split-diff
```

### 让 `atom` 显示自定义风格时钟

> - `atom` 支持全屏幕编辑，但是这样就会导致编辑人员无法看到时间。
> - `atom-clock` 这款插件可以在状态栏显示时间，并且支持自定义

>   1. 进入 `atom-clock` 插件配置界面：
>   2. `Time format` 配置时间格式，推荐这种格式 `MMMM Do YYYY, dddd, h:mm:ss a`
>   3. `Locale` 配置时间显示语言， 推荐中文 `zh_CN`

```shell
apm install atom-clock
```

### 让 `atom` 支持 Vim 模式

> Vim 模式是很多程序员的最爱，本人也是其中一枚

> - `vim-mode-plus` 这是vim模式插件
> - `ex-mode` 这是基于 `vim-mode-plus` 的命令行模式
> - `relative-numbers` 这是基于 `vim-mode-plus` 相对行数
> - `ex-mode` 插件配置界面里面 勾选 `Split below` 开启 `split` 向下分割
> - `ex-mode` 插件配置界面里面 勾选 `Split right` 开启 `vsplit` 向右分割功能

```shell
apm install vim-mode-plus ex-mode relative-numbers
```

### 让 `atom` 支持 `docblockr`

> `docblockr` 是编写文档备注的辅助包，让文档备注更加直观

> - 支持自定义规范，当然这里不做详细讲解

```shell
apm install docblockr
```

### 让 `atom` 项目分类管理

> `project-viewer` 我选择这个插件做项目管理 切换项目管理栏 `Ctrl-Alt-Shift-V`

```shell
apm install project-viewer
```

### 让 `atom` 支持脚本解析

> - `script` 运行脚本插件，需要绑定对应的编译器
> - 如果你的编程语言，不容易显示编译结果，可以安装 `script`
> - 对我个人用处不大，所以我并没有安装
> - script 插件需要相应的程序配置到环境变量里面
> - js脚本，建议去官方下nodejs包安装
> - php脚本，建议环境变量绑定php7以上的版本

```shell
apm install script
```

### 让 `atom` 支持路径获取

> - `atom` 并没有自带，路径获取功能，这实在糟糕
> - `autocomplete-paths` 让 `atom` 具备了该功能，并且可以自定义

```shell
apm install autocomplete-paths
```

#### 在插件配置界面里配置

> `autocomplete-paths` 默认没有开启 HTML 文件的支持，需要手动开启 将 `Enable Html Support` 勾选上

#### 在配置文件里配置

> 虽然我们手动开启了对 HTML 支持，但是 `autocomplete-paths` 默认并不支持 `css` 文件 配置文件路径 `C:\Users\username\.atom\packages\autocomplete-paths\lib\config\option-scopes.js`

1. 修改前，第11行默认

  ```javascript
  'use babel'

  export default {
   enableHtmlSupport: [
     {
       scopes: ['text.html.basic'],
       prefixes: [
         'src=[\'"]',
         'href=[\'"]'
       ],
       extensions: ['js', 'png', 'gif', 'jpeg', 'jpg', 'tiff', 'html'],
       relative: true
     }
   ]
  }
  ```

2. 修改后,第11行变化

  ```javascript
  'use babel'

  export default {
   enableHtmlSupport: [
     {
       scopes: ['text.html.basic'],
       prefixes: [
         'src=[\'"]',
         'href=[\'"]'
       ],
       extensions: ['css', 'js', 'png', 'gif', 'jpeg', 'jpg', 'tiff', 'html'],
       relative: true
     }
   ]
  }
  ```

#### 解决 `autocomplete-paths` 路径是反斜杠问题

> - 在两台 win10 系统上测试，一台正常，一台有问题！
> - 解决方式：多安装几次

### `atom` 色彩插件

> - `color-picker` 使用快捷 `Ctrl-Alt-C` 可以展开色彩选择面板
> - `pigments` 在 html css 里面显示颜色值的颜色， 配置界面里面根据自己需求配置
> - 不重点讲解

```shell
apm install color-picker pigments
```

### `atom` 打开浏览器

> - `open-in-browser` 插件可以直接打开html页面到默认浏览器
> - 使用指令 `open in browser: open`

```shell
apm install open-in-browser
```

### 让 `atom` 自动处理 `css3` 属性前缀

> - `autoprefixer` 插件可以自动处理 `css3` 属性前缀
> - 执行指令 `autoprefixer`
> - 还可以在插件配置界面，勾选上 `run on save` 这样以保存就会自动自动 `css3` 属性前缀

```shell
apm install autoprefixer
```

### 让 `atom` 支持 `Html` 标签自动闭合

> - 这个功能 `sublime` 是自带的，但是 `atom` 需要插件
> - `autoclose-html` 这个插件可以支持 `html` 标签自动闭合
> - 在插件配置界面将 `Make Never Close Elements Self-Closing` 勾选去掉（默认勾选上的，建议去掉）
> - PS：如果不想让 `<br>` 等非闭合标签不再带有斜杠 `<br />`，可以执行上面的步骤，
> - PS：非闭合标签，带 `/` 是一个被容忍的语法错误，这种容忍是基于兼容性考虑的，它使得所有浏览器和解析器都把 `<br>` 和 `<br />` 同等对待

```shell
apm install autoclose-html
```

### 让 `atom` 支持 `emmet` 操作

> `emmet` 是当前编写 `html` 和 `css` 最有好的工具，具体请访问 `emmet` 官网

```shell
apm install emmet
```

### 让 `atom` 的 js 补全更加优秀

> `atom-ternjs` 这个插件可以让 js 本地提示更加智能、全面

> - `menu > Packages > Atom Ternjs > Configure project` 菜单下
> - 选择自己需要的组件 > 点击按钮 `Save & Restart Server`

```shell
apm install atom-ternjs
```

#### 如果 `atom-ternjs` 无法打开 `Configure project` 界面

1. 在项目根目录下新建 `.tern-project` 文件，填入以下内容：

  ```javascript
  {
   "ecmaVersion": 6,
   "libs": [],
   "loadEagerly": [],
   "dontLoad": [
     "node_modules/**"
   ],
   "plugins": {
     "doc_comment": true
   }
  }
  ```

2. `menu > Packages > Atom Ternjs > Configure project` 菜单下

3. 选择自己需要的组件

4. 点击按钮 `Save & Restart Server`

### 让 `atom` 的 php 补全更加优秀

> - `atom-autocomplete-php` 插件让 php 补全更加智能、全面
> - 功能实现依赖于 `composer` ，所以先要绑定 `composer` 路径
> - 插件配置界面 `Command to use composer` 下面填入 `composer.phar` 所在路径
> - 插件配置界面 `Command php` 下面填入 `php.exe` 所在路径
> - PS： 由于 php nodeJS 等都应该加入环境变量中，这样 `atom` 能直接找到，所以大多数插件都省略了这步操作

```shell
apm install atom-autocomplete-php
```

### 让 `atom` 下 markdown 支持同步预览

> `markdown-scroll-sync` 支持 markdown 文件同步预览

```shell
apm install markdown-scroll-sync
```

#### 修改配置文件

> 文件路径： `C:\Users\username\.atom\packages\markdown-scroll-sync\lib\utils.coffee`

1. 修改前，12行初始

  ```coffee
  lineEles = @editorView.shadowRoot.querySelectorAll '.lines .line[data-screen-row]'
  ```

2. 修改后，12行修改

  ```coffee
  lineEles = @editorView.querySelectorAll '.lines .line[data-screen-row]'
  ```

### 让 `atom` 支持代码格式化（可能会不要）

> - `atom` 本身并不支持代码格式化
> - `atom-beautify` 这个插件让 `atom` 具备格式化功能，当然它需要针对不同语言，做相应的配置
> - `atom-beautify` 格式化 php 需要绑定 `php-cs-fixer-v2.phar` 路径
> - `Executables` 命令栏下面，填写 `atom-beautify` 对应的包， `php-cs-fixer` 下面填写 `php-cs-fixer-v2.phar` 路径

```shell
apm install atom-beautify
```

### 将 `atom` 改装成 IDE

> - `atom` 是一个可以扩展的编辑器，也可以改装成 IDE
> - `atom-ide-ui` 这个插件可以将 `atom` 改装成IDE
> - `ide-php` 让 php 支持 IDE 功能
> - `ide-typescript` 让 js 支持 IDE 功能
> - `atom-ide-ui` 插件配置界面里面将 `Code Formatting`两个勾选都去掉，因为测试结果是无法格式化！
> - `atom-ide-ui` 插件配置界面里面将 `Hyperclick` 指令下面的快捷键修改成 `Shift-Control-click`，因为 `Control-click` 快捷键冲突

```shell
apm install atom-ide-ui ide-php ide-typescript
```

### 基于 `minimap` 插件的几个子插件

> 1. `minimap-bookmarks` 让 minimap 支持高亮书签
> 2. `minimap-highlight-selected` 让 minimap 支持高亮选择内容
> 3. `minimap-cursorline` 让 minimap 支持高亮当前行
> 4. `minimap-find-and-replace` 让 minimap 支持高亮搜索内容
> 5. `minimap-git-diff` 让 minimap 支持git对比高亮
> 6. `minimap-pigments` 让 minimap 支持颜色高亮
> 7. `activate-power-mode` 这是一款编辑器震动插件
> 8. `platformio-ide-terminal` 这是一款终端模拟器插件

### 关于插件的说明

> - 好用的插件不止这些，这些插件对不合适的，也未必好用，希望大家自己尝试去收集符合自己的插件
> - js 相关一般基于 nodejs ， php 相关一般都需要php7以上版本支持，其它语言的也一样的

## **`atom` 主题**

> 默认的主题已经非常优秀，如何有发现自己喜欢的也可以加入进去

```shell
apm install native-ui monokai
```

--------------------------------------------------------------------------------
