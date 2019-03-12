<!--
+===============================================================================
| @Author: madnesslin(地上马)
+===============================================================================
| @Phone: +86 13695746767
+===============================================================================
| @Date: 2019-03-11 21:56:33
+===============================================================================
| @Email: linjialiang@163.com
+===============================================================================
| @Last modified time: 2019-03-12 14:39:26
+===============================================================================
-->

# <center>《PHP 开发者眼中的 ATOM》</center>

## atom 推荐字体

> - `hack, '思源宋体 CN'` (size=>14)

## atom 基本配置

| 序号                      | 打开 settings 方式    |
| ------------------------- | --------------------- |
| 快捷键开启方式            | `ctrl-,`              |
| `ctrl-shift-p` 开启方式： | `settings view: open` |

| 文件                | 作用描述                         |
| ------------------- | -------------------------------- |
| `.atom\config.cson` | 用户及插件配置信息都会在这里记录 |
| `.atom\keymap.cson` | 所有自定义快捷键都会在这里记录   |
| `.atom\styles.less` | 所有自定义样式都会在这里记录     |

---

## atom 扩展主题

| atom 扩展主题(2)           | 主题描述              |
| -------------------------- | --------------------- |
| `notepad-plus-plus-syntax` | `notepad++` 默认主题  |
| `atom-material-syntax`     | atom 下载量最高的主题 |

## atom 扩展插件

| 实用插件(12)                | 插件描述                  |
| --------------------------- | ------------------------- |
| `atom-beautify`             | 格式化源代码              |
| `docblockr`                 | 用于注释                  |
| `sync-settings`             | atom 配置同步插件         |
| `highlight-selected`        | 选择高亮                  |
| `split-diff`                | 文件对比插件              |
| `project-manager`           | 项目管理                  |
| `platformio-ide-terminal`   | atom 下出色的终端         |
| `markdown-preview-enhanced` | markdown 预览             |
| `file-header`               | 文件头信息                |
| `regex-railroad-diagram`    | 正则表达式,以图形直观展示 |
| `file-icons`                | 文件图标                  |
| `ftp-remote`                | ftp/sftp                  |

| git 相关插件(3)        | 插件描述                                   |
| ---------------------- | ------------------------------------------ |
| `git-time-machine`     | 近期提交的时间列表，并支持与当前内容做对比 |
| `merge-conflicts`      | 解决 Atom 中的 Git 合并冲突                |
| `tree-view-git-status` | 目录树里显示 Git 状态                      |

| minimap 相关插件(8)          | 插件描述                |
| ---------------------------- | ----------------------- |
| `minimap`                    | 代码小窗口              |
| `minimap-bookmarks`          | 代码小窗口-书签高亮     |
| `minimap-cursorline`         | 代码小窗口-当前行高亮   |
| `minimap-find-and-replace`   | 代码小窗口-搜索高亮     |
| `minimap-git-diff`           | 代码小窗口-git 对比高亮 |
| `minimap-highlight-selected` | 代码小窗口-选择高亮     |
| `minimap-selection`          | 代码小窗口-选择块高亮   |
| `minimap-split-diff`         | 代码小窗口-对比高亮     |

| 语法相关插件(2)  | 插件描述               |
| ---------------- | ---------------------- |
| `language-nginx` | nginx 配置文件语法高亮 |
| `language-ini`   | ini 扩展文件语法高亮   |

| Linter(6)           | Linter 插件       |
| ------------------- | ----------------- |
| `linter`            | Linter 基础包     |
| `intentions`        | Linter 显示基础包 |
| `linter-ui-default` | Linter 界面       |
| `busy-signal`       | Linter 信号       |
| `linter-php`        | php 包            |
| `linter-jshint`     | js 包             |

| html 相关插件(5)  | 插件描述                  |
| ----------------- | ------------------------- |
| `autoprefixer`    | css3 后缀自动完成         |
| `open-in-browser` | html 页面从默认浏览器打开 |
| `color-picker`    | 颜色选择                  |
| `pigments`        | css 下显示真实颜色        |
| `emmet`           | 前端神器                  |

| vim 相关插件(3)    | 插件描述                   |
| ------------------ | -------------------------- |
| `vim-mode-plus`    | vim 插件基础包             |
| `relative-numbers` | vim 普通模式下显示先对行号 |
| `ex-mode`          | atom 下的 ex 单行编辑器    |

---

> config.cson 文件

```cson
"*":
  "atom-beautify":
    css:
      default_beautifier: "Prettier"
    executables:
      "php-cs-fixer":
        path: ""
    general:
      _analyticsUserId: ""
    html:
      preserve_newlines: false
    js:
      default_beautifier: "Prettier"
      object_curly_spacing: true
      preserve_newlines: false
      space_before_conditional: false
    markdown:
      default_beautifier: "Prettier"
    php:
      allow_risky: "yes"
  autoprefixer:
    runOnSave: true
  autosave:
    enabled: true
  "color-picker":
    abbreviateValues: true
    alphaChannelAlways: true
    automaticReplace: true
    triggerKey: "K"
  core:
    autoHideMenuBar: true
    closeDeletedFileTabs: true
    disabledPackages: [
      "markdown-preview"
    ]
    packagesWithKeymapsDisabled: [
      "markdown-preview-enhanced"
    ]
    telemetryConsent: "limited"
    themes: [
      "one-dark-ui"
      "atom-material-syntax"
    ]
    uriHandlerRegistration: "always"
  docblockr:
    auto_add_method_tag: true
    c_style_block_comments: true
    deep_indent: true
    development_mode: true
    extra_tags_go_after: true
    lower_case_primitives: true
    newline_after_block: true
    override_js_var: true
    per_section_indent: true
    short_primitives: true
    simple_mode: true
  editor:
    fontFamily: "hack, '思源宋体 CN'"
    showIndentGuide: true
    showInvisibles: true
    softWrap: true
    softWrapAtPreferredLineLength: true
    tabLength: 4
    tabType: "soft"
  "exception-reporting":
    userId: ""
  "file-header":
    autoAddingHeaderOnNewFile: false
    autoAddingHeaderOnSaving: false
    configDirPath: ""
    dateTimeFormat: "YYYY-MM-DD HH:mm:ss"
    email: ""
    ignoreListForAutoUpdateAndAddingHeader: [
      ""
    ]
    numOfEmptyLinesAfterNewHeader: 0
    realname: ""
  "line-ending-selector":
    defaultLineEnding: "LF"
  "linter-jshint": {}
  "linter-ui-default": {}
  "markdown-preview-enhanced":
    codeBlockTheme: "coy.css"
    openPreviewPaneAutomatically: false
    previewTheme: "solarized-light.css"
    revealjsTheme: "solarized.css"
  "merge-conflicts": {}
  minimap:
    plugins:
      bookmarks: true
      bookmarksDecorationsZIndex: 0
      cursorline: true
      cursorlineDecorationsZIndex: 0
      "find-and-replace": true
      "find-and-replaceDecorationsZIndex": 0
      "git-diff": true
      "git-diffDecorationsZIndex": 0
      "highlight-selected": true
      "highlight-selectedDecorationsZIndex": 0
      selection: true
      selectionDecorationsZIndex: 0
      "split-diff": true
      "split-diffDecorationsZIndex": 0
  "one-dark-ui":
    tabCloseButton: "Left"
    tabSizing: "Maximum"
  "one-light-ui":
    tabCloseButton: "Left"
    tabSizing: "Maximum"
  "platformio-ide-terminal":
    core:
      shell: ""
      workingDirectory: "Active File"
    style:
      theme: "solarized-dark"
    toggles:
      autoClose: true
  "project-manager":
    alwaysOpenInSameWindow: true
    includeGitRepositories: true
    showPath: false
    sortBy: "group"
  "remote-ftp":
    beta: {}
    connector:
      autoUploadOnSave: "only when connected"
    context: {}
    dev: {}
    statusbar:
      enable: true
    tree:
      showViewOnStartup: false
  "spell-check":
    useLocales: false
  "sync-settings":
    _lastBackupHash: ""
    extraFiles: [
      ".apmrc"
      "config.cson"
      "github.cson"
      "projects.cson"
    ]
    gistId: ""
    personalAccessToken: ""
    quietUpdateCheck: true
    removeObsoletePackages: true
  "tree-view-git-status":
    gitFlow:
      display_type: 2
  welcome:
    showOnStartup: false
```

---

## 终端下对 `atom` 插件管理

| 说明     | 指令                                             |
| -------- | ------------------------------------------------ |
| 安装插件 | `apm install package1 [package2 package3 ...]`   |
| 卸载插件 | `apm uninstall package1 [package2 package3 ...]` |
| 移除插件 | `apm remove package1 [package2 package3 ...]`    |
| 禁用插件 | `apm disable package1 [package2 package3 ...]`   |
| 启用插件 | `apm enable package1 [package2 package3 ...]`    |

## 插件配置说明

### `project-manager` 配置

> `project-manager` 可以很好的管理我们的项目,更重要的是它可以让每个项目开启不同的插件组合

> 提示：事实上 project-manager 控制插件是不明智，因为 atom 首先会全部加载所有插件，然后再由 project-manager 开启 `devMode` 模式来禁用一些插件！

| 属性设置   | 属性值类型 | 描述                                                                        | 默认值                 |
| ---------- | ---------- | --------------------------------------------------------------------------- | ---------------------- |
| `title`    | 字符串     | 项目标题。在项目列表中展示                                                  | `''`                   |
| `paths`    | 数组       | 树视图中的所有文件夹。首个路径作为项目的主要路径。                          | `[]`                   |
| `settings` | 对象       | 特定于项目的设置。支持 `config.cson` 内容                                   | `{}`                   |
| `icon`     | 字符串     | 显示在项目列表中的图标                                                      | `'icon-chevron-right'` |
| `devMode`  | 布尔值     | `true` 为开发模式                                                           | `false`                |
| `group`    | 字符串     | 将一个组添加到可用于对项目进行分组和筛选的项目列表中                        | `null`                 |
| `template` | 字符串     | 模板是 `projects.cson` 文件中没有配置路径的项目，所有项目共享这个模板的配置 | `null`                 |

> 常规案例：

```cson
[
    {
      title: 'Project Manager1'
      group: 'Atom'
      paths: [
        '/path/to/project-manager-1'
      ]
      icon: 'atom-icon'
      color: '#8892BF'
      devMode: ture
    }
    {
      title: 'Project Manager2'
      group: 'github'
      paths: [
        '/path/to/project-manager-2'
      ]
      icon: 'github-icon'
      color: 'green'
    }
]
```

> `icon` 的属性值，可以直接使用 `file-icons` 插件（700 多个图标）设置，如：

| 案例                  | 描述        |
| --------------------- | ----------- |
| `icon: 'atom-icon'`   | atom 图标   |
| `icon: 'git-icon'`    | git 图标    |
| `icon: 'github-icon'` | github 图标 |
| `icon: 'code-icon'`   | 代码图标    |
| `icon: 'psd-icon'`    | psd 图标    |
| `icon: 'php-icon'`    | php 图标    |


## `.apmrc` 配置

> `.apmrc` 文件用来让 `atom` 支持终端代理

`.apmrc` 文件路径： `.atom\.apmrc`

```shell
strict-ssl = false
http-proxy = http://127.0.0.1:1080
https-proxy = http://127.0.0.1:1080
```

---
