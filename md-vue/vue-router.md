
# vue-router

## route

```js

import Router from 'vue-router'
import Routes from './vue.router.routes'

const router = new Router({

  scrollBehavior (to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      if (from.meta.keepAlive) {
        from.meta.savedPosition = document.body.scrollTop
      }
      return { x: 0, y: to.meta.savedPosition || 0 }
    }
  },
  routes: Routes
})

router.beforeEach( ( to, from, next ) => {
document.title = to.meta.title ;
next()

});

export default router


```

## routes

``` js
// 异步页面方式，减少首屏加载时间

const Login = r => require.ensure([], () => r(require('@/pages/PageLogin.vue')), 'PageLogin');
const Main = r => require.ensure([], () => r(require('@/pages/PageMain.vue')), 'PageMain');

const Indexes = r => require.ensure([], () => r(require('@/pages/PageExampleIndexes.vue')), 'PageExampleIndexes');
const Scroll = r => require.ensure([], () => r(require('@/pages/PageExampleScroll.vue')), 'PageExampleScroll');

export default  [
  { path: '*', redirect: '/Main'},
  { path: '/', redirect: '/Main'},
  { path: '/Login', name: 'Login', component:Login , meta: { keepAlive:false,title:"登录",isLogin:false ,} },
  { path: '/Main', name: 'Main', component:Main , meta: { keepAlive:false,title:"主页",isLogin:false ,} },
  { path: '/Indexes', name: 'Indexes', component:Indexes , meta: { keepAlive:false,title:"索引",isLogin:false ,} },
  { path: '/Scroll', name: 'Scroll', component:Scroll , meta: { keepAlive:false,title:"滚动",isLogin:false ,} },
]

```