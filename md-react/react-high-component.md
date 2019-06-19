
# 高阶组件 - mixins

## 高阶组件的引用

需要ES7的装饰器搭配，比较完美

``` scala

import React from 'react';

//import {IntervalEnhance} from './IntervalEnhance';

@IntervalEnhance // 不传参数
@IntervalEnhance('') // 传参数


class CartItem extends React.Component {
    render() {
        return (
            <article className="row large-4">

                <p className="large-12 column" >
                    <strong>Time elapsed for interval: </strong>
                    {this.props.seconds} ms // - 拿到的是高阶组件的state属性值

                </p>

            </article>
        );
    }
}

export default IntervalEnhance(CartItem);

```

## 高阶组件的实现

``` a
// 不传参

import React from 'react'


const MixinsPay = Component => {
  return class extends Component{
    constructor(props) {
      super(props)

    }

    componentDidMount() {
    }

    render(){
      return (
        <Component {...this.props} {...this.state} > </Component>
      )
    }
  }
}

export {
  MixinsPay
}

// 传参

import React, { Component }  from 'react'

const Hight = (title) => Component => {
  return class extends Component{
    constructor(props){
      super(props)
    }
    componentDidMount (){
      console.log(this.props)
      console.log(title)
    }
    render(){
      return (
        <Component { ... this.props }></Component>
      )
    }
  }
}

export default  Hight


```

## 高阶组件的解释

    1.ComposeComponent => class extends React.Comonent这句。还记得箭头函数吗？没错，这就是一个箭头函数。这个函数接受一个组件为输入参数，返回一个类。ComposedComponent就是输入参数，也就是需要包装增强的组件。export var IntervalEnhance就是把前面定义的函数命名为IntervalEnhance export出去给其他的模块使用。
    2.displayName设定为ComponentEnhancedWithIntervalHOC是为了在DevTools中方便调试。在DevTools里这个组件就会被叫做ComponentEnhancedWithIntervalHOC。
    3.组件生命周期不同阶段的回调。是React组件的内置方法。
    4.最有意思的就是这里了。这样的写法会把当前高阶组件的全部props和state都发送给CartItem，这样CartItem就可以取到this.state.seconds属性的值了。
    5.最后我们就需要修改CartItem组件的内部了。这样才能输出this.state.seconds的值
