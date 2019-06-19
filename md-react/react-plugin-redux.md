
# redux

## 三大原则

### 单一数据源
  
  使用单一数据源的好处是在于整个应用都保存在一个对象中，这样方便我们随时提取整个应用的状态进行持久化

### 状态是只读的

  定义一个 reducer，它的功能是根据当前触发的action对当前应用的状态进行迭代，这里并没有直接修改应用的状态，而是返回了一份全新的状态。
  Redux 提供的 createStore 方法会根据 reducer生成store，可以利用store.dispatch方法来达到修改状态的目的

### 状态的修改均由纯函数完成

  在Redux里，我们通过定义 reducer 来确定状态的修改，而每一个 reducer都是纯函数，这意味着它没有副作用，即接受一定的输入，必定会得到一定的输出

## API

### applyMiddleware(...middlewares)

使用包含自定义功能的 middleware 来扩展 Redux 是一种推荐的方式。Middleware 可以让你包装 store 的 dispatch 方法来达到你想要的目的。同时， middleware 还拥有“可组合”这一关键特性。多个 middleware 可以被组合到一起使用，形成 middleware 链。其中，每个 middleware 都不需要关心链中它前后的 middleware 的任何信息


### bindActionCreators(actionCreators,dispatch)

把一个 value 为不同 action creator 的对象，转成拥有同名 key 的对象。同时使用 dispatch 对每个 action creator 进行包装，以便可以直接调用它们

### combineReducers

合并reducer

```  h

import reducerName from './reducer.name';
import reducerAge from './reducer.age';

import { createStore , applyMiddleware ,combineReducers} from 'redux';
export default createStore(combineReducers({reducerAge,reducerName})) // 必须是对象的

```

### compose(...functions)

从右到左来组合多个函数。

这是函数式编程中的方法，为了方便，被放到了 Redux 里。
当需要把多个 store 增强器 依次执行的时候，需要用到它

``` j

import { createStore, combineReducers, applyMiddleware, compose } from 'redux'
import thunk from 'redux-thunk'
import DevTools from './containers/DevTools'
import reducer from '../reducers/index'

const store = createStore(
  reducer,
  compose(
    applyMiddleware(thunk),
    DevTools.instrument()
  )
)
```

### createStore

  ``` g
import { createStore } from 'redux'

function todos(state = [], action) {
  switch (action.type) {
    case 'ADD_TODO':
      return state.concat([action.text])
    default:
      return state
  }
}

let store = createStore(todos, ['Use Redux'])

store.dispatch({
  type: 'ADD_TODO',
  text: 'Read the docs'
})

console.log(store.getState())

  ```

####  参数

* reducer (Function): 接收两个参数，分别是当前的 state 树和要处理的 action，返回新的 state 树。

* [preloadedState] (any): 初始时的 state。 在同构应用中，你可以决定是否把服务端传来的 state 水合（hydrate）后传给它，或者从之前保存的用户会话中恢复一个传给它。如果你使用 combineReducers 创建 reducer，它必须是一个普通对象，与传入的 keys 保持同样的结构。否则，你可以自由传入任何 reducer 可理解的内容。

* enhancer (Function): Store enhancer 是一个组合 store creator 的高阶函数，返回一个新的强化过的 store creator。这与 middleware 相似，它也允许你通过复合函数改变 store 接口。
  
## 实现过程

### action

可以不单独书写action，显得麻烦了的点，也没有实质意义的感觉

``` g
  const raiseAction = { type: 'raise' }
  const reduceAction = { type: 'reduce' }
```

### reducer

``` g
function counter(state = { count: 0 }, action) {
  let { count } = state;
  let { type } = action
  if (type === 'raise') {
    return {
      count: count + 1
    }
  } else if (type === 'reduce')
#     return {
      count: count - 1
    }
  else {
    return state
  }
}
```

### store

const store = createStore(counter)

#### store.getState()

store.getState() 返回应用当前的 state 树。它与 store 的最后一个 reducer 返回值相同

#### store.disptch()

store.disptch()分发 action。这是触发 state 变化的惟一途径

#### store.subscribe()

添加一个变化监听器。每当 dispatch action 的时候就会执行，state 树中的一部分可能已经变化。你可以在回调函数里调用 getState() 来拿到当前 state
let unsubcribe = store.subscribe(function(){ console.log(store.getState())}) // 返回一个方法，注销监听事件
unsubcribe() // 注销监听事件

### mapStateToProps - 让组件能访问props中的全局状态state

``` g

function mapStateToProps(state) {
  return {
    value: state.count
  }
}

```

### mapDispatchTpProps

让组件能访问方法

``` g

function mapDispatchTpProps(dispatch) {
  return {
    onRaiseCount: () => { dispatch(raiseAction) },
    onReduceCount: () => { dispatch(reduceAction) }
  }
}

```

可以直接在组件中使用dispatch的方式

```  g

changeName(name){
  let { dispatch } = this.props;
  this.props.dispatch({ type:'CHANGE',name:name})
}

```

### connect

``` g

let App = connect(mapStateToProps, mapDispatchTpProps)(Counter)

```

### 注意

* 如果 state 是普通对象，永远不要修改它！比如，reducer 里不要使用 Object.assign(state, newData)，应该使用 Object.assign({}, state, newData)。这样才不会覆盖旧的 state。如果可以的话，也可以使用 对象拓展操作符（object spread spread operator 特性中的 return { ...state, ...newData }

# react-redux

## Provider

## ReactReduxContext

## connectAdvanced

## connect