
# react-transition-group

## 安装

npm install react-transition-group -S

## API

### Transition

过度组件（Transition）允许你用一个检点的声明行API，描述随着时间推移从一个组件状态到另一个组件的状态的转换。
最常用的是用来动画一个组件的安装和卸载，但也可以用来描述在适当的过渡状态。默认情况下，该组件不会更改其呈现的组件的行为，它只跟踪组件的“进入”和“退出”的状态。由你来为这些状态定义效果。

#### 示例

``` a

import React, { Component } from 'react'
import { Transition } from 'react-transition-group'

import './transition.css'

class Index extends Component {

state = {
  show: true,
  timeout: {
    enter: 300,
    exit: 300
  },
  isMove: false,
  appear: true
}

onEnter = () => {
  console.log('onEnter')
}
onEntering = () => {
  console.log('onEntering')
}
onEntered = () => {
  console.log('onEntered')
}
onExit = () => {
  console.log('onExit')
}
onExiting = () => {
  console.log('onExiting')
}
onExited = () => {
  console.log('onExited')
}

addEndListener = (node) => {
  console.log('addEndListener')
  console.log(node)
}

changeAnimate = () => (e) => {
  this.setState({
    show: !this.state.show
  })
}

render() {
  let { show, timeout, isMove, appear } = this.state

  const defaultStyle = {
    transition: `transform ${300}ms ease-in-out, opacity ${300}ms ease-in-out`,
    transform: 'translateX(100px)',
    opacity: '0'
  }

  const transitionStyles = {
    entering: { transform: 'translateX(100px)', opacity: '0' },
    entered: { transform: 'translateX(0px)', opacity: '1' },
    exiting: { transform: 'translateX(0px)', opacity: '1' },
    exited: { transform: 'translateX(100px)', opacity: '0' }
  };


  return (
    <div>
      study - react - transition - group Transition

      <button onClick={this.changeAnimate()}>进入/退出</button>

      <Transition
        onEnter={this.onEnter}
        onEntering={this.onEntering}
        onEntered={this.onEntered}
        onExit={this.onExit}
        onExiting={this.onExiting}
        onExtied={this.onExited}
        addEndListener={this.addEndListener}
        in={show} unmountOnExit={isMove} appear={appear} timeout={timeout}

      >
        {
          state => {
            console.log()
            console.log('state +  ' + state)
            return (
              <div className={`fade fade-${state}`} >
                <div>
                  <span>sdfjsdkdjksjkdjskdjksjds</span>
                </div>
                { state }
              </div> 
            )
          }
        }
      </Transition>


    </div>
  )
}
}

export default Index

// <div style={{ ...defaultStyle,...transitionStyles[state]}}>
//                     <div>
//                       哈哈，study Transition
//                     </div>
//                   </div> 

```

### CSSTransition

CSSTransition：在组件淡入appear，进场enter,出场exit时，CSSTransition组件应用了一系列className名来对这些动作进行描述。首先appear被应用到组件className上，接着添加“active”类名来激活CSS动画。在动画完成后，原class改变为done表明组件动画已经应用完成并加载完成。

当组件的in属性变为true时，组件的className将被赋值为example-enter，并在下一刻添加example-enter-active的CSS class名。这些都是基于className属性的约定。即：原组件带有className="animate-rotate"，则enter状态时，变为"animate-rotate-enter"

#### classNames | type:string

``` a

classNames={{
    appear: 'my-appear',
    appearActive: 'my-active-appear',
    enter: 'my-enter',
    enterActive: 'my-active-enter',
    enterDone: 'my-done-enter,
    exit: 'my-exit',
    exitActive: 'my-active-exit',
    exitDone: 'my-done-exit,
}}

```

#### in

控制组件应用动画的属性值，通常将一个react的组件state赋值给它，通过改变state，从而开启和关闭动画

#### onEnter

<Transition>组件的回调函数，当组件enter或appear时会立即调用。

#### onEntering

也是一个过渡组件的回调函数，当组件enter-active或appear-active时，立即调用此函数

#### onEntered

同样是回调函数，当组件的enter,appearclassName被移除时，意即调用此函数

#### onExit

当组件应用exit类名时，调用此函数

#### onExiting

当组件应用exit-active类名时，调用此函数

#### onExited

当组件exit类名被移除，且添加了exit-done类名时，调用此函数

#### 示例

``` a

// js

import React, { Component } from 'react'

import { CSSTransition  } from 'react-transition-group'
import './index.css'
import ReactDOM from 'react-dom';

class Index extends Component {
state = {
  show: true,
  timeout: 2000
}

componentDidMount = () => {

}
toggleBox = _ => {
  this.setState({
    show: !this.state.show
  })
}

render() {
  let { show, timeout } = this.state

  return (
    <div>
      study - react - transition - group
      <button onClick={this.toggleBox}>切换</button>
      <CSSTransition  in={show} classNames='test' timeout={3000}
      unmountOnExit

      onEntered = {(el) =>{ console.log(el)}}

      appear={true}

      //添加这个属性使组件第一次出现的时候（即页面刚加载时）也使用动画，对应css中的fade-appear和fade-appear-active样式
      >

        <div className="box" >
          <h1>测试动画效果滴。</h1>
          <div className="color-box">哈哈哈</div>
        </div>
      </CSSTransition>
    </div>
  )
}
}

export default Index

// css

.test-enter,
.test-appear {
display: block;
opacity: 0;
}
.test-enter-active,
.test-appear-active {
opacity: 1;
transition: opacity 3s;
}
.test-exit {
opacity: 1;
}
.test-exit-active {
opacity: 0;
transition: opacity 3s;
}
.test-exit-done {
display: none;
}

```