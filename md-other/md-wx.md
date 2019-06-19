
# 微信

## 分享（ios的坑）

PS：当浏览者从分享窗口进入后，他从分享页按着正常路由跳转到其他页面，其他页面的逻辑中如果有需要获取当前页面url的需要，会发现这个url和正常路由跳转的不一样,导致签名不一致,所以获取不到正确的文案。
解决: 每次路由变化时都重新请求下签名，签名的URL 用第一次进入时的URL就可以解决了
重点：分享路径后面的参数，不能带有中文，并且转码也不行，只能通过其他的方式，调用接口什么的

## Js验签

Ios和安卓的验签有一定的区别，如果只是按照安卓的方式验签，ios的验签会出现不稳定的情况；安卓的url需要编码进行验签，ios只需要进行“#”前面的域名进行验签即可
解决办法：

* 微信验签接口的调用：

```js
function get_wx_sign(href){
  return new Promise((resolve,reject)=>{
    axios({
      url:configs.HTTP_WX + '/common/js.do?url=' + href
    }).then((reponse)=>{
      let data = reponse.data;
      resolve(data)
    },()=>{
      reject()
    })
  })
}

```

* 设置微信js接口

``` js
export  function set_wx_sign(href){
  get_wx_sign(href).then((message)=>{
    wx.config({
      debug: false,
      appId: message['appId'],
      timestamp: message['timestamp'],
      nonceStr:message['nonceStr'] ,
      signature:message['signature'],
      jsApiList: ['hideAllNonBaseMenuItem','previewImage','uploadImage','chooseImage','getLocalImgData','onMenuShareAppMessage','onMenuShareTimeline','showMenuItems','chooseWXPay']
    });
  })
}

```

* 进入页面之后：

```js

let browser = browserType();
//alert(browser)
let web = window.location.href;
let href = '';
if(browser == 'ios'){
  href = web.split('#')[0];         // 专门用于ios的js验签
}
if(browser =='android'){
  web = web.split('#')[0]+ '#' + to.fullPath;
  href = encodeURIComponent(web)
}

console.log(href)
set_wx_sign(href);
wx.ready(()=>{
  wx.hideAllNonBaseMenuItem();
})
  
```
