# **vim 简明手册**

> vim 是 linux 下最实用的文本编辑工具，终端下并不需要自己配置插件，主要是优化下界面

## **安装 vim**

```shell
# apt-get install vim vim-scripts
```

## **安装 vim中文帮助包**

> 如果你英文水平有限，也可以安装个中文帮助

### 下载 vim中文帮助包

- http 方式下载

  ```shell
  # wget http://github.com/yianwillis/vimcdoc/releases/download/v2.1.0/vimcdoc-2.1.0.tar.gz
  ```

- https 方式下载

  ```shell
  # wget --no-check-certificate https://github.com/yianwillis/vimcdoc/releases/download/v2.1.0/vimcdoc-2.1.0.tar.gz
  ```

### 解压与安装 vim中文帮助包

```shell
# tar -xzvf vimcdoc-2.1.0.tar.gz
# cd vimcdoc-2.1.0
# ./vimcdoc.sh -i  ## 安装 与英文版本共存
# ./vimcdoc.sh -I  ## 安装 替换英文版本
```

### 卸载 vim中文帮助包

```shell
# cd /usr/share/doc/vimcdoc
# ./vimcdoc.sh -u  ## 卸载
```

## **vim配置文件**

> ms下的vim配置也适用

### 配置文件位置

#### _linux 下的配置文件_

- linux 下vim主配置文件 `/etc/vim/vimrc`
- linux 下vim用户配置文件 `~/.vimrc`

#### _ms 下的配置文件_

- ms 下就一个配置文件 `C:\Program Files (x86)\Vim\_vimrc`

## **配置vimrc及其说明**

```shell
syntax enable                                       " 开启高亮
set cursorline                                      " 当前行高亮
set cursorcolumn                                    " 当前列高亮
set autoindent                                      " 自动缩进，即为新行自动添加与当前行同等的缩进
set smartindent                                     " 开启新行时使用智能自动缩进。适用于 C 这样的程序，类似cindent，多数情况下比cindent更好
filetype plugin indent on                           " 自动检测文件格式、插件支持、缩进
set nowrap                                          " 开启不自动换行（默认 wrap）
set encoding=utf8                                   " 默认编码格式 utf-8
set fileencodings=ucs-bom,utf8,prc,default,latin1   " 支持的编码格式
language messages zh_CN.utf-8                       " 指定consle消息用中文uft-8显示（服务器默认是英文界面）
set fileformat=unix                                 " 换行符默认unix模式
set fileformats=unix,dos,mac                        " 换行符支持Unix dos mac 3种模式
set laststatus=2                                    " 开启状态栏信息，默认为1，可以设为2
set cmdheight=1                                     " 命令行的高度，默认为1，可以设为2
set tabstop=2                                       " 编辑时一个TAB字符占多少个空格的位置(默认为8空格)
set softtabstop=2                                   " <Tab>键、<BS>退格键（backspace）每次前进或删除的空格数、插入模式下<C-T>、<C-D>每次相对行首前进或后退的空格数(默认为8空格)
set shiftwidth=2                                    " (自动)缩进使用的空格数(默认为8空格)
set expandtab                                       " 是否(noexpandtab/expandtab)将输入<Tab>时自动展开成空格。开启后要输入<Tab>，需要<C-V><TAB> (默认为 noexpandtab )
set smarttab                                        " （需要开启expandtab才有意义）开启时，<Tab><BS>将加入或删除 shiftwidth 个空格，插入模式下<C-T>、<C-D>每次相对行首前进或后退的空格数（默认为 nosmarttab ）
set scrolloff=999                                   " 光标上下两侧最少保留的屏幕行数(999光标始终位于编辑器屏幕中间，默认为 0)

" set showcmd                                       " 在屏幕最后一行显示（部分的）命令。（ms-win32下已经开启）
" set ruler                                         " 标尺。显示光标位置的行号和列号，都好分割（ms-win32下已经开启）

set foldmethod=indent                               " 折叠方式
set foldcolumn=1                                    " 在窗口左侧显示，1列指示折叠的打开和关闭的界面(默认为0，不显示)
set foldlevelstart=99                               " 打开文件时的折叠状态（0 关闭所有折叠，1 关闭部分折叠，99 开始不折叠， 默认 -1）
let $za='za'                                        " 定义变量$za为 <z> <a> 组合键
nnoremap <Space> $za                                " <Space> 映射成 折叠与展开

" set showtabline=1                                 " 开启标签栏（0永远不会，1至少两个标签，2永远会，默认 1）

inoremap <C-c> <ESC>                                " <C-c> 映射成 <Esc>

" 普通模式下使用相对行号
set relativenumber number
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber number

" 普通模式使用相对行号（只支持GUI）
" set relativenumber number
" autocmd FocusGained * :set norelativenumber number
" autocmd FocusLost * :set relativenumber number

" 启用每行超过80列的字符提示（字体变蓝并加下划线），不启用就注释掉
autocmd BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)

" 括号自动补全（我不用，推荐使用auto-pairs插件替代）
" inoremap ( ()<Left>
" inoremap [ []<Left>
" inoremap { {}<Left>
" inoremap ' ''<Left>
" inoremap " ""<Left>
" inoremap ` ``<Left>

" 删除左括号同时删除右括号及括号里的内容（我不用，推荐使用auto-pairs插件替代）
" function! RemovePairs()
"     let l:line = getline(".")
"     let l:previous_char = l:line[col(".")-1]
"     if index(["(", "[", "{"], l:previous_char) != -1
"         let l:original_pos = getpos(".")
"         execute "normal %"
"         let l:new_pos = getpos(".")
"         if l:original_pos == l:new_pos
"             execute "normal! a\<BS>"
"             return
"         end
"         let l:line2 = getline(".")
"
"         if len(l:line2) == col(".")
"             execute "normal! v%xa"
"         else
"             execute "normal! v%xi"
"         end
"     else
"         execute "normal! a\<BS>"
"     end
" endfunction
" inoremap <BS> <ESC>:call RemovePairs()<CR>a
" inoremap <C-h> <ESC>:call RemovePairs()<CR>a

" 在括号补全后，输入右括号，不会增加括号，并移动到右括号右侧 （我不用，推荐使用auto-pairs插件替代）
" function! RemoveNextDoubleChar(char)
"     let l:line = getline(".")
"     let l:next_char = l:line[col(".")] "
"     if a:char == l:next_char
"         execute "normal! l"
"     else
"         execute "normal! i" . a:char . ""
"     end
" endfunction
" inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
" inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
" inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a

if has("gui_running")
    " 不启用鼠标（gvim默认为a，vim默认为空）
    set mouse=

    " 不执行系统菜单脚本 "$VIMRUNTIME/menu.vim"
    set guioptions=M

    " 启用鼠标并执行系统菜单脚本时解决中文菜单乱码问题（gui）
    " source $VIMRUNTIME/delmenu.vim
    " set langmenu=zh_CN.utf-8
    " source $VIMRUNTIME/menu.vim

    " 设置窗口大小 高度35行 宽度120个字符
    set lines=35 columns=120

    " 设置英文、中文为不同字体（ms-gui）
    set guifont=DejaVu_Sans_Mono:h12
    set guifontwide=Microsoft_YaHei_Mono:h12

    " 设置英文、中文为不同字体（unix_gui）
    " set guifont=DejaVu\ Sans\ Mono\ h12
    " set guifontwide=Microsoft\ YaHei\ Mono\ h12
else
    " 解决终端中文乱码（常用于linux服务器）
    set termencoding=prc
endif

" 需要目录管理插件[nerdtree]支持，使用快捷键<C-\>即可打开目录管理插件
nnoremap <C-\> :NERDTreeToggle<CR>

" {{{ 需要全屏插件[gvimfullscreen.dll]支持，将其复制到gvim.exe相同目录下即可（针对ms-GUI）
" 普通模式按 <F11> 全屏切换
" 普通模式 Shift + t 降低窗口透明度
" 普通模式 Shift + y 加大窗口透明度
" 普通模式 Shift + r 切换Vim是否总在最前面显示
if has('gui_running') && has('gui_win32') && has('libcall')
    let g:MyVimLib = 'gvimfullscreen.dll'
    function! ToggleFullScreen()
        "let s:IsFullScreen = libcallnr("gvimfullscreen.dll", 'ToggleFullScreen', 0)
        "let s:IsFullScreen = libcallnr("gvimfullscreen.dll", 'ToggleFullScreen', 27 + 29*256 + 30*256*256)
        call libcall(g:MyVimLib, 'ToggleFullScreen', 27 + 29*256 + 30*256*256)
    endfunction

    let g:VimAlpha = 245
    function! SetAlpha(alpha)
        let g:VimAlpha = g:VimAlpha + a:alpha
        if g:VimAlpha < 180
            let g:VimAlpha = 180
        endif
        if g:VimAlpha > 255
            let g:VimAlpha = 255
        endif
        call libcall(g:MyVimLib, 'SetAlpha', g:VimAlpha)
    endfunction

    let g:VimTopMost = 0
    function! SwitchVimTopMostMode()
        if g:VimTopMost == 0
            let g:VimTopMost = 1
        else
            let g:VimTopMost = 0
        endif
        call libcall(g:MyVimLib, 'EnableTopMost', g:VimTopMost)
    endfunction
    "映射 F11 切换全屏vim
    map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
    "切换Vim是否在最前面显示
    map <s-r> <esc>:call SwitchVimTopMostMode()<cr>
    "增加Vim窗体的不透明度
    map <s-t> <esc>:call SetAlpha(10)<cr>
    "增加Vim窗体的透明度
    map <s-y> <esc>:call SetAlpha(-10)<cr>
    "Vim启动的时候自动调用 InitVim 以去除Vim的白色边框
    autocmd GUIEnter * call libcallnr(g:MyVimLib, 'InitVim', 0)
    " 默认设置透明
    autocmd GUIEnter * call libcallnr(g:MyVimLib, 'SetAlpha', g:VimAlpha)
endif
" }}}
```

## **vim 操作指南**

```shell
" ========================================================
"                       vim 操作指南
" ========================================================
" PS: 插入模式下的实用快捷键
    " <C-j> 回车，相当于<CR>
    " <C-h> 删除前一个字符，相当于<BS>
    " <C-w> 删除前一个单词
    " <C-u> 删除至行首
    " <C-t> 增加缩进
    " <C-d> 减少缩进
    " <C-y> 复制上一行的相同列的字符
    " <C-e> 复制下一行的相同列的字符
    " <C-x> <C-o> 补全类型为全能（Omni）补全
        " <C-p> 在补全列表中反向选择
        " <C-n> 在补全列表中正向选择

" PS: 普通模式下的指令
    " ga 显示光标下字符的ascii值
    " g8 显示光标下字符（假定其为 utf-8 编码） 的个字节十六进制值
    " 屏幕滚动
        " <C-e> 屏幕-向下滚屏（默认1行）
        " <C-d> 屏幕-向下滚屏（默认半屏）
        " <C-f> 屏幕-向下滚屏（默认1屏）
        " <C-y> 屏幕-向上滚屏（默认1行）
        " <C-u> 屏幕-向上滚屏（默认半屏）
        " <C-b> 屏幕-向上滚屏（默认1屏）
        " <z> <l> 屏幕-向右滚屏（默认1个字符）
        " <z> <L> 屏幕-向右滚屏（默认半屏）
        " <z> <h> 屏幕-向左滚屏（默认1个字符）
        " <z> <H> 屏幕-向左滚屏（默认半屏）
    " [count]w 正向 [count] 个单词-单词头部 （count 默认为1）
    " [count]e 正向 [count] 个单词-单词尾部
    " [count]b 反向 [count] 个单词-单词头部
    " [count]ge 反向 [count] 个单词-单词尾部
        " d[count]w 正向删除 [count] 个单词
        " d[count]b 反向删除 [count] 个单词
    " [count]x 正向删除 [count] 个字符
    " [count]X 反向删除 [count] 个字符
    " [count]D 删除光标所在的字符到行尾及其后的 [count]-1 行
    " 复制与黏贴
        " v 进入可是模式，以字符为单位选择
        " V 进入可是模式，以行为单位位择
        " y[count]w 复制 [count] 个单词
        " [count]Y, [count]yy 正向复制 [count] 行
        " [count]P 正向粘贴、循环 [count] 次
        " "+Y, "*Y, "~Y 将编辑器的文本保存 至 剪切板
        " "+[count]Y, "*[count]Y, "~[count]Y 将编辑器的文本保存 至 剪切板
        " "+p, "*p, "~p 从剪切板的文件粘贴 到 编辑器
        " "+[count]p, "*[count]p, "~[count]p 从剪切板的文件粘贴 到 编辑器
    " 分割窗口
        " <C-w> <s> 水平分割当前窗口
        " <C-w> <v> 垂直分割当前窗口
        " <C-w> <q> 关闭当前窗口
        " <C-w> <n> 打开一个新窗口(空文件)
        " <C-w> <o> 关闭除了当前窗口外的所有窗口
        " <C-w> <T> 当前窗口移动到新标签页(T要大写)
        " 切换窗口
            " <C-w> <h> 切换窗口 - 向左（小写）
            " <C-w> <j> 切换窗口 - 向下（小写）
            " <C-w> <k> 切换窗口 - 向上（小写）
            " <C-w> <l> 切换窗口 - 向右（小写）
            " <C-w> <w> 切换窗口 - 正向遍历
            " <C-w> <W> 切换窗口 - 反向遍历（W大写）
        " 移动窗口
            " <C-w> <H> 移动窗口 - 向左（大写）
            " <C-w> <J> 移动窗口 - 向下（大写）
            " <C-w> <K> 移动窗口 - 向上（大写）
            " <C-w> <L> 移动窗口 - 向右（大写）
            " <C-w> <r> 移动窗口 - 正向移动
            " <C-w> <R> 移动窗口 - 反向移动（R大写）
        " 调整窗口大小
            " <C-w> <n> <+> 调整窗口 - 增加n行高度
            " <C-w> <n> <-> 调整窗口 - 减少n行高度
            " <C-w> <n> <>> 调整窗口 - 增加n列宽度
            " <C-w> <n> <<> 调整窗口 - 减少n列宽度
            " <C-w> <=>     统一窗口 高度与宽度

" PS: 命令行模式的指令
    " 消除搜索高亮 :noh[lsearch]
    " 设置文件类型 :set typefile=php
    " 文件编码查询 :set fileencoding
    " 文件编码转换 :set fileencoding=utf8
    " 文件类型查询 :set fileformat
    " 文件类型转换 :set fileformat=unix
    " 保存并关闭 :wq
    " 强制退出 不保存 :q!
    " 新建文件名冲突， 强制替换文件文本 :w! filename
    " 新建文件名冲突， 强制替换文件文本并退出 :wq! filename
    " 标签页
        " 新建文件到新标签页 :tabedit newfilename
        " 开打文件到新标签页 :tabedit filepath/filename
        " 复制当前编辑文件到新标签页 :tab split
        " 打开帮助手册到新标签页 :tab help gt
        " gt 转到后一个标签页，末标签页则回到第一个
        " gT 转到前一个标签页，首个标签页则回到最后一个
    " 分割
        " 打开新窗口
            " 平行分割 :split, :new
            " 垂直分割 :vsplit
            " 分割窗口打开指定文件 :[split, vsplit, new] filepath/filename
        " 关闭单个分割窗口 :close, :exit
        " 关闭当前分割窗口外的所有窗口 :only[!] （当其它窗口文件有修改时加!）
        " 控制台（consle）下打开多个文件
            " gvim -o file1 file2 file3 小写o是水平分割窗口
            " gvim -O file1 file2 file3 大写O是垂直分割窗口
            " vim -o file1 file2 file3 小写o是水平分割窗口
            " vim -O file1 file2 file3 大写O是垂直分割窗口
    " 缓冲区 buffer
        " :.,$-bdelete      " 删除从当前开始到倒数第二个的缓冲区
        " :%bdelete         " 删除所有缓冲区
        " :.+,$bwipeout     " 真正删除当前缓冲区之后的所有缓冲区
        " :%bwipeout        " 真正删除所有缓冲区
    " 目录与文件名
        " 查看当前目录 :pwd
        " 查看当前文件 :file
    " 主题样式
        " 设置主题
            " :colorscheme twilight
            " :colorscheme candy
            " :colorscheme github
            " :colorscheme solarized
            " :set background=dark
            " :set background=light
    " 插件surround 操作说明
        " 替换符号 ==> cs + 所选符号 + ex命令行输入要替换的符号或标签
        "       实例 >> cs"'        cs"<div>
        " 替换标签 ==> cst + ex命令行输入要替换的符号或标签,t代指tab
        "       实例 >> cst'        cst<div>
        " 删除符号 ==> ds + ex命令行输入要删除的符号
        "       实例 >> ds"
        " 删除标签 ==> ds + ex命令行输入t
        "       实例 >>  dst
        " 添加操作 ==> ys + iw + ex命令行输入要添加的符号或标签
        "       实例 >> ysiw"       ysiw<div>
        " 添加整行操作 ==> ys + s + ex命令行输入要添加的符号或标签
        "       实例 >> yss"        yss<div>
        " 选中区域添加操作 ==> 可视模式下选中的内容 + S（大写） + ex命令行输入要添加的符号或标签
        "       实例 >> veeS"       veeS<div>
    " 插件repeat 操作说明
        " 普通模式下 按 “.” （点号），执行上一步操作，支持插件surround
    " 插件nerdtree 操作说明
        " <go> 在另一个窗口展开当前目录（unix是全目录，ms史一个盘做更目录）
        " <i> 和 <s> 水平/纵向分割窗口并打开文件
        " <t> 在标签页中打开该文件/目录（正向）
        " <T> 在标签页中打开该文件/目录（反向）
        " <p> 回到上层目录（小写）
        " <P> 回到根目录（大写）
        " <R> 重新载入目录列表（大写）
        " <K> 跳到同级第一个节点（大写）
        " <J> 跳到同级最后一个节点（大写）
        " <m> 显示文件系统菜单（ma添加 md删除 mm移动）
        " <?> 帮助
        " <q> 关闭
```

--------------------------------------------------------------------------------
