# Git 标签

> 理解：github 上发布的每个版本都是标签！

## 标签分类

> 标签主要分： `轻量标签` 和 `附注标签`

- 附注标签

  > 附注标签是存储在 Git 数据库中的一个完整对象

- 轻量标签
  > 轻量标签本质上是将提交校验和存储到一个文件中，没有保存任何其他信息

## 创建标签

- 创建标签-附注标签

  > 指令： `git tag --annotate <tag> --message=<msg>`

  ```shell
  $ git tag --annotate v0.0.1 --message='在本地 master 分支打的标签'
  ```

- 创建标签-轻量标签

  > 指令： `git tag <tag>`

  ```shell
  $ git tag v0.0.2
  ```

- 创建标签-为指定的快照补打标签

  > 轻量标签指令： `git tag <tag> <commit id>`
  > 附注标签指令： `git tag --annotate <tag> <commit id> --message='在本地 master 分支打的标签'`

  ```shell
  $ git log --pretty=%h -3
  98b551a
  606c98d
  a5a577a
  ```

  > 为 `a5a577a` 快照打上附注标签

  ```shell
  $ git tag --annotate v0.0.3-a5a577a a5a577a --message='为 a5a577a 快照打上附注标签'
  ```

  > 为 `606c98d` 快照打上轻量标签

  ```shell
  $ git tag v0.0.3-606c98d 606c98d
  ```

## 共享标签

> 理解：就是将标签推送到远程仓库

1.  共享指定标签

    > 指令： `git push <remote-name> <tag-Regex>...`

    ```shell
    $ git push github-git v0.0.{1,2}
    Counting objects: 1, done.
    Writing objects: 100% (1/1), 198 bytes | 198.00 KiB/s, done.
    Total 1 (delta 0), reused 0 (delta 0)
    To https://github.com/linjialiang/git.git
     * [new tag]         v0.0.1 -> v0.0.1
     * [new tag]         v0.0.2 -> v0.0.2
    ```

2.  共享全部标签

    > 指令： `git push --tags`

    ```shell
    $ git push --tags
    Total 0 (delta 0), reused 0 (delta 0)
    To https://github.com/linjialiang/git.git
     * [new tag]         name -> name
     * [new tag]         show -> show
    ```

## 查看标签

1.  查看标签-标签信息

    > 指令： `git show show <tag>... --check --pretty=`

    ```shell
    $ git show v0.0.1  --check --pretty=
    tag v0.0.1
    Tagger: madnesslin <linjialiang@163.com>

    在本地 master 分支打的标签
    ```

    ```shell
    $ git show v0.0.1 v0.0.3-a5a577a  --check --pretty=
    tag v0.0.1
    Tagger: madnesslin <linjialiang@163.com>

    在本地 master 分支打的标签

    tag v0.0.3-a5a577a
    Tagger: madnesslin <linjialiang@163.com>

    为 a5a577a 快照打上标签
    ```

2.  查看标签-本地标签列表

    > 指令： `git tag --list [tag-Regex]`

    ```shell
    $ git tag --list v*
    v0.0.1
    v0.0.2
    ```

3.  查看标签-远程标签列表

    > 指令： `git ls-remote --tags [<rmeote-name>...]`

    ```shell
    $ git ls-remote --tags github-git
    f80d962160053606e5a8d16cc57ab51389737a46        refs/tags/v0.0.1
    98b551a7cc1c097653f8c70c3b0f169dc14cacc6        refs/tags/v0.0.1^{}
    36bf2b9257cba10656f17f9c534e3abf09be8e06        refs/tags/v0.0.3-a5a577a
    a5a577a94c84abca1663f0dfe8fc24543c0eb1c7        refs/tags/v0.0.3-a5a577a^{}
    ```

    > 加上 `--refs` 后， `^{}` 将不再显示

    ```shell
    $ git ls-remote --refs --tags github-git

    f80d962160053606e5a8d16cc57ab51389737a46        refs/tags/v0.0.1
    36bf2b9257cba10656f17f9c534e3abf09be8e06        refs/tags/v0.0.3-a5a577a
    ```

## 删除标签

1.  删除标签-本地标签

    > 指令： `git tag --delete <tag>...`

    ```shell
    $ git tag --delete show v0.0.3-a5a577a v0.0.4-606c98d
    Deleted tag 'show' (was 98b551a)
    Deleted tag 'v0.0.3-a5a577a' (was 36bf2b9)
    Deleted tag 'v0.0.4-606c98d' (was 606c98d)
    ```

2.  删除标签-远程标签

    > 指令： `git push <remote-name> --delete <tag|branch>...`

3.  删除标签-清除本地有，但是远程没有的标签

    > - 指令 1-删除本地所有标签： `git tag --list | xargs.exe git tag --delete`
    > - 指令 2-抓取远程所有标签到本地： `git pull [<remote-name>] [--tags]`

    ```shell
    $ git pull github-git --tags
    From https://github.com/linjialiang/git
     * [new tag]         v0.0.1-demo2 -> v0.0.1-demo2
    Already up to date.
    ```

## 附录一：使用 git 命令将本地标签提交到远程仓库时，提示"rejected"（拒绝）解决办法

> 由于远程仓库上文件/标签做了修改，所以本地需要先 `git pull` 更新文件/标签再提交

1. `code1` : 提交标签时由于远程标签发生过变化，因此报错了？

```
$ git push --tags linjialiang-github
Total 0 (delta 0), reused 0 (delta 0)
To https://github.com/linjialiang/tp5-core.git
 * [new tag]           v5.1.26 -> v5.1.26
 ! [rejected]          v5.0.21 -> v5.0.21 (already exists)
 ! [rejected]          v5.1.24 -> v5.1.24 (already exists)
 ! [rejected]          v5.1.25 -> v5.1.25 (already exists)
error: failed to push some refs to 'https://github.com/linjialiang/tp5-core.git'
hint: Updates were rejected because the tag already exists in the remote.
```

2. `code2` : 先使用 `git pull` 更新本地标签库
   > 标签更新使用 `git pull --tags <remote-name>`

```
$ git pull --tags linjialiang-github
From https://github.com/linjialiang/tp5-core
 t [tag update]        v5.0.21    -> v5.0.21
 t [tag update]        v5.1.24    -> v5.1.24
 t [tag update]        v5.1.25    -> v5.1.25
You asked to pull from the remote 'linjialiang-github', but did not specify
a branch. Because this is not the default configured remote
for your current branch, you must specify a branch on the command line.
```

> 这样就解决了 `! [rejected]` 问题，接下来就正常操作！
