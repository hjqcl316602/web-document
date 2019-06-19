
# react-optimization 性能优化

## 打包时忽略第三方库

充分利用浏览器的缓存，减少不必要的加载，打包速度也快了不少

* index.html

``` a

<script src='lib/react.production.min.js'></script>
<script src='lib/react-dom.production.min.js'></script>

```

* webpack.config.js

``` a

externals:{
  'react':'React', // 'window.React' 之前是需要，但是现在不需要
  'react-dom':'ReactDOM'
},

```

## 按需加载（不同的页面加载不同的js）

## 模块拆分

## 减少不必要的渲染

``` a

import { is ,fromJS} from 'immutable'

// 深对比

shouldComponentUpdate(nextProps,nextState){
    return !is(fromJS(nextState),fromJS(this.state)) || !is(fromJS(nextProps),fromJS(this.props))
}

// 浅对比

shouldComponentUpdate(nextProps = {}, nextState = {}) {
    const thisProps = this.props || {}, thisState = this.state || {}
    // 如果参数的长度不一致，更新
    if (Object.keys(thisProps).length !== Object.keys(nextProps).length ||
    Object.keys(thisState).length !== Object.keys(nextState).length) {
    return true;
    }
        // 如果参数的值不一致，更新
    const flag1 = Object.keys(nextProps).some(item => !is(thisProps[item], nextProps[item]))
    if (flag1) return true
        // 如果state值不一致，更新
    const flag2 = Object.keys(nextState).some(item => !is(thisState[item], nextState[item]))
    if(flag2) return true

    return false;
}

```