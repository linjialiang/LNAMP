# wamp组件维护

> 主要会涉及到 apache24 和 mariadb 两个软件的 `安装、卸载、启动、关闭、开机启动项` 等设置

## apache24相关

### 将apache24安装进系统服务中

> apache24服务安装到系统服务中便于管理和操作

-   加入系统变量的操作

    > -   操作前提：只安装1个阿帕奇服务
    > -   操作方法：将 bin 目录加入到系统变量 PATH 中
    > -   cmd要求：需要有管理员权限

    ```shell
    httpd.exe -k install -n <service-httpd>
    ```

-   不加入系统变量的操作

    > -   操作前提：安装多个阿帕奇服务
    > -   操作方法：进入 bin 目录后才能操作
    > -   cmd要求：需要有管理员权限

    ```shell
    httpd.exe -k install -n <service-httpd>
    ```

### 将 apache2 从系统服务中卸载

> -   方法一：使用阿帕奇自带的工具卸载
> -   方法一：使用系统工具强制删除

-   使用阿帕奇自带的工具卸载

    > -   操作前提：确保阿帕奇服务未损坏
    > -   操作方法：未加入环境变量的需要进入 bin 目录后才能操作
    > -   cmd要求：需要有管理员权限

    ```shell
    httpd.exe -k uninstall -n <service-httpd>
    ```

-   使用系统工具 `sc` 从注册表删除服务

    > -   优点1：不需要进入 bin 目录后才能操作
    > -   优点2：只要系统存在该服务，就算阿帕奇损坏了，也能正常删除
    > -   cmd要求：需要有管理员权限

    ```shell
    sc delete <service-httpd>
    ```

### 启动 apache2 服务器

> -   cmd要求：需要有管理员权限
> -   注意：阿帕奇需要安装到系统服务后才能启动

```shell
net start <service-httpd>
```

> -   默认情况：阿帕奇默认使用80和443端口，如果端口不变，系统只能开启一个阿帕奇服务
> -   修改端口：为每个阿帕奇都定义不同的空闲端口后，系统就可以开启多个阿帕奇服务
> -   端口占用：如果端口被占用也无法开启服务，需先关闭占用端口的软件，才能正常开启服务

### 关闭 apache2 服务器

> cmd要求：需要有管理员权限

```shell
net stop <service-httpd>
```

### `<service-httpd>` 属性值列表

| version | `<service-httpd>` |
| ------- | ----------------- |
| php7.2  | `apache24`        |

## mariadb相关

### 安装mariadb到系统服务

> -   前提：my.ini文件路径正确，数据库存放目录的数据未损坏
> -   情况1：my.ini 在mariadb根目录下的安装方法
> -   情况2：my.ini 不在mariadb根目录下的安装方法

1.  my.ini在mariadb根目录下

    > -   cmd：cmd需要管理员权限
    > -   操作：cmd进入bin目录，输入指令如下：

    ```shell
    mysqld.exe --install <service-mariadb>
    ```

    > `<service-mariadb>` 是自定义服务名，为空会自动命名为 `MySQL`

2.  my.ini不在mariadb根目录下

    > -   说明:默认会获取在mariadb根目录上的my.ini（假如存在）
    > -   cmd：cmd需要管理员权限 操作：cmd进入bin目录，输入指令如下：

```shell
# 指令
mysqld.exe --install <service-mariadb> --defaults-file=c:\wamp\myariadb\my.ini
```

### 卸载 mariadb 系统服务

-   用mariadb自带工具卸载

    > -   cmd：cmd需要管理员权限
    > -   操作：cmd进入bin目录，输入指令如下：

    ```shell
    mysqld.exe --remove <service-mariadb>
    ```

-   用系统 `sc` 工具从注册表删除服务

    > -   cmd：cmd需要管理员权限
    > -   `server` 是服务器地址，如果是本地可以省略

    ```shell
    sc <server> delete <service-mariadb>
    ```

### 启动 mariadb 服务

1.  安装系统服务版-启动mariadb服务

    > cmd要求：需要管理员权限

    ```shell
    net start <service-mariadb>
    ```

2.  未安装系统服务版-启动mariadb服务

    > cmd要求：需要管理员权限 操作：cmd进入bin目录，输入如下代码：

    ```shell
    mysqld.exe
    ```

    > 如果my.ini不在mariadb根目录需要如下代码：

    ```shell
    mysqld.exe --defaults-file="指定my.ini路径"
    ```

### 停止 mariadb 服务

1.  安装系统服务版-停止mariadb服务

    > cmd要求：需要管理员权限

    ```shell
    net stop <service-mariadb>
    ```

2.  未安装系统服务版-停止mariadb服务

    > cmd要求：需要管理员权限 操作：cmd进入bin目录，输入如下代码：

    ```shell
    mysqladmin.exe -uroot shutdown
    ```

    > 如果root存在密码，需要加上 `-p` ，并在出现提示时提供密码

    ```shell
    mysqladmin.exe -uroot -p shutdown
    ```

### `<service-mariadb>` 属性值一览表

| version     | `<sercice-mariadb>` |
| ----------- | ------------------- |
| mariadb10.3 | mariadb             |

## 关于如何修改系统服务启动类型

> 配置服务：不管是阿帕奇系统服务、mariadb系统服务方式都一样：

```shell
sc config <service-name> start=<set-value>
```

| `<set-value>` | 类型  | miaoshu |
| ------------- | --- | ------- |
| auto          | 自动  | 开机自动启动  |
| demand        | 手动  | 需要手动启动  |
| disabled      | 禁用  | 无法启动    |
