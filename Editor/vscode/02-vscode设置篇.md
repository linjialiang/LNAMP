# vscode 设置篇

通过自定义的设置，可以让 vscode 对我们更加友好，并且一些社区扩展也需要通过自己设置。

## 快捷键

vscode 快捷键是本篇章的重点，合理的快捷键可以让工作效力更加高效，具体如下：

### 基本编辑快捷键

| 按键组合         | 描述                       | 指令                                              |
| ---------------- | -------------------------- | ------------------------------------------------- |
| ctrl+x           | 剪切                       | editor.action.clipboardCutAction                  |
| ctrl+c           | 复制                       | editor.action.clipboardCopyAction                 |
| Ctrl+Shift+K     | 删除选中行                 | editor.action.deleteLines                         |
| Ctrl+Enter       | 向下插入一行               | editor.action.insertLineAfter                     |
| Ctrl+Shift+Enter | 向上插入一行               | editor.action.insertLineBefore                    |
| Alt+Down         | 向下移动选中行             | editor.action.moveLinesDownAction                 |
| Alt+Up           | 向上移动选中行             | editor.action.moveLinesUpAction                   |
| Shift+Alt+Down   | 向下复制选中行             | editor.action.copyLinesDownAction                 |
| Shift+Alt+Up     | 向上复制选中行             | editor.action.copyLinesUpAction                   |
| Ctrl+D           | 选中下一个匹配内容         | editor.action.addSelectionToNextFindMatch         |
| Ctrl+K Ctrl+D    | 移动到下一个匹配内容       | editor.action.moveSelectionToNextFindMatch        |
| Ctrl+U           | 撤销上一个光标操作         | cursorUndo                                        |
| Shift+Alt+I      | 将光标插入选中行的末尾     | editor.action.insertCursorAtEndOfEachLineSelected |
| Ctrl+Shift+L     | 选中页面中所有匹配的内容   | editor.action.selectHighlights                    |
| Ctrl+F2          | 选中页面中所有匹配的单词   | editor.action.changeAll                           |
| Ctrl+L           | 选中当前行                 | expandLineSelection                               |
| Ctrl+Alt+Down    | 向下选择多个光标           | editor.action.insertCursorBelow                   |
| Ctrl+Alt+Up      | 向上选中多个光标           | editor.action.insertCursorAbove                   |
| Ctrl+Shift+\     | 跳转到匹配的括号           | editor.action.jumpToBracket                       |
| Ctrl+]           | 增加缩进                   | editor.action.indentLines                         |
| Ctrl+[           | 减少缩进                   | editor.action.outdentLines                        |
| Home             | 光标回到行手               | cursorHome                                        |
| End              | 光标回到行尾               | cursorEnd                                         |
| Ctrl+End         | 光标跳到页面末尾           | cursorBottom                                      |
| Ctrl+Home        | 光标跳到页面顶部           | cursorTop                                         |
| Ctrl+Down        | 页面向下移动               | scrollLineDown                                    |
| Ctrl+Up          | 页面向上移动               | scrollLineUp                                      |
| Alt+PageDown     | 页面向下翻页               | scrollPageDown                                    |
| Alt+PageUp       | 页面向上翻页               | scrollPageUp                                      |
| Ctrl+Shift+[     | 折叠当前区域(子区域不操作) | editor.fold                                       |
| Ctrl+Shift+]     | 展开当前区域(子区域不操作) | editor.unfold                                     |
| Ctrl+K Ctrl+[    | 折叠当前区域               | editor.foldRecursively                            |
| Ctrl+K Ctrl+]    | 展开当前区域               | editor.unfoldRecursively                          |
| Ctrl+K Ctrl+0    | 折叠页面所有区域           | editor.foldAll                                    |
| Ctrl+K Ctrl+J    | 展开页面所有区域           | editor.unfoldAll                                  |
| Ctrl+K Ctrl+C    | 增加行注释                 | editor.action.addCommentLine                      |
| Ctrl+K Ctrl+U    | 减少行注释                 | editor.action.removeCommentLine                   |
| Ctrl+/           | 切换行注释                 | editor.action.commentLine                         |
| Shift+Alt+A      | 切换快注释                 | editor.action.blockComment                        |

### 单页搜索界面快捷键

| 按键组合     | 描述                    | 指令                                  |
| ------------ | ----------------------- | ------------------------------------- |
| Ctrl+F       | 搜索界面                | actions.find                          |
| Ctrl+H       | 替换界面                | editor.action.startFindReplaceAction  |
| Enter        | 选中下一个匹配项        | editor.action.nextMatchFindAction     |
| Shift+Enter  | 选中上一个匹配项        | editor.action.previousMatchFindAction |
| Alt+Enter    | 选中所有匹配项          | editor.action.selectAllMatches        |
| Alt+C        | 切换区分大小写选项      | toggleFindCaseSensitive               |
| Alt+R        | 切换正则匹配选项        | toggleFindRegex                       |
| Alt+W        | 切换搜索整个单词选项    | toggleFindWholeWord                   |
| ~~Ctrl+M~~   | 切换使用 Tab 键设置焦点 | editor.action.toggleTabFocusMode      |
| 未设置快捷键 | 切换显示空白            | toggleRenderWhitespace                |
| Alt+Z        | 切换允许换行选项        | editor.action.toggleWordWrap          |

### 语言界面快捷键

| 按键组合         | 描述                        | 指令                                       |
| ---------------- | --------------------------- | ------------------------------------------ |
| ~~Ctrl+Space~~   | 展开不全列表（冲突）        | editor.action.triggerSuggest               |
| Ctrl+Shift+Space | 触发器参数提示              | editor.action.triggerParameterHints        |
| Shift+Alt+F      | 格式化文档                  | editor.action.formatDocument               |
| Ctrl+K Ctrl+F    | 格式化选定区域              | editor.action.formatSelection              |
| F12              | 方法条状到定义处            | editor.action.revealDefinition             |
| Ctrl+K Ctrl+I    | Show Hover                  | editor.action.showHover                    |
| Alt+F12          | Peek Definition             | editor.action.peekDefinition               |
| Ctrl+K F12       | Open Definition to the Side | editor.action.revealDefinitionAside        |
| Ctrl+.           | Quick Fix                   | editor.action.quickFix                     |
| Shift+F12        | Peek References             | editor.action.referenceSearch.trigger      |
| F2               | 文件重命名                  | editor.action.rename                       |
| Ctrl+Shift+.     | Replace with Next Value     | editor.action.inPlaceReplace.down          |
| Ctrl+Shift+,     | Replace with Previous Value | editor.action.inPlaceReplace.up            |
| Shift+Alt+Right  | Expand AST Selection        | editor.action.smartSelect.expand           |
| Shift+Alt+Left   | Shrink AST Selection        | editor.action.smartSelect.shrink           |
| Ctrl+K Ctrl+X    | 去掉行尾空格                | editor.action.trimTrailingWhitespace       |
| Ctrl+K M         | 更换语言                    | workbench.action.editor.changeLanguageMode |

### 导航快捷键

| 按键组合           | 描述                 | 指令                                                   |
| ------------------ | -------------------- | ------------------------------------------------------ |
| Ctrl+T             | 显示所有符号         | workbench.action.showAllSymbols                        |
| Ctrl+G             | 跳转到指定行         | workbench.action.gotoLine                              |
| Ctrl+P             | 快速打开文件         | workbench.action.quickOpen                             |
| Ctrl+Shift+O       | 当前页面符号         | workbench.action.gotoSymbol                            |
| Ctrl+Shift+M       | 显示问题控制台       | workbench.actions.view.problems                        |
| F8                 | 转到下一个错误或警告 | editor.action.marker.nextInFiles                       |
| Shift+F8           | 转到上一个错误或警告 | editor.action.marker.prevInFiles                       |
| Ctrl+Shift+P or F1 | 显示所有命令         | workbench.action.showCommands                          |
| Ctrl+Shift+Tab     | 导航编辑器组历史记录 | workbench.action.openPreviousRecentlyUsedEditorInGroup |
| Alt+Left           | 上一级               | workbench.action.navigateBack                          |
| Alt+Left           | 返回快速输入         | workbench.action.quickInputBack                        |
| Alt+Right          | 下一集               | workbench.action.navigateForward                       |

### 编辑器/窗口管理快捷键

| 按键组合            | 描述                       | 指令                                        |
| ------------------- | -------------------------- | ------------------------------------------- |
| Ctrl+Shift+N        | 新窗口                     | workbench.action.newWindow                  |
| Ctrl+W              | 关闭窗口                   | workbench.action.closeWindow                |
| Ctrl+F4             | 关闭编辑器                 | workbench.action.closeActiveEditor          |
| Ctrl+K F            | 关闭目录                   | workbench.action.closeFolder                |
| 未设置快捷键        | 编辑器组之间的循环         | workbench.action.navigateEditorGroups       |
| Ctrl+\              | 拆分编辑器                 | workbench.action.splitEditor                |
| Ctrl+1              | 关注第 1 编辑器组          | workbench.action.focusFirstEditorGroup      |
| Ctrl+2              | 关注第 2 编辑器组          | workbench.action.focusSecondEditorGroup     |
| Ctrl+3              | 关注第 3 编辑器组          | workbench.action.focusThirdEditorGroup      |
| 未设置快捷键        | 将焦点放在左侧的编辑器组中 | workbench.action.focusPreviousGroup         |
| 未设置快捷键        | 将焦点放在右边的编辑器组中 | workbench.action.focusNextGroup             |
| Ctrl+Shift+PageUp   | 当前编辑器向左移动         | workbench.action.moveEditorLeftInGroup      |
| Ctrl+Shift+PageDown | 当前编辑器向右移动         | workbench.action.moveEditorRightInGroup     |
| Ctrl+K Left         | 将活动编辑器组向左移动     | workbench.action.moveActiveEditorGroupLeft  |
| Ctrl+K Right        | 将活动编辑器组向右移动     | workbench.action.moveActiveEditorGroupRight |
| Ctrl+Alt+Right      | 将编辑器移到下一组         | workbench.action.moveEditorToNextGroup      |
| Ctrl+Alt+Left       | 将编辑器移到前面的组中     | workbench.action.moveEditorToPreviousGroup  |

### 文件管理快捷键

| 按键组合       | 描述                             | 指令                                                   |
| -------------- | -------------------------------- | ------------------------------------------------------ |
| Ctrl+N         | 新建文件                         | workbench.action.files.newUntitledFile                 |
| Ctrl+O         | 打开文件                         | workbench.action.files.openFile                        |
| Ctrl+S         | 保存                             | workbench.action.files.save                            |
| Ctrl+K S       | 保存全部打开文件                 | workbench.action.files.saveAll                         |
| Ctrl+Shift+S   | 文件另存为                       | workbench.action.files.saveAs                          |
| Ctrl+F4        | 关闭当前文件                     | workbench.action.closeActiveEditor                     |
| 未定义快捷键   | 关闭其他文件                     | workbench.action.closeOtherEditors                     |
| Ctrl+K W       | 关闭当前编辑器组                 | workbench.action.closeEditorsInGroup                   |
| 未定义快捷键   | 关闭其它编辑器组                 | workbench.action.closeEditorsInOtherGroups             |
| 未定义快捷键   | 关闭左侧编辑器组                 | workbench.action.closeEditorsToTheLeft                 |
| 未定义快捷键   | 关闭右侧编辑器组                 | workbench.action.closeEditorsToTheRight                |
| Ctrl+K Ctrl+W  | 关闭全部打开文件                 | workbench.action.closeAllEditors                       |
| Ctrl+Shift+T   | 重新打开关闭的文件               | workbench.action.reopenClosedEditor                    |
| Ctrl+K Enter   | 保持打开（不会被其它文件替换）   | workbench.action.keepEditor                            |
| Ctrl+Tab       | 切换到下一个打开文件             | workbench.action.openNextRecentlyUsedEditorInGroup     |
| Ctrl+Shift+Tab | 切换到上一个打开文件             | workbench.action.openPreviousRecentlyUsedEditorInGroup |
| Ctrl+K P       | 复制当前文件路径                 | workbench.action.files.copyPathOfActiveFile            |
| Ctrl+K R       | 资源管理器中打开当前文件所在目录 | workbench.action.files.revealActiveFileInWindows       |
| Ctrl+K O       | 在新的 vscode 窗口中打开当前文件 | workbench.action.files.showOpenedFileInNewWindow       |
| 未定义快捷键   | Compare Opened File With         | workbench.files.action.compareFileWith                 |

### 界面显示快捷键

| 按键组合         | 描述                           | 指令                                            |
| ---------------- | ------------------------------ | ----------------------------------------------- |
| F11              | 切换全屏                       | workbench.action.toggleFullScreen               |
| Ctrl+K Z         | 禅模式开关                     | workbench.action.toggleZenMode                  |
| Escape Escape    | 离开禅模式                     | workbench.action.exitZenMode                    |
| Ctrl+=           | 放大显示                       | workbench.action.zoomIn                         |
| Ctrl+-           | 缩小显示                       | workbench.action.zoomOut                        |
| Ctrl+Numpad0     | 重置缩放                       | workbench.action.zoomReset                      |
| Ctrl+B           | 切换侧栏可见性                 | workbench.action.toggleSidebarVisibility        |
| Ctrl+Shift+E     | Show                           | Explorer / Toggle Focus workbench.view.explorer |
| Ctrl+Shift+F     | 全局搜索界面                   | workbench.view.search                           |
| ~~Ctrl+Shift+G~~ | 显示版本控制界面（被插件覆盖） | workbench.view.scm                              |
| Ctrl+Shift+D     | 显示调试界面                   | workbench.view.debug                            |
| Ctrl+Shift+X     | 显示扩展界面                   | workbench.view.extensions                       |
| Ctrl+Shift+U     | 显示输出                       | workbench.action.output.toggleOutput            |
| Ctrl+Q           | 快速打开视图                   | workbench.action.quickOpenView                  |
| Ctrl+Shift+C     | 打开系统控制台                 | workbench.action.terminal.openNativeConsole     |
| Ctrl+Shift+V     | 切换 markdown 预览             | markdown.showPreview                            |
| Ctrl+K V         | 打开 makrdow 预览到一边        | markdown.showPreviewToSide                      |
| Ctrl+\`          | 集成终端开关                   | workbench.action.terminal.toggleTerminal        |
