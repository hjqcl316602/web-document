# vue-vuex

## vuex - basic

```js

export default {
  namespaced: true,

  state:{
    isLogin:false,
    userMessage:{},
  },

  getters:{
    login:(state,getters) =>{
      return state.isLogin
    }
  },


  mutations:{
    ['change/login/status'](state,status){
      state.isLogin = status
    },
  },

  actions:{
    ['change/login/status']({commit,state,dispatch},options){
      console.log(options)
      dispatch('change/login/status/2').then(()=>{
        setTimeout(()=>{
          state.isLogin = !state.isLogin
        },2000)
      })
    },
    ['change/login/status/2']({commit,state,dispatch}){
      return new Promise((resolve,reject)=>{
        setTimeout(()=>{
          //commit('change/login/status',!state.isLogin);
          state.isLogin = !state.isLogin
          resolve()
        },2000)
      })
    },
  },

  

}


```

## vuex - index.js

```js

import basic from './modules/basic'
import login from './modules/login'

import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state:{
    name:'黄军泉'
  },
  modules:{
    basic,
    login
  },
  namespaced:true,
  strict:process.env.NODE_ENV !== 'production'
})

```

## 页面 - app.vue

```js

<template>
  <div id="app">
     <button @click='changeLoginStatus2({ name : 2} )' >单击我</button>

     wo shi app
     {{ isLogin }}
     {{ login }}
     {{ loginIsLogin }}
  </div>
</template>


<script type="text/ecmascript-6">

import {mapState,mapGetters,mapMutations,mapActions} from 'vuex';

export default {
  name: 'app',
  mounted(){
    console.log(this.$store)
  },

  computed:{
    ...mapGetters('basic',['login']),
    ...mapState('basic',['isLogin']),
    ...mapState('login',{loginIsLogin : 'isLogin'})
  },


  data(){
    return{
    }
  },
  methods:{
    ...mapMutations('basic',{
      changeLoginStatus:'change/login/status'
    }),
    ...mapActions('basic',{
      changeLoginStatus2:'change/login/status'
    })
  }
  ,
  watch:{

  }
}
</script>
<style>

</style>


```

## state

### mapState 辅助函数

当一个组件需要获取多个状态时候，将这些状态都声明为计算属性会有些重复和冗余。为了解决这个问题，我们可以使用 mapState 辅助函数帮助我们生成计算属性，让你少按几次键：

```js

// 在单独构建的版本中辅助函数为 Vuex.mapState
import { mapState } from 'vuex'

export default {
  
  computed: mapState({
    // 箭头函数可使代码更简练
    count: state => state.count,

    // 传字符串参数 'count' 等同于 `state => state.count`
    countAlias: 'count',

    // 为了能够使用 `this` 获取局部状态，必须使用常规函数
    countPlusLocalState (state) {
      return state.count + this.localCount
    }
  })
}

// 方式二

computed: mapState([
  // 映射 this.count 为 store.state.count
  'count'
])

// 方式三

computed: {
  localComputed () { /* ... */ },
  // 使用对象展开运算符将此对象混入到外部对象中
  ...mapState({
    // ...
  })
}

```

## getters(对state进行数据的过滤)

### mapGetters 辅助函数

## Mutation(事件)

### 注意事项

既然 Vuex 的 store 中的状态是响应式的，那么当我们变更状态时，监视状态的 Vue 组件也会自动更新。这也意味着 Vuex 中的 mutation 也需要与使用 Vue 一样遵守一些注意事项：

* 最好提前在你的 store 中初始化好所有所需属性。

* 当需要在对象上添加新属性时，你应该使用 Vue.set(obj, 'newProp', 123), 或者以新对象替换老对象。

* 必须是同步函数

### mapMutations 辅助函数

## strict

在严格模式下，无论何时发生了状态变更且不是由 mutation 函数引起的，将会抛出错误。这能保证所有的状态变更都能被调试工具跟踪到
开发环境与发布环境
**不要在发布环境下启用严格模式！**严格模式会深度监测状态树来检测不合规的状态变更——请确保在发布环境下关闭严格模式，以避免性能损失。

类似于插件，我们可以让构建工具来处理这种情况：

```js

const store = new Vuex.Store({
  // ...
  strict: process.env.NODE_ENV !== 'production'
})

```
