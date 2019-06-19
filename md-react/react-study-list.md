
# react-study-list

react学习清单（之前使用过的框架后，需要学习的部分）

## react-router的标题设置（实现）

需要自定义一个组件，传入标题值，在组件渲染和更新均重新赋值即可

``` a
import React, { Component }  from 'react'

import { Route,withRouter  } from 'react-router-dom'

const Main = ({ location }) => {
  return <div>{location.pathname}</div>
}

class RouterPrivate extends Component {
  constructor(props){
    super(props)
    console.log(this.props)


    // history.listen((params)=>{ // 使用listen的方式设置标题，第一次不能触发
    //   console.log(params)
    //   document.title = params.pathname
    // })
  }
  componentWillMount(props){
    console.log('componentWillMount')
    this.setTile(this.props.name)
  }
  componentWillUpdate(props){
    console.log('componentWillUpdate')
    console.log(props)
    this.setTile(props.name)
  }


  setTile = (title)=>{
    document.title = title
  }

  render() {
    return (
      <Route {...this.props}></Route>
    )
  }
}

export default withRouter(RouterPrivate)
// 添加withRouter 才能得到history对象

```

## react-router 实现登录权限验证，并记录要返回的页面（实现）

修改上面render的方法

``` a

render(){
  let { isLogin , path : pathName } = this.props;
  let isLogined = isLogin && !sessionStorage.getItem('isLogin');
  console.log(isLogined)
  console.log('render')
  console.log(this.props)
  if(isLogined){
    return <Redirect to={{
      pathname:'/login',
      state:{
        redirect:pathName
      }
    }}></Redirect>
  }

  return (
    <Route {...this.props}></Route>
  )
}


<RoutePrivate component={Detail} path='/detail' isLogin  name='详情页'></RoutePrivate>

```

## react-router 的缓存页面（待实现）

### 方式一

    把加载页面的必要信息放URL里，后退就是浏览器的后退，回退时组件依然会重新渲染，componentDidMount的时候根据这些url的信息去请求API。数据保持离开时最新的状态。
    这种方法在翻页情况下使用固然可以，但是像下拉加载那样，是多次请求的数据集合，就无法通过这种方式解决，而且后退时依旧进行了一次http请求。

### 方式二

    存储当前已经加载的数据到本地（sessionStorage,localStorage）
    详情回退后,从本地取出数据，进行渲染（所以componentDid内部要判断本地是否已经存在数据，如果存在则return，不存在从服务器获取数据）

    这种方式回退时不需要再次进行http请求，也能满足下拉的情况，作者选择的就是这种方式。

### 方式三

    搭配react-redux实现，刷新页面数据不存在了，则正是我们想要实现的效果

## 渲染html标签

``` a

<div dangerouslySetInnerHTML={{ __html : this.props.mixins}}></div> 

```

## 异步页面渲染（实现）

一个页面对应一个js,减少首屏页面的加载时间

实现一个mixins组件

``` a

import React, {Component} from 'react';

const asyncComponent = (importComponent) => {
  return class extends Component {
    state = {
      component: null
    }
    componentWillMount(){
      console.log('componentWillMount')
      this.now = +new Date()
    }
    componentDidMount(){
      importComponent() //我们传进来的函数返回我们想要的组件B
        .then(cmp => {
          setTimeout(()=>{
            let now = +new Date();
            console.log(now - this.now)
            this.setState({component: cmp.default}); //把组件B存起来
          },3000)
        });
    }
    render() {
      const C = this.state.component; //渲染的时候把组件B拿出来
      return C ? <C {...this.props}/> : null; //返回的其实就是组件B，并且把传给A的属性也转移到B上
    }
  }
};

export default asyncComponent;

```

路由配置，其他的一致即可，打包之后就呈现出一个页面对应一个js

``` a

  const Main = asyncComponent(()=>{ return import('./main')})
  const Home = asyncComponent(()=>{ return import('./home')})
  const User = asyncComponent(()=>{ return import('./user')})


```
