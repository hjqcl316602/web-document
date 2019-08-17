<!--
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2019-07-24 15:05:04
 * @LastEditTime: 2019-08-17 15:08:34
 * @LastEditors: Please set LastEditors
 -->

# 支付宝 h5 页面

## 启动

通过 scheme 启动
scheme 可以理解为一种特殊的 URI，格式与 URI 相同
支付宝客户端的标准 scheme 为：alipays://platformapi/startapp?appId=

即为 H5App 自身的 appId，但如果是某些运营页之类的单独页面，没有自己的 appId，可以使用 Nebula 容器的通用浏览器模式 appId=20000067 来启动，同时将需要打开的 H5 页面 url 经过 encode 编码后设置到 url 参数内，例如：alipays://platformapi/startapp?appId=20000067&url=http%3A%2F%2Fm.taobao.com

在 scheme 中配置的启动参数需要与 appId 同级，如果启动参数的值包含特殊字符，必须注意需要经过 encode 后再传递

## 扫一扫

首先跳转到支付宝 app
重定向到指定页面
进入该页面后可以唤起 app 的扫一扫
跳转到指定的结果

```js
function ready(callback) {
  // 如果jsbridge已经注入则直接调用
  if (window.AlipayJSBridge) {
    callback && callback();
  } else {
    // 如果没有注入则监听注入的事件
    document.addEventListener('AlipayJSBridgeReady', callback, false);
  }
}

ready(function() {
  AlipayJSBridge.call(
    'scan',
    {
      type: 'qr',
      actionType: 'scanAndRoute' // 跳转到结果
    },
    function(result) {
      //alert(JSON.stringify(result));
    }
  );
});
```

## h5 直接打开支付宝 app

appId:20000067
跳转的地址需要编码

```js
url = urler.encodeURIComponent(url);
window.location.href = `alipays://platformapi/startapp?appId=20000067&url=${url}`;
```

## 支付宝转银行卡

appId:09999988

```js
function ready(callback) {
  if (window.AlipayJSBridge) {
    callback && callback();
  } else {
    document.addEventListener('AlipayJSBridgeReady', callback, false);
  }
}
ready(function() {
  AlipayJSBridge.call('startApp', {
    appId: '09999988',
    param: {
      actionType: 'toCard',
      cardNo: '6221886510045738674',
      bankAccount: '黄军泉',
      money: '0.1',
      bankMark: 'PSBC',
      bankName: '邮政储蓄'
    }
  });
});
```

## 支付宝快捷转账

```js
let self = this;
function ready(callback) {
  if (window.AlipayJSBridge) {
    callback && callback();
  } else {
    document.addEventListener('AlipayJSBridgeReady', callback, false);
  }
}
ready(function() {
  AlipayJSBridge.call(
    'startApp',
    {
      appId: '20000123',
      param: {
        actionType: 'scan',
        u: '2088002357544150',
        a: self['money'],
        m: self['memo'],
        biz_data: {
          s: 'money',
          u: '2088002357544150',
          a: self['money'],
          m: self['memo']
        }
      }
    },
    function(a) {}
  );
});
```
