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

> `.container` 源码

```css
.container {
  width: 100%;
  padding-right: 15px;
  padding-left: 15px;
  margin-right: auto;
  margin-left: auto;
}

@media (min-width: 576px) {
  .container {
    max-width: 540px;
  }
}

@media (min-width: 768px) {
  .container {
    max-width: 720px;
  }
}

@media (min-width: 992px) {
  .container {
    max-width: 960px;
  }
}

@media (min-width: 1200px) {
  .container {
    max-width: 1140px;
  }
}
```

> `.container-fluid`

```css
.container-fluid {
  width: 100%;
  padding-right: 15px;
  padding-left: 15px;
  margin-right: auto;
  margin-left: auto;
}
```

> PS：尽量在容器内完成页面的工作

## 章节导航

| 序号  | 章节            |
| --- | ------------- |
| 1   | [网格](./网格.md) |
| 2   | [偏移](./偏移.md) |
| 3   | [表格](./表格.md) |
