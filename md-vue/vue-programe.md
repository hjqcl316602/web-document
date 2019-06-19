# programe 解决方案

## 同时监听两次参数

```js
data() {
  return {
    city: '',
    country: ''
  }
},
computed: {
  address() {
    const { city, country } = this
    return {
      city,
      country
    }
  }
},
watch: {
  address: {
    handler: function(val) {
      console.log('address change: ', val)
    },
    deep: true
  }
}
```

## 登录

若一个接口调用返回 004,需要登录，跳转到登录页面，会出现多个接口到达这个页面，而导致不能回到初始页面，需要使用销毁之前的页面，从而达到回到之前页面重新刷新该页面，使用 window.location.reload()强制刷新页面，会出现当返回时还会到该页面，即会记录历史页面，交互效果差。
如果一个页面多个接口需要按步加载接口，因为多个接口出现返回 004，达到登录页面会出现问题，即不能正常返回；也可以通过路由进入时做个判断，如果出现 to.name == from.name，则不进行 next()，可以将其拦下

```js
if (to.meta.isLogin && !sessionStorage.getItem("login")) {
  next({
    path: "/MainLogin",
    query: { redirect: to.fullPath }
  });
} else {
  next();
}
sessionStorage.setItem("login", true);
let jumpPath = this.$route.query["redirect"]
  ? this.$route.query["redirect"]
  : "/Main";
this.$router.replace({ path: jumpPath });
```

## 页面缓存（用下面的方法替代更佳）

- 缓存页面的销毁和不销毁记录可能会导致项目有些逻辑问题；缓存页面：列表（有分页情况），并且到详情页面，需要在路由 meta 中添加 keepAliveToPath，记录从哪个页面回来需要做缓存

```js
beforeRouteLeave(to,from,next){
     let keepAliveToPath = from.meta.keepAliveToPath || [] ;
      let toName = to.name ;
      if(keepAliveToPath.indexOf(toName) == -1){
        this.$destroy()
      }
      next()
  }

```

- 首先需要在路由配置中 meta 中添加{ isLoaded:false , isLoad:false, keepAlivePages:['MainUser'] }三个参数，
  // isLoaded - 用于判断是否第一次加载，第一次加载是不管从来自哪个页面（即使是来自的页面需要缓存该页面），
  // idLoad - 用于判断页面是否需要缓存
  // keepAlivePages - 来自的页面需要缓存当前页面的页面组

在需要缓存的页面中 activated 中添加方法
if(!this.$route.meta.isLoaded || (this.$route.meta.isLoaded && !this.$route.meta.isLoad)){
  this.$route.meta.isLoaded = true;
this.\_init_page();
}

- 之前遇到从一个缓存页面到不缓存页面，出现问题：不缓存页面要执行上一个缓存页面的 mounted 等生命周期内的方法，暂时没有出现多层级页面，暂时没有浮现该情况，有待验证；

## 生命周期

- beforeRouteEnter：一个一级页面跳转到一个二级页面，出现问题：该生命周期执行两次，导致页面逻辑出错，解决办法，尽量不使用多层级页面，或者不在该生命周期中执行逻辑操作

## 接口调用加载动画

- Ps:一些列表接口不需要进行二次加载，会让人烦
  //用于判断接口是否是第一次加载，第一次加载才出现加载动画，之后不出现在加载动画

let isFirst = true ;
//debugger
if(isFirstLoading){
let urls = sessionStorage.getItem('urls') ? JSON.parse( sessionStorage.getItem('urls') ) : [];

if( urls.indexOf(url) == -1 ){
urls.push(url);
isFirst = true ;
}else{
isFirst = false
}
sessionStorage.setItem('urls',JSON.stringify(urls))
}

- 处理办法：在接口调用的时候添加一个参数 isFirstLoading，判断该接口是否需要第一次加载需要动画，而之后不需要再出现加载动画
