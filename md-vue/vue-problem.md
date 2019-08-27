<!--
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2019-03-05 18:31:43
 * @LastEditTime: 2019-08-27 17:57:37
 * @LastEditors: Please set LastEditors
 -->

# vue-problem vue 遇到的一些坑点

## 针对需要动画的 v-model 的设置

```js
//需要初始动画
instance.data = function() {
  return {
    currentValue: false
  };
};
instance.mounted = function() {
  this.$nextTick(() => {
    this.currentValue = this.value;
  });
};
instance.watch = {
  currentValue(val) {
    this.$emit('input', val);
  },
  value(val) {
    this.currentValue = val;
  }
};
// 不需要动画
instance.computed = {
  currentValue: {
    get() {
      return this.value;
    },
    set(val) {
      this.$parent.$emit('input', val);
    }
  }
};
```

## 修改 prop 数据，作为组件内部使用

定义一个局部变量，并用 prop 的值初始化它：

```js

props: ['initialCounter'],
data: function () {
  return { counter: this.initialCounter }
}

```

定义一个计算属性，处理 prop 的值并返回：

```js

props: ['size'],
computed: {
normalizedSize: function () {
  eturn this.size.trim().toLowerCase()
}
}

```

## 路由改变页面数据不刷新

PS：当前页面跳转到当前页面时，不会执行 mouted、activated 等生命周期
解决办法：可以在生命周期 beforeRouteUpdate (to, from, next) { }中执行方法，页面通过监听‘\$route’等方式

## setInterval 路由跳转继续运行并没有及时进行销毁

比如一些弹幕，走马灯文字，这类需要定时调用的，路由跳转之后，因为组件已经销毁了，但是 setInterval 还没有销毁，还在继续后台调用，控制台会不断报错，如果运算量大的话，无法及时清除，会导致严重的页面卡顿。
解决办法：在组件生命周期 beforeDestroy 停止 setInterval
//组件销毁前执行的钩子函数，跟其他生命周期钩子函数的用法相同。
beforeDestroy(){
//我通常是把 setInterval()定时器赋值给 this 实例，然后就可以像下面这么停止。
clearInterval(
this
.intervalId);
},
首先得将定时器定义一个组件变量

## 组件内引入外部 js

- 方法一
  缺点：不能在页面加载之前获取到 js，导致需要使用 js 的时候，需要定时器来实现

```js
components: {
      ['ScriptLink']:{
        render(createElement){
          return createElement(
            'script',
            {
              attrs:{
                type:'text/javascript',src:this.src
              }
            }
          )
        },
        props:{ type:String,required:true }
      }
},
<ScriptLink src="static/js-library/echarts.min.js"></ScriptLink>

```

- 方法二

缺点：将引入的 js 打包成一个 js 后，会变得比较庞大，使得加载页面的时候回卡顿一小会儿 。手机端比较敏感的（用于单独页面引用（减少首次页面加载速度），以及需要打包才能使用的（比如自己写的一些工具类））
Webpack.base.conf.js 中添加

```js
resolve: {
    extensions: ['.js', '.vue', '.json'],
    alias: {
      'vue$': 'vue/dist/vue.esm.js',
      'jquery':resolve('static/js-library/jquery.js'),
      'echarts':resolve('static/js-library/echarts.min.js'),
      '@': resolve('src'),
    }
  },

```

## 数据加载时的加载动画

```js
//loading 1 - 不加载 2 - 一直加载 3 - 只加载第一次
let isLoadingAnimate = true;

if (loading === 3) {
  let urls = sessionStorage.getItem('urls') ? JSON.parse(sessionStorage.getItem('urls')) : [];
  if (urls.indexOf(url) === -1) {
    isLoadingAnimate = true;
    urls.push(url);
    sessionStorage.setItem('urls', JSON.stringify(urls));
  } else {
    isLoadingAnimate = false;
  }
}

if (loading === 2 || (loading === 3 && isLoadingAnimate)) {
  this.$createMyLoading().show();
  interval = 350; // 如果需要加载动画，则延长返回时间，否则接口过快，出现页面闪烁
}
```
