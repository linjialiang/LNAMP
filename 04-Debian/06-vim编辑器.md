# vim 编辑器

> vim 是 linux 终端下最佳的编辑器，下面我们开始安装并配置它

## 安装 vim

> 我们可以直接使用 Debian 源上已经编译好的 vim 包，这样我们就不必要自己编译了

```shell
$ apt-get update
$ apt-get dist-upgrade
$ apt install vim ctags vim-scripts
```

## 配置 vim

> vim 的基础配置文件位于 `/etc/vim/vimrc`

```vimrc
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
```

> 基础配置文件有加载了一个子配置文件 `vimrc.local`，我们只需要修改自配置文件即可：

```shell
$ touch /etc/vim/vimrc.local
$ vim /etc/vim/vimrc.local
```

```vimrc
syntax enable
set cursorline
set autoindent
set smartindent
filetype plugin indent on
set nowrap
set encoding=utf8
set fileencodings=ucs-bom,utf8,prc,default,latin1
language messages zh_CN.utf-8
set fileformat=unix
set fileformats=unix,dos,mac
set laststatus=2
set cmdheight=1
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set scrolloff=999
inoremap <C-c> <Esc>
set relativenumber number
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber number
autocmd BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)
set foldmethod=indent
set foldcolumn=1
set foldlevelstart=99
let $za='za'
nnoremap <Space> $za
```

> 提示：如果远程 ssh 希望在 vim 页面复制内容，需要临时设置 `:set mouse=c`，因为在 `vimrc` 文件中设置无效!

## 为 vim 安装中文版帮助手册

> 使用前，让我们先感谢翻译 vim 帮助手册的大神吧！

```shell
$ mkdir -p /data/source/vimcdoc
$ cd /data/source/vimcdoc
$ wget https://github.com/yianwillis/vimcdoc/releases/download/v2.1.0/vimcdoc-2.1.0.tar.gz --no-check-certificate
$ tar zxvf vimcdoc-2.1.0.tar.gz
$ cd vimcdoc-2.1.0
$ ./vimcdoc.sh -i
```
