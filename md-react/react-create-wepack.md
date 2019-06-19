
# react-wepack

## npm run eject

执行npm run eject 将隐藏的配置文件暴露出来，不可逆

## 本地服务

serve -s dist

## 忽略console.log

找到webpack.config.js文件，搜索compress添加

```js

compress:{
  drop_console:true,
  drop_debugger:true,
}

```

## 移除vscode装饰器报错

在项目根目录下创建tsconfig.json文件，并添加以下代码，重启即可

```js

{
  "compilerOptions": {
      "experimentalDecorators": true,
      "allowJs": true
  }
}

```

## 配置快捷路径@

执行npm run eject后，找到文件config.js，搜索alias

```js

alias: {
  // Support React Native Web
  // https://www.smashingmagazine.com/2016/08/a-glimpse-into-the-future-with-react-native-for-web/
  'react-native': 'react-native-web',
  '@':paths.appSrc, //添加
},

```

## 打包后window的问题

index.html中引入JSEncrypt文件，在react组件中直接使用JSEncrypt类不行，只能使用window.JSEncrypt

## 打包后路径的问题

在package.json文件里面添加一个字段homepage，值为‘.’，即可；

## 打包忽略第三库

  webpack.config.js
  但是忽略打包的话，会报找不到react的错，暂时不理解create-react-app打包的原理

```js
    externals: {
      'react': 'react',
      'react-dom':'react-dom',
      'react-router-dom':'react-router-dom'
    },
```

## 取消sourceMap的生成

const shouldUseSourceMap = false ;//process.env.GENERATE_SOURCEMAP !== 'false';

## 第三库分离打包

  生成的vendor文件很大，没有实际意义

  在根目录下创建两个文件
  webpack.base.config.js

  ``` js
    const path = require('path')
    const webpack = require('webpack')

    function resolve(relatedPath) {
      return path.join(__dirname, relatedPath)
    }
    module.exports = {
      entry: {
        index: resolve('../myapp/src/index.js')
      },
      output: {
        path: resolve('../myapp/dist'),
        filename: '[name].[hash:4].js',
        chunkFilename: 'chunks/[name].[hash:4].js',
      },
      resolveLoader: {
        moduleExtensions: ['-loader']
      },
      module: {
        rules: [
          {
            test: /\.js[x]?$/,
            exclude: /node_modules/,
            loader: 'babel',
            query: {
              presets: ['react', 'es2015', 'stage-0']
            }
          },
          {
            test: /\.css/,
            loader: 'css'
          },
          {
            test: /\.(png|jpe?g|gif|svg)(\?.*)?$/,
            loader: 'url',
            options: {
              limit: 8192,
              name: 'img/[name].[hash:4].[ext]'
            }
          },
          {
            test: /\.html$/,  //静态资源
            loader: 'html',
          }
        ],
      },
      plugins: [
        new webpack.DllReferencePlugin({
          context: __dirname,//上下文关系
          manifest: require('./dist/manifest.json')//生成的索引表
        }),
      ],


    }
  
  ```

  webpack.dll.config.js

  ``` g
    const webpack = require('webpack')
    const path = require('path')

    function resolve(relatedPath) {
      return path.join(__dirname, relatedPath)
    }

    module.exports = {
      entry: {
        vendors: ['react-dom']//需要打包的第三方库文件
      },

      output: {
        filename: '[name].[chunkhash:4].js',//生成的文件名
        path: resolve('../myapp/dist'),//生成的文件存放的路径
        library: '[name]_[chunkhash:4]'//决定了manifest中的格式
      },

      plugins: [
        new webpack.DllPlugin({
          path: resolve('../myapp/dist/manifest.json'),
          name: '[name]_[chunkhash:4]',//生成的第三方库文件， 要和上面的library一致
          context:__dirname
        }),
      ],
    }
  
  ```

  package.json
  
  ```
    "build": "webpack --config webpack.base.config.js",
    "dll": "webpack --config webpack.dll.config.js"
  ```
  