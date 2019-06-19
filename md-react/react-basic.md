# react-basic

## 注意点

* 标签里用到的，for 要写成htmlFor，因为for已经成了关键字。

* componentWillUpdate中可以直接改变state的值，而不能用setState。

* 如果使用es6class类继承react的component组件，constructor中必须调用super，因为子类需要用super继承component的this，否则实例化的时候会报错。

* setState()是异步的,this.setState()会调用render方法，但并不会立即改变state的值，state是在render方法中赋值的。（这里我描述的不对，多谢评论区大神指点，setState只是将任务交给任务队列，本身没有执行任务）所以执行this.setState()后立即获取state的值是不变的。同样的直接赋值state并不会出发更新，因为没有调用render函数

* 组件命名的首字母必须是大写，这是类命名的规范

## 生命周期

* componentWillMount : 在渲染前调用,在客户端也在服务端。

* componentDidMount : 在第一次渲染后调用，只在客户端。之后组件已经生成了对应的DOM结构，可以通过this.getDOMNode()来进行访问。 如果你想和其他JavaScript框架一起使用，可以在这个方法中调用setTimeout, setInterval或者发送AJAX请求等操作(防止异步操作阻塞UI)。

* componentWillReceiveProps : 在组件接收到一个新的 prop (更新后)时被调用。这个方法在初始化render时不会被调用。

* shouldComponentUpdate : 返回一个布尔值。在组件接收到新的props或者state时被调用。在初始化时或者使用forceUpdate时不被调用。 
    可以在你确认不需要更新组件时使用。

* componentWillUpdate : 在组件接收到新的props或者state但还没有render时被调用。在初始化时不会被调用。

* componentDidUpdate : 在组件完成更新后立即调用。在初始化时不会被调用。

* componentWillUnmount : 在组件从 DOM 中移除之前立刻被调用

## props默认值和类型检查

```   es7

static defaultProps = {
  age : 2
}

static propTypes = {
  age : PropTypes.number.isRequired
}

或者

Index.defaultProps = {
    age : 2
  }
  
  Index.propTypes = {
    age : PropTypes.number.isRequired
  }
```

## 本地图片的引用

``` 本地图片的引用
1. <img src={require('../img/icon1.png')} alt="" />
2.   import search from '../img/search.png'
    import user from '../img/user.png'

    <img src={search} alt="" />
    <img src={user} alt="" />

3. <img src='http://localhost:3000/my-project/src/img/icon1.png' alt="" />
4. 背景图片的引用
const divStyle = {
    color: 'red',
    backgroundImage: 'url(' + imgUrl + ')',
        // 或者 background: `url${require("1.jpg")}`
};

function HelloWorldComponent() {
    return <div style={divStyle}>Hello World!</div>;
}

```

## 绑定事件

### 有参数的传递的时候

```javascript

onClick={ this.handler('ffff')}

handler = (value) => () => {
  console.log(value)
}

```

### 没有参数的传递的时候
  
```javascript

onClick={ this.handler}

handler =  () => {
  console.log(value)
}

```

### 组件上处理

  onClick={ () => this.handler(value) }

  handler(value){
    console.log(value)
  }

## 条件渲染

### 方式一

```javascript
{
  qr.show
  ? <QRcode value={qr.value} size={qr.size}> </QRcode>
  : <img src={ require('../images/img-code-ali.png')} alt="" className="rp-img--cover"/>  
}

```

### 方式二

``` javascript

 {
    (()=>{
        if(qr.show){
          return <QRcode value={qr.value} size={qr.size}> </QRcode>
        }else{
          return <img src={ require('../images/img-code-ali.png')} alt="" className="rp-img--cover"/>
        }
    })()
}
```

### 方式三

该方式必须使用在父组件中有this.props.children的使用，换成div原声的元素标签就不行的

```javascript

  <Transition timeout = {100}>
    {

      () => {
        return (
          <div>
            <span>sdnsdjks</span>
          </div>
        )
      }
    }
  </Transition>

```

### 方式四（无状态方式）

```javascript

<Getting type = { 3 }></Getting>


function Button(props){
  return <button>{ props.name }</button>
}

function Span(props){
  return <span>{ props.name }</span>
}

function Div(props){
  return <div>{ props.name }</div>
}

function Getting(props){
    switch(props.type){
      case 1 : return <Button name = { 'huangjunquan ' }></Button>
      case 2 : return <Span name = { 'huangjunquan 2' }></Span>
      case 3 : return <Div name = { 'huangjunquan 4' }></Div>
      default : return null
    }
}
  
  ```

### 方式五

  渲染多个子节点

``` javascript
  <ul>
      { [<li>123</li>,<li>123</li>,<li>123</li>] }
  </ul>
```

## react创建组件的三种方式

### 函数式定义的无状态的组件

    这种组件只负责根据传入的props来展示，不涉及到要state状态的操作
    特点
        1. 组件不会被实例化，整体渲染性能得到提升
        2.组件不能访问this对象
        3.组件无法访问生命周期的方法
        4.无状态的组件只能访问输入的props，同样的props会得到同样的结果，不会产生副作用的

```javascript

import React,{Component} from 'react';
export default  function Bottom(props){
    let{name} = props
    const sayHi = () => {
        console.log(`Hi ${name}`);
    }
    return (
        <div>

            <h1>Hello, hahah {name}</h1>

            <button onClick ={sayHi}>Say Hi</button>
        </div>
    )
}

```

### es5原生方式React.createClass定义的组件

``` javascript
var InputControlES5 = React.createClass({
    propTypes: {//定义传入props中的属性各种类型
        initialValue: React.PropTypes.string
    },
    defaultProps: { //组件默认的props对象
        initialValue: ''
    },
    // 设置 initial state
    getInitialState: function() {//组件相关的状态对象
        return {
            text: this.props.initialValue || 'placeholder'
        };
    },
    handleChange: function(event) {
        this.setState({ //this represents react component instance
            text: event.target.value
        });
    },
    render: function() {
        return (
            <div>
                Type something:
                <input onChange={this.handleChange} value={this.state.text} />
            </div>
        );
    }
});
InputControlES6.propTypes = {
    initialValue: React.PropTypes.string
};
InputControlES6.defaultProps = {
    initialValue: ''
};
```

    缺点：
        1.React.createClass会自绑定函数方法（不像React。Component只关心需要绑定的函数）导致不必要的性能开销，增加代码过时的可能性
        2.React.createClass的mixins不够自然、直观，React.component形式非常适合高阶组件，它以更直观的形式展示了比mixins更强大的功能

### es6形式的extends React.Component定义的组件

与React.createClass的区别

* 函数this的绑定

React.createClass创建的组件，其每一个成员函数的this都有React自动绑定，任何时候使用，直接使用this.method即可，函数中的this会被正确设置
React.Component创建的组件，其成员函数不会自动绑定this，需要开发者手动绑定，否则this不能获取当前组件实例对象
当然，React.Component有三种手动绑定方法：可以在构造函数中完成绑定，也可以在调用时使用method.bind(this)来完成绑定，还可以使用arrow function来绑定。拿上例的handleClick函数来说，其绑定可以有：

```javascript

constructor(props) {
  super(props);
this.handleClick = this.handleClick.bind(this); //构造函数中绑定
}
<div onClick={this.handleClick.bind(this)}></div> //使用bind来绑定
<div onClick={()=>this.handleClick()}></div> //使用arrow function来绑定

```

* 组件属性类型propType及其默认props属性defaultProps配置不同

React.createClass在创建组件时，有关组件props的属性类型及组件默认的属性会作为组件实例的属性来配置，其中defaultProps是使用getDefaultProps的方法来获取默认组件属性的

```javascript
const TodoItem = React.createClass({
    propTypes: { // as an object
        name: React.PropTypes.string
    },
    getDefaultProps(){   // return a object
        return {
            name: ''
        }
    }
    render(){
        return <div></div>
    }
})
```

React.Component在创建组件时配置这两个对应信息时，他们是作为组件类的属性，不是组件实例的属性，也就是所谓的类的静态属性来配置的。对应上面配置如下：

``` javascript
class TodoItem extends React.Component {
    static propTypes = {//类的静态属性
        name: React.PropTypes.string
    };

    static defaultProps = {//类的静态属性
        name: ''
    };

    ...
}
```

* 组件初始状态state的配置不同

React.createClass创建的组件，其状态state是通过getInitialState方法来配置组件相关的状态；
React.Component创建的组件，其状态state是在constructor中像初始化组件属性一样声明的。

``` javascript
const TodoItem = React.createClass({
    // return an object
    getInitialState(){ 
        return {
            isEditing: false
        }
    }
    render(){
        return <div></div>
    }
})
class TodoItem extends React.Component{
    constructor(props){
        super(props);
        this.state = { // define this.state in constructor
            isEditing: false
        }
    }
    render(){
        return <div></div>
    }
}
```

* Mixins的支持不同

Mixins(混入)是面向对象编程OOP的一种实现，其作用是为了复用共有的代码，将共有的代码通过抽取为一个对象，然后通过Mixins进该对象来达到代码复用。具体可以参考React Mixin的前世今生。

React.createClass在创建组件时可以使用mixins属性，以数组的形式来混合类的集合。

``` javascript

var SomeMixin = {  
doSomething() {

}
};
const Contacts = React.createClass({  
mixins: [SomeMixin],
handleClick() {
    this.doSomething(); // use mixin
},
render() {
    return (
    <div onClick={this.handleClick}></div>
    );
}
});

```

但是遗憾的是React.Component这种形式并不支持Mixins，至今React团队还没有给出一个该形式下的官方解决方案；但是React开发者社区提供一个全新的方式来取代Mixins,那就是Higher-Order Component创建的组件，其状态state是在constructor中像初始化组件属性一样声明的
