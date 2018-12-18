# BootStrap 的 css样式源码解析

> BootStrap 样式功能非常完整，满足各类网页开发

## 像素大小

> 所有标签都使用rem来表示像素大小，我们需要为html标签定义一个px来表示，例如：

```css
html{font-size:14px}
```

## 容器

> `bootstrap` 有两个的容器：`.container` 和 `.container-fluid`

| 容器                 | 对比     |
| ------------------ | ------ |
| `.container`       | 有最大宽度  |
| `.container-fluid` | 永远100% |

## 网格

> `bootstrap` 中的网格基本代码

```html
<div class="container-fluid">
    <div class="row">
        <div class="col">1</div>
        <div class="col">2</div>
    </div>
</div>
```

### 网格类型

> `bootstrap` 中的网格设计了很多种类型

| 网格代码     | 类型         |
| -------- | ---------- |
| col系列    | 全局网格系列     |
| col-sm系列 | 屏幕大于576px  |
| col-md系列 | 屏幕大于768px  |
| col-lg系列 | 屏幕大于992px  |
| col-xl系列 | 屏幕大于1200px |

### 网格代号

> 代号不同，单行显示的网格数量也不同

| 网格代号 | 单行网格数量       | 举例                  |
| ---- | ------------ | ------------------- |
| 空    | 网格宽度随内容而发生变化 | `col` `col-sm`      |
| auto | 网格宽度随内容而发生变化 | `col-auto` `col-xl` |
| 1    | 屏幕单行分12个网格   | `col-sm-1`          |
| 2    | 屏幕单行分6个网格    | `col-md-2`          |
| 3    | 屏幕单行分4个网格    | `col-lg-3`          |
| 4    | 屏幕单行分3个网格    | `col-xl-4`          |
| 5    | 与`7`配合独占一行   | `col-5`             |
| 6    | 屏幕单行分2个网格    | `col-6`             |
| 7    | 与`5`配合独占一行   | `col-7`             |
| 8    | 与`4`配合独占一行   | `col-8`             |
| 9    | 与`3`配合独占一行   | `col-9`             |
| 10   | 与`2`配合独占一行   | `col-10`            |
| 11   | 与`1`配合独占一行   | `col-11`            |
| 12   | 屏幕单行分1个网格    | `col-12`            |

| `col` vs `col-auto` | 比较结果         |
| ------------------- | ------------ |
| `col`               | 宽度不会超出屏幕最大宽度 |
| `col-auto`          | 会超出屏幕最大宽度    |

> 测试下就会发现将序号先加等于`12`的就会是独立的一行，下举例都是独立一行的

```html
<div class="container-fluid">
    <div class="row">
        <div class="col-1 bg-warning">1</div>
        <div class="col-2 bg-danger">2</div>
        <div class="col-9 bg-info">9</div>
    </div>
</div>
```

```html
<div class="container-fluid">
    <div class="row">
        <div class="col-3 bg-warning">3</div>
        <div class="col-4 bg-danger">4</div>
        <div class="col-5 bg-info">5</div>
    </div>
</div>
```

```html
<div class="container-fluid">
    <div class="row">
        <div class="col-1 bg-warning">1</div>
        <div class="col-4 bg-info">4</div>
        <div class="col-3 bg-danger">3</div>
        <div class="col-4 bg-info">4</div>
    </div>
</div>
```

### 响应式网格设计

> 屏幕宽度不同，单行显示的网格数也不同

```html
<div class="container-fluid">
    <div class="row">
        <div class="col-12 col-sm-4 col-lg-3 col-xl-1 bg-warning">1</div>
        <div class="col-12 col-sm-4 col-lg-3 col-xl-1 bg-info">2</div>
        <div class="col-12 col-sm-4 col-lg-3 col-xl-1 bg-danger">3</div>
        <div class="col-12 col-sm-4 col-lg-3 col-xl-1 bg-warning">4</div>
        <div class="col-12 col-sm-4 col-lg-3 col-xl-1 bg-info">5</div>
        <div class="col-12 col-sm-4 col-lg-3 col-xl-1 bg-danger">6</div>
        <div class="col-12 col-sm-4 col-lg-3 col-xl-1 bg-warning">7</div>
        <div class="col-12 col-sm-4 col-lg-3 col-xl-1 bg-info">8</div>
        <div class="col-12 col-sm-4 col-lg-3 col-xl-1 bg-danger">9</div>
        <div class="col-12 col-sm-4 col-lg-3 col-xl-1 bg-warning">10</div>
        <div class="col-12 col-sm-4 col-lg-3 col-xl-1 bg-info">11</div>
        <div class="col-12 col-sm-4 col-lg-3 col-xl-1 bg-danger">12</div>
    </div>
</div>
```

> PS：媒体屏幕越大，优先级越高，即：`col-xl-`优先级最高， `col-`优先级最低
