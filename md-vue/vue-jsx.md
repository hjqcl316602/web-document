# vue-jsx

## 实例

```js
import './home.css';

export default {
  props: {
    type: ''
  },
  data: {
    return: {
      name: '黄军泉'
    }
  },
  render() {
    return (
      <div style="" class="vc-home">
        huangjunquan
      </div>
    );
  }
};
```

## 配置

找到文件 webpack.base.conf.js，配置识别 jsx 文件，书写 jsx 文件的好处是让编辑器能识别 jsx 部分代码
缺点

- 不能配置 vue 相关的只能提示，降低开发效率
- 不能添加 v-if v-show 等指令，降低开发效率，文档可读性降低

优点

- 整个文档是 js 书写方式，看起来干净美观

```js
{
  test: /\.js(x)?$/, // 添加上识别的jsx文件
  loader: 'babel-loader',
  include: [resolve('src'), resolve('test'), resolve('node_modules/webpack-dev-server/client')]
},
```
