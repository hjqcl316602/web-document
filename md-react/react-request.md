
# request

## Fly

```js

import fly from 'flyio'
import qs from 'qs'

fly.config = {
  method:"POST",//请求方法， GET 、POST ...
  headers:{ 'Content-type':'application/json'},//请求头
  baseURL:"",//请求基地址
  //是否自动将Content-Type为“application/json”的响应数据转化为JSON对象，默认为true
  //parseJson:true,
  timeout:10000,//超时时间,
  responseType:'json' // 响应值是json ，默认是string
}

//添加请求拦截器
fly.interceptors.request.use((request)=>{
    console.log('request')

      //给所有请求添加自定义header
      //request.headers["X-Tag"]="flyio";
      //打印出请求体 
      //终止请求
      //var err=new Error("xxx")
      //err.request=request
      //return Promise.reject(new Error(""))

    //可以显式返回request, 也可以不返回，没有返回值时拦截器中默认返回request
    request.body = qs.stringify(request.body)

    return request;
})

//添加响应拦截器，响应拦截器会在then/catch处理之前执行
fly.interceptors.response.use(
    (response) => {  
        //只将请求结果的data字段返回
        return response.data
    },
    (err) => {
        //发生网络错误后会走到这里
        //return Promise.resolve("ssss")
        console.log('err')
        console.log(err)
    }
)

export default fly

```

### 注意事项

#### Request Payload 和 Form Data 请求的区别

fly的方式不会自动变成Form Data的方式，需要手动更改

* 对于 Request Payload 请求， 必须加 @RequestBody 才能将请求正文解析到对应的 bean 中，且只能通过 request.getReader() 来获取请求正文内容

* 对于 Form Data 请求，无需任何注解，springmvc 会自动使用 MessageConverter 将请求参数解析到对应的 bean，且通过 request.getParameter(...) 能获取请求参数

变成formData数据

```js

fly.interceptors.request.use((request)=>{
console.log('request')
console.log(request)

let body = request.body;
var bodyFormData = new FormData();
Object.keys(body).forEach((key)=>{
  bodyFormData.append(key,body[key])
})  
request.body = bodyFormData ;//qs.stringify(request.body)  
  
return request;
})

```

## axios

``` a

import axios from 'axios'
import qs from 'qs'

const instance = axios.create({
  url: '',
  method: 'get', 
  baseURL: 'https://some-domain.com/api/',
  transformRequest: [function (data, headers) {
    return data;
  }],
  transformResponse: [function (data) {
    return data;
  }],
  headers: { 'Content-type':'application/json'},
  // params: {
  //   ID: 12345
  // },
  timeout: 10000,
  withCredentials: false,
  // 响应格式
  // 可选项 'arraybuffer', 'blob', 'document', 'json', 'text', 'stream'
  responseType: 'json', // 默认值是json
 
  // 处理上传进度事件
  onUploadProgress: function (progressEvent) {
    // Do whatever you want with the native progress event
  },

  // 处理下载进度事件
  onDownloadProgress: function (progressEvent) {
    // Do whatever you want with the native progress event
  },
  // 设置http响应内容的最大长度
  maxContentLength: 2000,
  // 定义可获得的http响应状态码
  // return true、设置为null或者undefined，promise将resolved,否则将rejected
  validateStatus: function (status) {
    return status >= 200 && status < 300; // default
  },
})


// 添加一个请求拦截器
instance.interceptors.request.use(function (config) {
  // Do something before request is sent 
  config.transformRequest = function(data){
    return qs.stringify(data)
  }

  return config;
}, function (error) { 
  return Promise.reject(error);
});

// 添加一个响应拦截器
instance.interceptors.response.use(function (response) { 
  return response.data || {};
}, function (error) { 
  return Promise.reject(error);
});


export default instance

```

## XMLHttpRequest

``` a

  import qs from 'qs'

export default (url,params) => {
  let xhr;

  if (window.XMLHttpRequest) {
    xhr = new XMLHttpRequest();
  }
  // else if (window.ActiveXObject) {
  //   try {
  //     xhr = new ActiveXObject('Msxml2.XMLHTTP')
  //   } catch (e) {
  //     try {
  //       xhr = new ActiveXObject('Microsoft.XMLHTTP')
  //     } catch (e) {

  //     }
  //   }
  // }
  console.log(xhr)
  if (xhr) {
    xhr.onreadystatechange = function(){
      console.log(xhr)
      if (xhr.readyState === 4) {
   　　 // everything is good, the response is received
    　　if (xhr.status === 200) {
      　　　console.log(xhr.responseText);
    　　} else {
      　　　console.log('There was a problem with the request.');
   　　 }
  　} else {
    　　// still not ready
    　　console.log('still not ready...');
  　}
    };
    xhr.open('POST', url, true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.send(qs.stringify(params));
  }
}

```

## 区别

* fly 和 axios ， 前者的错误信息可以捕捉到，信息更加的全面