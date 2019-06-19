
# react-create-init

## create-react-app

* 安装 : npm install -g create-react-app
* 依赖 : react react-dom react-scripts
* 创建项目 : create-react-app react-app-demo

单向操作不可逆，npm eun eject命令暴露项目的配置，可以自由配置项目所需的依赖，不使用的版本零配置即可开发

### create-react-app 1.0 和 2.0 的区别

#### 添加装饰器的不同

1.0

* 安装 : npm install --dev babel-plugin-transform-decorators-legacy
* 配置 : package.json

``` a

"plugins": [
  "transform-decorators-legacy",
  ....
]

```

2.0

* 安装 : npm install --dev @babel/plugin-proposal-decorators
* 配置 ：package.json

``` a

"plugins": [
  [
  "@babel/plugin-proposal-decorators",
  {
    "legacy": true
  }
],
....
]

```

### 配置

## dva

  dva 首先是一个基于 redux 和 redux-saga 的数据流方案，然后为了简化开发体验，dva 还额外内置了 react-router 和 fetch，所以也可以理解为一个轻量级的应用框架

* 安装 : npm install -g dva-cli
* 创建项目 : 找到指定文件夹，执行 dva init