
# mobx mobx-react

## 安装

``` a

npm install mobx mobx-react -S

```

## 简单示例

### 绑定-用于观察数据的变化

```js

import React, { Component } from 'react';
import './App.css';
import { Radio } from '@/component';
import Index from './page'
import mobx1 from '@/js/mobx/mobx1'
import mobx2 from '@/js/mobx/mobx2'
import mobx3 from '@/js/mobx/mobx3'
import mobx4 from '@/js/mobx/mobx4'

import { observer } from 'mobx-react';
@observer
class App extends Component {
  
  componentDidMount(){
    console.log(this.props)
  }



  render() {
    return (
      <div className="App">
          dskdfjks
         <Index mobx1={ mobx1 } mobx2={ mobx2 } mobx3={ mobx3 } mobx4={ mobx4 } ></Index>
      </div>
    );
  }
}

export default App;

```

### 数据-mobx

* 方式一、 更加简洁的写法

``` js

import {action,observable } from 'mobx'

export default observable({
  number : '邓猴子',
  getName(number){
    this.number = number
    return this.number
  }
},{
  getName:action,
})

```

* 方式二、 使用es7装饰器

``` js

import { computed,action,observable} from 'mobx'

class Index {
  @observable
  name = 'huangjunan'

  @computed
  get fullName(){
    return this.name + '1212121'
  }

  @action
  changeName(){  // 改方法不能通过 let { changeName } = this.props.mobx 得到,因为该方法是挂载到原型上面的
    this.name = '黄军泉'
  }
}

console.log(new Index())

export default new Index()

```

* 方式三、不使用es7装饰器

```js

import { computed,action,observable,decorate} from 'mobx'

class Index {
  
  name = 'huangjunan'

  
  get fullName(){
    return this.name + '1212121'
  }

  changeName(){  
    this.name = '黄军泉'
  }
}

console.log(new Index())

decorate(Index,{
  name:observable,
  fullName:computed,
  changeName:action
})


export default new Index()

```

### 视图-需要被观察改变数据的页面

* 使用es7装饰器的方式

``` js

import React from 'react'
import { observer } from 'mobx-react'

@observer
class Index extends React.Component{
  constructor(props){
    super(props)
  }
  componentDidMount(){
  }
  handler = () => () =>{
    this.props.mobx.changeName()
    console.log(this.props.mobx.changeName)
  }
  render(){
    let { name ,fullName } = this.props.mobx
    return (
      <div>
        I am Index { name } and { fullName }
        <button onClick={ this.handler() }>改变名字</button>
      </div>
    )
  }
}
export default  Index

```

* 不使用es7装饰器的方式

```js

import React from 'react'
import { observer } from 'mobx-react'

let Index = observer(class Index extends React.Component{
  constructor(props){
    super(props)
  }
  componentDidMount(){
    console.log(observer)
  }
  handler = () => () =>{
    this.props.mobx.changeName()
    console.log(this.props.mobx.changeName)
  }
  render(){
    let { user,mobx } = this.props;

    return (
      <div>
        I am Index { name } and { fullName }
        <button onClick={ this.handler() }>改变名字</button>
         <button onClick={ () => user.getName('sadjsdjshdhs') }>改变名字</button>
      </div>
    )
  }
})
export default  Index

```

### 注意

* mobx的action不能通过let { changeName } = this.props.mobx的方式得到，因为getName 相当于被重新赋值了，直接调用，方法里面的this指向不再是user，需要手动绑定才行，这样的话，相对复杂，没有一定的意义，可直接调用this.props.user.getName()

* 配置装饰器后会出现报错现象，暂时没能解决，暂时不使用es7装饰器

## mobx-react和react-redux的区别

* 均是管理js的应用的状态

* redux拥抱FP（函数式编程）

* redux是不可变的，应该总是返回新的state而不是修改state，即不应该执行state的修改或依据对象引用的更改
  错：state.authors.push(action.author)
  对：[...state.authors,action.author]

* mobx是可以多个store,但redux一个store是最佳的实践

* mobx 更加倾向mixins的感觉，也和vue有一定的相似之处，配置更加的简单