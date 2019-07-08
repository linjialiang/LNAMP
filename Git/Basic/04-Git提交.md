# Git 提交

## 跟踪文件

> `git add <file>...` 指令用于跟踪文件

1.  在现有目录中初始化仓库

    > 在现有目录中初始化仓库，所有文件都是未跟踪文件
    >
    > - `git add .` 可以跟踪所有未跟踪文件

    ```shell
    $ git add .
    ```

    > - `git status` 检查当前文件状态
    > - `git status --short` 检查当前文件状态的紧凑输出

    ```shell
    $ git status --short
    A  "Git Basics/1.01-Git 初始化.md"
    A  "Git Basics/1.02-绑定远程仓库.md"
    A  "Git Basics/1.03-Git 提交.md"
    A  "Git Basics/README.md"
    A  README.md
    ```

2.  克隆现有的仓库
    > 在现有目录中初始化仓库，所有文件都是已跟踪文件，状态为未修改状态

## 提交文件

> `git add` 跟踪文件后，再用 `git commit` 指令用于提交文件
> `git commit --message=<msg>` 可以直接提交，默认情况下会开启一个编辑器窗口

```shell
$ git commit --message='git 部分第一次提交'
[master (root-commit) 3ec8da7] git 部分第一次提交
 5 files changed, 221 insertions(+)
 create mode 100644 Git Basics/01-Git 初始化.md
 create mode 100644 Git Basics/02-绑定远程仓库.md
 create mode 100644 Git Basics/03-Git 提交.md
 create mode 100644 Git Basics/README.md
 create mode 100644 README.md
```

> 已修改状态的文件，通过 `git commit -a` 可以略过 `git add`，但是会提交所有已跟踪文件中状态处于已修改状态的文件

```shell
$ git commit --all --message='修改了 */git/*/03-*.md'
```

## 修改文件名

> `git mv <filename> <newfilename>` 用于移动并重命名文件及目录

```shell
$ cd Git\ Basics/
$ git mv 01-Git\ 初始化.md 1.01-Git\ 初始化.md
$ git mv 02-绑定远程仓库.md 1.02-绑定远程仓库.md
$ git mv 03-Git\ 提交.md 1.03-Git\ 提交.md

$ git status --short
R  "01-Git 初始化.md" -> "1.01-Git 初始化.md"
R  02-绑定远程仓库.md -> 1.02-绑定远程仓库.md
RM "03-Git 提交.md" -> "1.03-Git 提交.md"
```

```shell
$ git add 1.03-*.md
$ git commit --message='重命名了 3 个文件'
```
