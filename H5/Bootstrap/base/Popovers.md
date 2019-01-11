# Popovers - 弹出层组件

> 弹出层组件向站点上的任何元素添加弹出窗口形式的引导说明(如 iOS 中的弹出窗口)

## 适用对象

> 弹出层组件适用于任何元素，我们经常应用于 `<button> & <a>` 这两个元素

## 弹出层组件，必须的 js 代码

> `Popovers 组件` 必须要有这样一段 js 代码：

```js
$(function() {
  $().popover({
    // 这里输入弹出层公用代码
  });
});
```

## 弹出层组件属性说明

> 弹出层组件属性支持两种写法：

| 属性写法 | 作用域                                     |
| -------- | ------------------------------------------ |
| `data-*` | 直接写入元素中(`title`属性不需要加`data-`) |
| `*`      | 在 js 中定义，一般都是定义公共信息         |

```html
<!-- 直接写入元素 -->
<button type="button" class="btn btn-primary" title="这是标题" data-content="这是内容">一个弹出层</button>
<button type="button" class="btn btn-primary" title="这是标题">一个弹出层</button>
```

```js
$(function() {
    $().popover({
        // 这里输入弹出层公用代码
        content: '这是默认内容',
        delay: {"show": 500, "hide": 300},
    });
});
```

> 常用属性表：

| 属性        | 属性值选项                        | 默认值    | 描述                       |
| ----------- | --------------------------------- | --------- | -------------------------- |
| `animation` | 布尔值                            | true      | 淡入淡出弹出层             |
| `container` | `string|元素|false`               | false     | 将弹出窗口附加到特定元素   |
| `delay`     | `数值|对象`                       | 0         | 延迟弹出层的显示和隐藏时间 |
| `placement` | `auto|top|bottom|left|right|函数` | `'right'` | 定义弹出层方向             |
| `title`     | 字符串                            | `''`      | 弹出层标题                 |
| `trigger`   | `click|hover|focus|manual`        | `'click'` | 弹出层的触发事件           |

### 弹出层样式模板

> 弹出层的样式是预先定义好的（可以通过 `template & data-template` 属性自定义）

```html
<div class="popover" role="tooltip">
    <div class="arrow"></div>
    <h3 class="popover-header"></h3>
    <div class="popover-body"></div>
</div>
```

> 模板元素概要：

| 模板元素          | 作用域 | 描述                                           |
| ----------------- | ------ | ---------------------------------------------- |
| `.popover`        | 父级   | 组件基类                                       |
| `.arrow`          | 子级   | 组件箭头样式                                   |
| `.popover-header` | 子级   | 组件的标题，对应 `title` 属性                  |
| `.popover-body`   | 子级   | 组件的内容，对应 `content & data-content` 属性 |
