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

| 按键组合       | 描述                    | 指令                                  |
| -------------- | ----------------------- | ------------------------------------- |
| Ctrl+F         | 搜索界面                | actions.find                          |
| Ctrl+H         | 替换界面                | editor.action.startFindReplaceAction  |
| Enter          | 选中下一个匹配项        | editor.action.nextMatchFindAction     |
| Shift+Enter    | 选中上一个匹配项        | editor.action.previousMatchFindAction |
| Alt+Enter      | 选中所有匹配项          | editor.action.selectAllMatches        |
| Alt+C          | 切换区分大小写选项      | toggleFindCaseSensitive               |
| Alt+R          | 切换正则匹配选项        | toggleFindRegex                       |
| Alt+W          | 切换搜索整个单词选项    | toggleFindWholeWord                   |
| ~~Ctrl+M~~     | 切换使用 Tab 键设置焦点 | editor.action.toggleTabFocusMode      |
| ~~unassigned~~ | 切换显示空白            | toggleRenderWhitespace                |
| Alt+Z          | 切换允许换行选项        | editor.action.toggleWordWrap          |

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
