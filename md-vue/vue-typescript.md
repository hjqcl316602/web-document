## vue-typescript

## 缺点

- 当使用第三方库的时候，如 axios，进行再次封装的时候，参数的验证需要自己再写一次

```js
export function post(url: string, data?: any, configs?: any) {
  return new Promise((resolve, reject) => {
    instance.post(url, data, configs);
  });
}
// 比如configs的验证就显得麻烦了，自己再去写一套？
// 解决办法，引入axios提供的数据验证接口
import axios , { AxiosRequestConfig } from "axios";
export function post(url: string, data?: any, configs?: AxiosRequestConfig) {
  return new Promise((resolve, reject) => {
    instance.post(url, data, configs);
  });
}
```

## vue-property-decorator

### model

子组件

```js
<div class="hello">
  <input type="checkbox" :checked="checked" @change="changed" />
</div>

import { Component, Vue, Model} from "vue-property-decorator";
@Component
export default class HelloWorld extends Vue {
  @Model("change", {
    type: Boolean
  })
  checked!: boolean;
  @Emit("change")
  changed(ev: any) {
    return ev.target.checked;
  }
}
```

### Inject/Provide

子组件注入到的数据是最近的祖先元素的数据，即组件之间的通信，该方法使用场景不多，可以通过 vuex 替换

父组件

```js
import { Component, Vue, Provide } from "vue-property-decorator";
@Component
export default class Home extends Vue {
  @Provide("foo")
  foo: string = "wuyao";
}
```

子组件

```js
import { Component, Vue, Inject } from "vue-property-decorator";
@Component
export default class HelloWorld extends Vue {
  @Inject("foo") foo: string;
}
```

## vuex

### 用例

store.ts

```js
import Vue from "vue";
import Vuex, { MutationTree, ActionTree } from "vuex";

Vue.use(Vuex);

interface State {
  app: string;
  id: number;
  login?: boolean;
}

let state: State = {
  app: "vue-typescript",
  id: 11,
  login: false
};
let mutations: MutationTree<any> = {
  changeLogin(state, value): void {
    state.login = value;
  }
};
let actions: ActionTree<State, any> = {
  changeLogin({
    state: State,
    rootState,
    commit,
    dispatch,
    getters,
    rootGetters
  }): void {
    setTimeout(() => {
      state["login"] = true;
    }, 2000);
  }
};

export default new Vuex.Store({
  state: state,
  mutations: mutations,
  actions: actions
});
```

[name].vue

```js
import { Component, Prop, Vue } from "vue-property-decorator";
import { State, Mutation, Action } from "vuex-class";

@Component
export default class HelloWorld extends Vue {
  @State login!: boolean;
  @Action changeLogin: (value: boolean) => void;
  @Prop() private msg!: string;

  handler() {
    this.changeLogin(true);
  }
  mounted() {
    console.log(this.login);
  }
}

```

### 报错

#### has no initializer and is not definitely assigned in the constructor

我们在 TypeScript 里面声明出来的 userName 其实是希望它符合一个 string 类型的，但是如果你没有为当前变量在构造器或者初始化方法中赋予默认值，那么他就有可能变为 undefined，而 undefined 并不符合我们的期望

- 你可以设置 strictPropertyInitialization:false 取消这个限制（不建议）
- 你也可以在构造器里面为变量赋予一个默认值(建议做法）
- 也许你是通过辅助方法或者依赖注入等动态引入(TypeScript 只能处理静态分析)

```js
export default class HelloWorld extends Vue {
  @State login!: boolean; // 添加一个‘!’
}
```

#### Property 'handler' does not exist on type 'Vue'

调用子组件的方法时报错

```js
//父组件
mounted(){
  // 方式一
  let hello: any = this.$refs.hello;
  hello.handler();
  // 方式二
  (this.$refs["hello"] as any).handler()
}
```

## 使用 lodash

安装 npm install lodash -save | npm install @type/lodash

## 安装的插件

- vue-property-decorator
- vuex-class uex 相关
- lodash-decorators
- vue/types

### eslint

文件 .eslintrc.js

#### 提示 console.log 错误

```js
module.exports = {
  root: true,
  env: {
    node: true
  },
  extends: ["plugin:vue/essential", "eslint:recommended"],
  rules: {
    "no-console": process.env.NODE_ENV === "production" ? "error" : "off",
    "no-debugger": process.env.NODE_ENV === "production" ? "error" : "off"
  }
};
```

#### 提示导出 export 错误

注释掉下面注释部分
否则 export default class Person{} => class Person{} + export default Person

```js
module.exports = {
  root: true,
  env: {
    node: true
  },
  extends: ["plugin:vue/essential", "eslint:recommended"],
  rules: {
    "no-console": process.env.NODE_ENV === "production" ? "error" : "off",
    "no-debugger": process.env.NODE_ENV === "production" ? "error" : "off"
  }
  // parserOptions: {
  //   parser: "babel-eslint"
  // }
};
```

#### 提示 async 错误

安装 babel-eslint
npm install babel-eslint --save-dev
在.eslintrc.js 文件中添加

```js
parserOptions: {
  parser: "babel-eslint",
}
```

```

```
