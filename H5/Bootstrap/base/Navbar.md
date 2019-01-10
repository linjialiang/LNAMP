# Navbar 组件

> `Bootstrap` 的 导航条组件是强大的、它能响应性显示界面效果，导航条内部支持 `下拉菜单组件`

## 导航条组件支持内容

> navbar 内置了对一些子组件的支持。根据需要从下列选择:

| 子组件                      | 描述                                           |
| --------------------------- | ---------------------------------------------- |
| `.navbar-brand`             | navbar 项目名称                                |
| `.navbar-nav`               | 用于全高度和轻量级导航(包括对下拉菜单的支持)。 |
| `.navbar-toggler`           | 用于折叠插件和其他导航切换行为。               |
| `.form-inline`              | 对于任何表单控件和操作                         |
| `.navbar-text`              | 用于添加垂直居中的文本字符串。                 |
| `.collapse.navbar-collapse` | 用于按父断点分组和隐藏导航条内容               |

## 样式表

| 样式类                      | 描述                                                  |
| --------------------------- | ----------------------------------------------------- |
| `.navbar`                   | 顶级，navbar 基本类                                   |
| `.navbar-dark`              | 顶级，定义暗系 navbar                                 |
| `.navbar-light`             | 顶级，定义亮系 navbar                                 |
| `.navbar-expand`            | 顶级，navbar 菜单栏水平布局                           |
| `.navbar-expand-sm`         | 顶级，屏幕大于指定值，`navbar菜单栏` 水平布局         |
| `.navbar-expand-md`         | 顶级，屏幕大于指定值，`navbar菜单栏` 水平布局         |
| `.navbar-expand-lg`         | 顶级，屏幕大于指定值，`navbar菜单栏` 水平布局         |
| `.navbar-expand-xl`         | 顶级，屏幕大于指定值，`navbar菜单栏` 水平布局         |
| `.navbar-brand`             | 父级，navbar 项目名称                                 |
| `.navbar-brand.navbar-text` | 父级，处理 navbar 项目名称 的文本样式                 |
| `.navbar-toggler`           | 子级，`菜单展示按钮`的样式类，用于隐藏菜单栏          |
| `.navbar-toggler-icon`      | 下级，`.navbar-toggler`下级，`菜单展示按钮`的效果样式 |
| `.navbar-collapse.collapse` | 父级，`navbar菜单栏` 的样式类，并用于隐藏菜单         |
| `.navbar-nav`               | 子级，`navbar菜单栏` 的基类                           |

## 属性表

| 属性值                    | 描述                                      |
| ------------------------- | ----------------------------------------- |
| `data-toggle="collapse"`  | 切换`navbar菜单栏`的状态（`展示 | 隐藏`） |
| `data-target="#selector"` | 为`菜单展示按钮`和`navbar菜单栏`做映射    |

> PS：一个 `菜单展示按钮` 可以与多个 `navbar菜单栏` 映射
