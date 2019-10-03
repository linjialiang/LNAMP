# vscode 设置篇

通过自定义的设置，可以让vscode对我们更加友好，并且一些社区扩展也需要通过自己设置。

## 快捷键

vscode快捷键是本篇章的重点，合理的快捷键可以让工作效力更加高效，具体如下：

> 基本编辑快捷键

| 按键组合         | 描述                     | 指令                                              |
|------------------|--------------------------|---------------------------------------------------|
| ctrl+x           | 剪切                     | editor.action.clipboardCutAction                  |
| ctrl+c           | 复制                     | editor.action.clipboardCopyAction                 |
| Ctrl+Shift+K     | 删除选中行               | editor.action.deleteLines                         |
| Ctrl+Enter       | 向下插入一行             | editor.action.insertLineAfter                     |
| Ctrl+Shift+Enter | 向上插入一行             | editor.action.insertLineBefore                    |
| Alt+Down         | 向下移动选中行           | editor.action.moveLinesDownAction                 |
| Alt+Up           | 向上移动选中行           | editor.action.moveLinesUpAction                   |
| Shift+Alt+Down   | 向下复制选中行           | editor.action.copyLinesDownAction                 |
| Shift+Alt+Up     | 向上复制选中行           | editor.action.copyLinesUpAction                   |
| Ctrl+D           | 选中下一个匹配内容       | editor.action.addSelectionToNextFindMatch         |
| Ctrl+K Ctrl+D    | 移动到下一个匹配内容     | editor.action.moveSelectionToNextFindMatch        |
| Ctrl+U           | 撤销上一个光标操作       | cursorUndo                                        |
| Shift+Alt+I      | 将光标插入选中行的末尾   | editor.action.insertCursorAtEndOfEachLineSelected |
| Ctrl+Shift+L     | 选中页面中所有匹配的内容 | editor.action.selectHighlights                    |
| Ctrl+F2          | 选中页面中所有匹配的单词 | editor.action.changeAll                           |
| Ctrl+L           | 选中当前行               | expandLineSelection                               |
| Ctrl+Alt+Down    | 向下选择多个光标         | editor.action.insertCursorBelow                   |
| Ctrl+Alt+Up      | 向上选中多个光标         | editor.action.insertCursorAbove                   |
| Ctrl+Shift+\     | 跳转到匹配的括号         | editor.action.jumpToBracket                       |
| Ctrl+]           | 增加缩进                 | editor.action.indentLines                         |
| Ctrl+[           | 减少缩进                 | editor.action.outdentLines                        |
| Home             | 光标回到行手             | cursorHome                                        |
| End              | 光标回到行尾             | cursorEnd                                         |
| Ctrl+End         | 光标跳到页面末尾         | cursorBottom                                      |
| Ctrl+Home        | 光标跳到页面顶部         | cursorTop                                         |
| Ctrl+Down        | 页面向下移动             | scrollLineDown                                    |
| Ctrl+Up          | 页面向上移动             | scrollLineUp                                      |
| Alt+PageDown     | 页面向下翻页             | scrollPageDown                                    |
| Alt+PageUp       | 页面向上翻页             | scrollPageUp                                      |
| Ctrl+Shift+[     | 折叠当前区域             | editor.fold                                       |
| Ctrl+Shift+]     | 展开当前区域             | editor.unfold                                     |
| Ctrl+K Ctrl+[    | 折叠全部区域             | editor.foldRecursively                            |
| Ctrl+K Ctrl+]    | 展开全部区域             | editor.unfoldRecursively                          |
