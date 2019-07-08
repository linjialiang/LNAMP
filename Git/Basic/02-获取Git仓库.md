# 获取 Git 仓库

> 有两种取得 Git 项目仓库的方法：

```text
- 第一种是在现有项目或目录下导入所有文件到 Git 中；
- 第二种是从一个服务器克隆一个现有的 Git 仓库。
```

## 在现有目录中初始化仓库

1.  确认项目位置

    > 我们创建一个目录 `D:/test/`

    ```shell
    $ mkdir /d/test
    $ cd /d/test
    ```

2.  初始化 Git 本地仓库

    > `git init` 指令可以初始化 Git：

    ```shell
    $ git init
    Initialized empty Git repository in D:/test/.git/
    ```

## 克隆现有的仓库

```text
- 远程仓库地址： https://gitee.com/linjialiang/test.git
- 操作指令：： git clone [远程仓库地址] <本地仓库目录名>
```

> 具体操作如下：

```shell
$ git clone https://gitee.com/linjialiang/test.git test
Cloning into 'test'...
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
```

> 提示：如果 `本地仓库目录名` 省略不写，本地仓库会跟远程仓库名一致：
