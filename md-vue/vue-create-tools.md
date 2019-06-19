
# vue-create-app

## vue-cli3.0

### 卸载之前的2.0版本 
npm uninstall -g vue-cli

### 安装3.0版本
npm install -g @vue/cli

### 创建项目 
vue create [name]

### 启动可视化开发(管理项目)
vue ui


### 优势

* 减少了配置文件
* 添加了 jsx、 typescript 的书写支持
* 支持可视化开发
* css 打包不会出现 '-webkit-'忽略的情况
* image 打包不会出现路径找不到的情况

### vue.config.js配置

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


module.exports = {
  publicPath: process.env.NODE_ENV === 'production' ? './' : '', 
  productionSourceMap: process.env.NODE_ENV === 'production' ? false : true,
  devServer: {
    port: 9000,
    open: false,
    host: getNetworkIp()
  }
}

```

## vue-cli

### 安装

npm install -g vue-cli

### 创建项目

vue init webpack study-vue-app-demo

