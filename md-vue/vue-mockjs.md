
# vue-mockjs

## 新建(mock.js)

```js
import Mock from 'mockjs'

const Random = Mock.Random

const articleList = function () {
  let articleList = [];
  for (let i = 0; i < 100; i++) {
    let obj = {
      title: Random.csentence(5, 30),
      thumbnail_pic_s: Random.dataImage('300x250', 'mock的图片'), // Random.dataImage( size, text ) 生成一段随机的 Base64 图片编码
      author_name: Random.cname(), // Random.cname() 随机生成一个常见的中文姓名
      date: Random.date() + ' ' + Random.time() // Random.date()指示生成的日期字符串的格式,默认为yyyy-MM-dd；Random.time() 返回一个随机的时间字符串
    }
    articleList.push(obj)
  }
  console.log
  return {
    articleList:articleList
  }
}
console.log(articleList())

Mock.mock('/news/index','post',articleList)

```

## 导出(index.js)

```js

let mock = require('./mock');

export {
  mock
}

```

## 导入(main.js)

```js

import mock from './javascripts/mock';

```

## 请求

```js

import axios from 'axios'
import vue from 'vue'
import  qs from 'qs';

let baseConfig = {
  url: '',
  method: 'post',
  baseURL: '',
  headers: {'Content-Type': 'application/x-www-form-urlencoded', 'user-type':'admin'},
  params: {
    id:'isisisi'
  },
  data: {},
  timeout: '',
  withCredentials: true,  
  responseType: 'json',  
  maxContentLength: 2000,
  timeout:30 * 1000,
  validateStatus(status) {
    return status >= 200 && status < 300  
  },
  transformRequest(params){
    return qs.stringify(params)
  },
  // transformResponse(response){
  //   console.log('transformResponse')
  //   return response
  // }
}

axios.interceptors.request.use((config)=>{
  return config
},(error)=>{
  return Promise.reject(error)
})

axios.interceptors.response.use((response)=>{
  return response
},(error)=>{ 
    return Promise.reject(error)
})

export default function(url,params){
  return new Promise((resolve,reject)=>{
    axios.post(url,params).then((response)=>{
      console.log(response)
       resolve(response.data)
    }).catch((error)=>{
       reject(error)
    })
  })
}

// mock不能通过这样的方式，暂未解，要使用axios.post
// axios({...baseConfig,...config}).then((response)=>{
//   console.log(response)
//    resolve(response.data)
// }).catch((error)=>{
//    reject(error)
// })


```

## 使用

```js
request('/news/index').then((response)=>{
  console.log(response)
  this.list = response['articleList']
})

```
