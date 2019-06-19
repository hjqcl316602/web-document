
# react-router

# API

## BrowserRouter

### getUserConfirmation 确定是否跳转的函数

必须和Prompt组件配合使用

``` a

const ConFirmComponent = () => (
      <div>
          {message}
          <button onClick={() => {callback(true);ReactDOM.unmountComponentAtNode(document.getElementById('root1'))}}>确定</button>
          <button onClick={() => {callback(false);ReactDOM.unmountComponentAtNode(document.getElementById('root1'))}}>取消</button>
      </div>
  )
  ReactDOM.render(
      <ConFirmComponent />,
      document.getElementById('root1')
  )

<BrowserRouter getUserConfirmation={getUserConfirmation}>
  <Prompt message="Are you sure you want to leave?" />
</BrowserRouter>

```

## MemoryRouter

## Prompt

## Redirect

使用 <Redirect> 会导航到一个新的位置。新的位置将覆盖历史堆栈中的当前条目，例如服务器端重定向

``` a
    import { Route, Redirect } from 'react-router-dom';

    <Route exact path="/" render={() => (
      loggedIn ? (
        <Redirect to="/dashboard" />
      ) : (
        <PublicHomePage />
      )
    )} />

```

### to :string

``` a

    <Redirect to="/somewhere/else" />

```

### to:object

``` a
    <Redirect to={{
      pathname: '/login',
      search: '?utm=your+face',
      state: {
        referrer: currentLocation
      }
    }} />

```

### push:bool

重定向是否会将新的位置推入到历史记录中

``` a

    <Redirect push to="/somewhere/else" />

```

### from

### exact(完全匹配)

### strict(严格匹配)

## Route

每个 Route 标签都对应一个UI页面,它的职责就是当页面的访问地址与 Route 上的 path 匹配时，就渲染出对应的 UI 界面。
而 <Route component={Header}/> 是没有 path 的,这意味着在每个页面都会渲染出 Header 组件.

## Router

browserHistory h5的history
hashHistory 老版本浏览器的history
memoryHistory node环境下的history，存储在memory中

## StaticRouter

## Switch

## generatePath

## matchPath

## withRouter

# 示例（暂时相对完善）

## 路由配置

把入口页面放在了路由中，以备入口时需要进行路由跳转判断

``` a
import React from 'react'
import Route from './enRoute'

import { Switch, Redirect, HashRouter } from 'react-router-dom'

import { Pay, Errors, PayStatus, Index } from './routers'


export default class Router extends React.Component {
  render() {
    return (
      <HashRouter>
        <Switch>
          <Route title='支付平台' render={props => (
            <Index {...props}>
              <Switch> 
                <Route exact path="/" component={Errors} />
                <Route path="/pay/:accessToken" component={Pay} title = "支付类型" />
                <Route path="/status/:status" component={PayStatus} title = "支付反馈" />
                <Route path="/error" component={Errors}  title = "支付错误" />
                <Route render={() => <Redirect to="/error" />} />
              </Switch>
            </Index>
          )}
          />
        </Switch>
      </HashRouter>
    )
  }
}


```

## 页面导入导出

``` a
import asyncComponent from './async'

//import Index from '../../pages/index';
//import Errors from '../../pages/PageError'; 
//import Pay from '../../pages/PagePays';
//import PayStatus from '../../pages/PagePayStatus';
//console.log(async)
const Index = asyncComponent(()=>{ return import('../../pages/index')})
const Errors = asyncComponent(()=>{ return import('../../pages/PageError')})
const Pay = asyncComponent(()=>{ return import('../../pages/PagePays')})
const PayStatus = asyncComponent(()=>{ return import('../../pages/PagePayStatus')})


export  {
  Index,
  Errors ,
  PayStatus,
  Pay
}

```

## 自定义Route

  用来处理一些页面跳转所需的业务，比如标题设置，登录验证等

``` a
import React, { Component }  from 'react'
import {  Route,withRouter    } from 'react-router-dom'
  
class EnRoute extends Component {

  constructor(props){
    super(props)
    //console.log(props)
  }

  componentWillMount(){ 
    this.setTile(this.props.title )
  }
  componentWillUpdate(){ 
    this.setTile(this.props.title )
  }
  
  setTile = (title) =>{
    console.log(title)
    document.title = title

  }

  render() { 
    return (
        <Route {...this.props}></Route>
    )
  }
}

export default withRouter(EnRoute)

```  

## 按需加载


``` f
import React, {Component} from 'react';

const asyncComponent = (importComponent) => {
return class extends Component {
  state = {
    component: null
  }
  componentWillMount(){ 
    this.now = +new Date()
  }
  componentDidMount(){
    importComponent() //我们传进来的函数返回我们想要的组件B
      .then(cmp => {
        console.log(+new Date - this.now )
        this.setState({component: cmp.default}); //把组件B存起来 
      });
  }
  
  render() {
    const C = this.state.component; //渲染的时候把组件B拿出来
    return C ? <C {...this.props}/> : null; //返回的其实就是组件B，并且把传给A的属性也转移到B上
  }
}
};

export default asyncComponent

``