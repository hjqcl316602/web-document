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
