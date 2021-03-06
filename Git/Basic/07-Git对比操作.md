# Git 对比操作

> `git diff` 是 Git 的比较指令

1.  仅仅比较统计信息

    > `git diff --stat [-- <file|dir>...]`
    >
    > - 注意：没有指定文件或目录，就会会针对整个项目的对比
    > - 申明：在学习过程中，不要轻易加上 `--stat` ，它会让你看不到具体的修改内容！

    ```shell
    $ git diff --stat
     Git Basics/1.06-Git 对比操作.md | 9 +++++++++
     1 file changed, 9 insertions(+)
    ```

2.  对比-工作区与暂存区的差异

    > `git diff [-- <file|dir>...]`

    ```shell
    $ git diff --stat
     Git Basics/1.06-Git 对比操作.md | 56 +++++++++----------------------------
     1 file changed, 13 insertions(+), 43 deletions(-)
    ```

3.  对比-工作区与指定“版本、分支、标签”之间的差异

    > `git diff <commit-id|branch|tag> [-- <file|dir>...]`
    >
    > - 说明：HEAD == 当前指针指向的版本

    ```shell
    $ git diff HEAD --stat
     Git Basics/1.06-Git 对比操作.md | 2 +-
     1 file changed, 1 insertion(+), 1 deletion(-)
    ```

    ```shell
    $ git log --pretty="%h"
    $ git log --pretty=%h -2
    537a0c8
    a017377

    $ git diff a017377 --stat
     Git Basics/1.06-Git 对比操作.md | 12 +++++++++++-
     1 file changed, 11 insertions(+), 1 deletion(-)
    ```

4.  对比-暂存区与指定“版本、分支、标签”之间的差异

    > `git diff --staged <commit-id|branch|tag>`
    >
    > - HEAD == 当前指针指向的版本
    > - HEAD 是可以省略的，为了不使同学混淆，我们不会省略

    ```shell
    $ git diff --staged --stat -- ../README.md
     README.md | 3 +++
     1 file changed, 3 insertions(+)
    ```

    ```shell
    $ git diff --staged 26118c7 --stat -- 1.06-Git\ 对比操作.md ../README.md
     Git Basics/1.06-Git 对比操作.md | 69 +++++++++++++++++++++++++++++++++++++
     README.md                           |  3 ++
     2 files changed, 72 insertions(+)
    ```

5.  对比-版本、分支、标签间的差异

    > `git diff <commit-id1|branch1|tag1> <commit-id2|branch2|tag2> [-- <file|dir>...]`

    ```shell
    $ git diff v3.0.1 v3.0.2 --stat
     .../git/03-Git-Branching/3.03-分支管理.md      | 221 ++++++++++++++++++++-
     1 file changed, 216 insertions(+), 5 deletions(-)
    ```

    ```shell
    $ git diff HEAD v3.0.1 --stat
     .../git/03-Git-Branching/3.03-分支管理.md      | 221 +--------------------
     1 file changed, 5 insertions(+), 216 deletions(-)
    ```
