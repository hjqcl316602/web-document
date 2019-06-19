# react redux-thunk

## 使用姿态

```  t

// store中

import thunkMiddleware from 'redux-thunk'
import reducerName from './reducer.name';
import reducerAge from './reducer.age';

import { createStore , applyMiddleware ,combineReducers ,compose} from 'redux';
const reducer = combineReducers({reducerName,reducerAge})

export default createStore(
  reducer,
  applyMiddleware(thunkMiddleware)  // 在使用了redux-thunk之后，dispatch方法就可以接受一个函数了
)

// actions

export const getName  = (data) =>{
  return (dispatch,getState) =>{

    // getState(),可以得到state数据
    fly.get('http://103.91.217.22/exchange/favor/find').then((repsonse)=>{
        console.log(repsonse)
        dispatch({ type :'CHANGE',name :repsonse.message })
    })
  }
}

// 组件使用

import { getName } from './action.name'
this.props.dispatch( getName())

```

## 实现原理

``` g

function createThunkMiddleware(extraArgument) {
    return function (_ref) {
    var dispatch = _ref.dispatch,
        getState = _ref.getState;
    return function (next) {
            //最终的dispatch
            //next就是接收的store.dispatch参数,为上一个中间件改造过的dispatch
      return function (action) {
        if (typeof action === 'function') {
          return action(dispatch, getState, extraArgument);
        }

        return next(action);
      };
    };
    };
}

var thunk = createThunkMiddleware();
thunk.withExtraArgument = createThunkMiddleware;

export default thunk;

1.非function不处理，将action传给下一个中间件，最终会根据传入的action计算相应的reducers
2.function类型的action，自动触发函数，并将store.dispatch传入
再结合开始介绍的thunk用法，我们就明白了thunk的原理，可以在actionCreators里通过返回一个函数，然后就可以在函数里编写某些异步操作了，待异步操作结束，最后通过传入的store.dispatch，发出action通知给Store要进行状态更新

```
