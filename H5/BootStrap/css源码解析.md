# BootStrap 的 css样式源码解析

> BootStrap 样式功能非常完整，满足各类网页开发

## `bootstrap` 像素大小

> 所有标签都使用rem来表示像素大小，我们需要为html标签定义一个px来表示，例如：

```css
html{font-size:14px}
```

## `bootstrap` 的容器

> `bootstrap` 有两个的容器：`.container` 和 `.container-fluid`

| 容器                 | 对比     |
| ------------------ | ------ |
| `.container`       | 有最大宽度  |
| `.container-fluid` | 永远100% |
