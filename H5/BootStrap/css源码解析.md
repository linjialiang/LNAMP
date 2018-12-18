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
>
> -   必须是在 `.row类` 下的标签才生效

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

| 代号         | 结果1          | 结果2       | width值       |
| ---------- | ------------ | --------- | ------------ |
| `col`      | 宽度不会超出屏幕最大宽度 | 内容会铺满屏幕宽度 | `width:100%` |
| `col-auto` | 会超出屏幕最大宽度    | 宽度看内容所占像素 | `width:auto` |

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

> PS：媒体屏幕越大优先级越高，因为媒体越大越靠后，即：`col-xl-`优先级最高， `col-`优先级最低

## 布局顺序

> bootstrap 使用一系列的 `order` 来对同级标签来修改布局顺序
>
> -   必须是在 `.row类` 下的标签才生效

```html
<div class="container-fluid">
    <div class="row">
        <div class="col-auto bg-warning">1</div>
        <div class="col-auto bg-info">2</div>
        <div class="col-auto bg-danger">3</div>
        <div class="col-auto bg-warning">4</div>
        <div class="col-auto bg-info">5</div>
        <div class="col-auto bg-danger">6</div>
        <div class="col-auto bg-warning">7</div>
        <div class="col-auto bg-info">8</div>
        <div class="col-auto bg-danger">9</div>
        <div class="col-auto bg-warning">10</div>
        <div class="col-auto bg-info">11</div>
        <div class="col-auto bg-danger">12</div>
    </div>
</div>
```

### 响应式布局

> `bootstrap` 中不同的屏幕大小可以使用不同的布局顺序

| 网格代号       | 类型         |
| ---------- | ---------- |
| order系列    | 全局网格系列     |
| order-sm系列 | 屏幕大于576px  |
| order-md系列 | 屏幕大于768px  |
| order-lg系列 | 屏幕大于992px  |
| order-xl系列 | 屏幕大于1200px |

> 优先级：屏幕越大优先级越高，因为源码中媒体越大越靠后

### 布局代号

> `order` 的各种代号及布局顺序优先级

| 布局代号    | 优先级       | 举例                             |
| ------- | --------- | ------------------------------ |
| `first` | 会排在第一位    | `order-first` `order-sm-first` |
| `last`  | 会排在最后一位   | `order-last` `order-xl-last`   |
| `1-12`  | 数字越小排位越靠前 | `order-1` `order-md-12`        |

> 案例

```html
<div class="container-fluid">
    <div class="row">
        <div class="col-auto order-1  bg-warning">1</div>
        <div class="col-auto order-1  order-sm-first order-lg-last bg-info">2</div>
        <div class="col-auto order-1  bg-danger">3</div>
        <div class="col-auto order-2  bg-warning">4</div>
        <div class="col-auto order-3  bg-info">5</div>
        <div class="col-auto order-4  bg-danger">6</div>
        <div class="col-auto order-5  bg-warning">7</div>
        <div class="col-auto order-6  bg-info">8</div>
        <div class="col-auto order-7  bg-danger">9</div>
        <div class="col-auto order-8  bg-warning">10</div>
        <div class="col-auto order-9  bg-info">11</div>
        <div class="col-auto order-10  bg-danger">12</div>
    </div>
</div>
```

> 案例分析-第2个子标签顺序

| 代码               | 触发条件      | 优先级 | 输出结果 |
| ---------------- | --------- | --- | ---- |
| `order-1`        | 全局        | 最低  | 正常顺序 |
| `order-sm-first` | 屏幕大于576px | 较高  | 第一位  |
| `order-lg-last`  | 屏幕大于992px | 最高  | 末位   |

## 偏移

> bootstrap 用一系列的 `offset` 来进行向右偏移

### 响应式偏移

> BootStrap 中不同的屏幕大小，可以定义不同的便宜比例

| 偏移代号        | 类型         | 优先级       |
| ----------- | ---------- | --------- |
| offset系列    | 全局偏移系列     | 最低        |
| offset-sm系列 | 屏幕大于576px  | 屏幕越大优先级越高 |
| offset-md系列 | 屏幕大于768px  | 屏幕越大优先级越高 |
| offset-lg系列 | 屏幕大于992px  | 屏幕越大优先级越高 |
| offset-xl系列 | 屏幕大于1200px | 最高        |

### 偏移比例

> 不同的序号代表不同的偏移比例

| 序号   | 向右偏移比例   | 举例             |
| ---- | -------- | -------------- |
| `1`  | 偏移 1/12  | `offset-1`     |
| `2`  | 偏移 1/6   | `offset-sm-2`  |
| `3`  | 偏移 1/4   | `offset-md-3`  |
| `n`  | 偏移 n/12  | `offset-lg-n`  |
| `11` | 偏移 11/12 | `offset-xl-11` |

> 向右偏移量 == 序号/12，序号越大偏移量就越大

### 偏移案例

> 案例源码

```html
<div class="container-fluid">
    <div class="bg-warning">1</div>
    <div class="bg-info offset-1 offset-sm-6 offset-xl-11">2</div>
    <div class="bg-danger">3</div>
</div>
```

> 案例分析：

| 屏幕宽度     | 偏移量   |
| -------- | ----- |
| 小于576px  | 1/12  |
| 大于756px  | 1/2   |
| 大于1200px | 11/12 |
