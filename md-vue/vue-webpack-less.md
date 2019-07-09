# vue-webpack-less

## 步骤一

安装 less less-loader

## 步骤二

build/utils.js 中，不需要添加 css,less 的配置，否则不能直接 import 方式引入

```js
// {
// test: /\.less\$/,
// loader: 'style-loader!css-loader!less-loader',
// //use: ['babel-loader', 'vue-loader', 'style-loader', 'css-loader', 'less-loader']
// }
```

## 替换主题

首先在项目中先建一个目录，比如 my-theme，然后在 my-theme 下建立一个 less 文件 index.less，并写入下面内容：

@import '~iview/src/styles/index.less';

// 下面是要覆盖的变量，例如：
@primary-color: #8c0776;

```less
@import './theme.less';

.vc-text {
  color: @color-text;
}

@color-text: blue;
```
