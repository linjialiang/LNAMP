# Dropdowns 组件

> 下拉菜单，主要应用于 `<a> & <button>`

| 元素                      | 描述                                                            |
| ------------------------- | --------------------------------------------------------------- |
| `.dropdown`               | 基础，菜单向下                                                  |
| `.dropup`                 | 基础，菜单向上                                                  |
| `.dropright`              | 基础，菜单向右                                                  |
| `.dropleft`               | 基础，菜单向左                                                  |
| `.dropdown-toggle`        | 点击事件元素的类， 可以是 `<a> & <button>`                      |
| `.dropdown-menu`          | 下拉元素的父元素类                                              |
| `.dropdown-item`          | 下拉元素类， 可以是 `<a> & <button>`                            |
| `.dropdown-header`        | 在任何下拉菜单中添加标题来标记操作的各个部分。                  |
| `.dropdown-item-text`     | 非交互式下拉项                                                  |
| `.active`                 | 下拉元素类，使该项处于活动背景色                                |
| `.disabled & disabled`    | 下拉元素类，使该项处于禁用状态，`<a> & <button>` 的定义方式不同 |
| `dropdown-divider`        | 使用分隔符分隔相关菜单项的组。                                  |
| `data-offse`              | 改变下拉菜单的偏移量，如：`data-offset="10,20"`                 |
| `data-display="static"`   | 点击事件元素类，响应式对齐                                      |
| `.dropdown-menu-right`    | 下拉元素父元素，向按钮右侧对齐                                  |
| `.dropdown-menu-left`     | 下拉元素父元素，向按钮左侧对齐                                  |
| `.dropdown-menu-sm-left`  | 下拉元素父元素，指定宽度屏幕，向按钮左侧对齐                    |
| `.dropdown-menu-md-left`  | 下拉元素父元素，指定宽度屏幕，向按钮左侧对齐                    |
| `.dropdown-menu-lg-right` | 下拉元素父元素，指定宽度屏幕，向按钮右侧对齐                    |
| `.dropdown-menu-xl-right` | 下拉元素父元素，指定宽度屏幕，向按钮右侧对齐                    |

> PS：除此之外，还有 js 方法和事件，以及其他嵌入操作，如表单嵌入等...

## 案例1：简单的下拉菜单

```html
<div class="container mt-3">
    <div class="dropdown">
        <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown"><i class="badge badge-warning">按钮</i> 下拉菜单</button>
        <div class="dropdown-menu">
            <button class="dropdown-item" href="#">可以是按钮</button>
            <button class="dropdown-item active" href="#">添加了 .active 类</button>
            <a class="dropdown-item" href="#">也可以是a链接</a>
        </div>
    </div>
    <div class="dropright mt-2">
        <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown"><i class="badge badge-warning">a链接</i> 下拉菜单</button>
        <div class="dropdown-menu">
            <h3 class="dropdown-header" href="#">按钮方向向右</h3>
            <a class="dropdown-item disabled" href="#">禁用该项-a方法</a>
            <button class="dropdown-item" disabled href="#">禁用该项-按钮方法</button>
            <div class="dropdown-divider"></div>
            <h3 class="dropdown-header" href="#">头部2</h3>
            <a class="dropdown-item" href="#">头部1和头部2之间使用了分割线</a>
        </div>
    </div>
</div>
<script src="/static/base/js/jquery.min.js"></script>
<script src="/static/base/js/bootstrap.bundle.min.js"></script>
```
