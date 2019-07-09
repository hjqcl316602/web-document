# webpack 优化

## 不打包指定的文件，拷贝即可

```js
//build/webpack.prod.conf.js文件中
new CopyWebpackPlugin([
  {
    from: path.resolve(__dirname, '../static'),
    to: config.build.assetsSubDirectory,
    ignore: ['.*']
  },
  {
    from: './src/app.js', // 指定的文件路径
    to: 'server.js'
  }
]);
```

## 打包出现 map 文件

config/index.js => build => productionSourceMap : false

## 本地域名启动，以便手机访问

- 在 config 文件夹下添加 network.js

```js
const os = require('os');

function getNetworkIp() {
  let needHost = ''; // 打开的host
  try {
    // 获得网络接口列表
    let network = os.networkInterfaces();
    //console.log(network)
    for (let dev in network) {
      let iface = network[dev];
      for (let i = 0; i < iface.length; i++) {
        let alias = iface[i];
        if (alias.family === 'IPv4' && alias.address !== '127.0.0.1' && !alias.internal) {
          needHost = alias.address;
        }
      }
    }
  } catch (e) {
    needHost = 'localhost';
  }
  return needHost;
}

module.exports = getNetworkIp();
```

- 找到 config 文件夹下 config.js

```js

  const host = require('./network')
  module.exports = {
    dev:{
      host:host,
      ...
    }
  }

```

## 直接打开文件不能找到资源

找到 config/index.js

```js
build:{
  assetsPublicPath: './',
}

```

## 配置文件快捷导入方式

找到 build/Webpack.base.conf.js 中添加

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

## vue 打包后 css 里-webkit-前缀丢失

- 找到 build/webpack.prod.conf.js，注释下面这一段

```js
/* new OptimizeCSSPlugin({
  cssProcessorOptions: config.build.productionSourceMap
    ? { safe: true, map: { inline: false } }
    : { safe: true }
}), */
```

- 在 build/utils.js 里加入 minimize: true，压缩 css

```js
const cssLoader = {
  loader: 'css-loader',
  options: {
    sourceMap: options.sourceMap,
    minimize: true
  }
};
```

## Vue 打包后图片路径引用失败处理

找到 build->utils.js,在里面加入一句 publicPath:'../../'

```js
if (options.extract) {
  return ExtractTextPlugin.extract({
    use: loaders,
    publicPath: '../../',
    fallback: 'vue-style-loader'
  });
} else {
  return ['vue-style-loader'].concat(loaders);
}
```

## 不打包 vue vuex router axios 等库

- 找到 build/webpack.prod.conf.js 文件，在 module.exports 中配置

```js

externals: {
  'vue': 'Vue',
  'vue-router': 'VueRouter',
  'vuex': 'Vuex',
  'axios': 'axios'
},

```

- index.html 中直接引入

```js

<script src="http://cdn.bootcss.com/vue/2.5.16/vue.min.js"></script>
<script src="http://cdn.bootcss.com/vue-router/3.0.1/vue-router.min.js"><script>
<script src="http://cdn.bootcss.com/vuex/3.0.1/vuex.min.js"></script>
<script src="http://cdn.bootcss.com/axios/0.18.0/axios.min.js"></script>

// 或者引入存放本地的库

```

## 生产环境忽略 console.log

找到 build/webpack.prod.conf.js 文件

```js
new webpack.optimize.UglifyJsPlugin({
  compress:{
    warnings: false,
    drop_debugger: true,
    drop_console: true
  }
}),
// 或者是
new UglifyJsPlugin({
      uglifyOptions: {
        compress: {
          warnings: false,
          drop_debugger: true,
          drop_console: true
        }
      },
      sourceMap: config.build.productionSourceMap,
      parallel: true
    }),

```

## 优化打包速度

- 安装：npm i webpack-parallel-uglify-plugin

- 修改配置文件 build/webpack.prod.conf.js

```js


const ParallelUglifyPlugin = require('webpack-parallel-uglify-plugin');

//....

// 删掉webpack提供的UglifyJS插件

//new UglifyJsPlugin({

//  uglifyOptions: {

//    compress: {

//      warnings: false

//    }

//  },

//  sourceMap: config.build.productionSourceMap,

//  parallel: true

//}),

// 增加 webpack-parallel-uglify-plugin来替换

new ParallelUglifyPlugin({

  cacheDir: '.cache/',

  uglifyJS:{

    output: {

      comments: false

    },

    compress: {

      warnings: false

    }

  }

}),


```
