## Flex

> Flex 可快速管理布局、对齐、网格列的大小、导航组件和更多 flexbox 实用样式类集合。对于更复杂的实现，可能需要定制 CSS。

| 样式类                                     | 描述                                                 |
| ------------------------------------------ | ---------------------------------------------------- |
| `.d<-{sm|md|lg|xl}>-flex`                  | 以弹性伸缩盒显示，上面已经讲解                       |
| `.d<-{sm|md|lg|xl}>-inline-flex`           | 以内联块级弹性伸缩盒显示，上面已经讲解               |
| `.flex<-{sm|md|lg|xl}>-row`                | 父级元素样式类，水平，靠左排序                       |
| `.flex<-{sm|md|lg|xl}>-row-reverse`        | 父级元素样式类，水平，靠右排序                       |
| `.flex<-{sm|md|lg|xl}>-column`             | 父级元素样式类，垂直，靠上排序                       |
| `.flex<-{sm|md|lg|xl}>-column-reverse`     | 父级元素样式类，垂直，靠下排序                       |
| `.flex<-{sm|md|lg|xl}>-fill`               | 子级元素样式类，所有子级元素占用所有可用的水平空间。 |
| `.flex<-{sm|md|lg|xl}>-grow-0`             | 子级元素样式类，区块禁止放大                         |
| `.flex<-{sm|md|lg|xl}>-grow-1`             | 子级元素样式类，区块放大                             |
| `.flex<-{sm|md|lg|xl}>-shrink-0`           | 子级元素样式类，区块禁止缩小                         |
| `.flex<-{sm|md|lg|xl}>-shrink-1`           | 子级元素样式类，区块缩小                             |
| `.flex<-{sm|md|lg|xl}>-nowrap`             | 父级区块不换行，子级换行                             |
| `.flex<-{sm|md|lg|xl}>-wrap`               | 父级区块会换行，子级不会换行                         |
| `.flex<-{sm|md|lg|xl}>-wrap-reverse`       | 父级区块会换行，子级不会换行，靠右排序               |
| `.justify-content<-{sm|md|lg|xl}>-start`   | 父级元素样式类，水平，居左                           |
| `.justify-content<-{sm|md|lg|xl}>-end}`    | 父级元素样式类，水平，居右                           |
| `.justify-content<-{sm|md|lg|xl}>-center`  | 父级元素样式类，水平，居中                           |
| `.justify-content<-{sm|md|lg|xl}>-between` | 父级元素样式类，水平，子级间留白                     |
| `.justify-content<-{sm|md|lg|xl}>-around`  | 父级元素样式类，水平，两侧、子级间都有留白           |
| `.align-items<-{sm|md|lg|xl}>-start`       | 父级元素样式类，垂直，居上                           |
| `.align-items<-{sm|md|lg|xl}>-end`         | 父级元素样式类，垂直，居下                           |
| `.align-items<-{sm|md|lg|xl}>-center`      | 父级元素样式类，垂直，居中                           |
| `.align-items<-{sm|md|lg|xl}>-baseline`    | 父级元素样式类，垂直，元素位于容器的基线上           |
| `.align-items<-{sm|md|lg|xl}>-stretch`     | 父级元素样式类，垂直空间占满                         |
| `.align-self<-{sm|md|lg|xl}>-start`        | 子级元素样式类，垂直，居上                           |
| `.align-self<-{sm|md|lg|xl}>-end`          | 子级元素样式类，垂直，居下                           |
| `.align-self<-{sm|md|lg|xl}>-center`       | 子级元素样式类，垂直，居中                           |
| `.align-self<-{sm|md|lg|xl}>-baseline`     | 子级元素样式类，垂直，元素位于容器的基线上           |
| `.align-self<-{sm|md|lg|xl}>-stretch`      | 子级元素样式类，垂直空间占满                         |
| `.align-content<-{sm|md|lg|xl}>-start`     |
| `.align-content<-{sm|md|lg|xl}>-end`       |
| `.align-content<-{sm|md|lg|xl}>-center`    |
| `.align-content<-{sm|md|lg|xl}>-around`    |
| `.align-content<-{sm|md|lg|xl}>-stretch`   |
| `.m-auto`                                  |
| `.ml-auto`                                 |
| `.mr-auto`                                 |
| `.mt-auto`                                 |
| `.mb-auto`                                 |
| `.mx-auto`                                 |
| `.my-auto`                                 |
| `.order<-{sm|md|lg|xl}>-[0-12]`            | 更改统计元素的排序，其它章节已经讲解                 |
