
# component-toast

引入方式的toast，没有挂载到全局vue上

```js
import Vue from 'vue'
import Toast from './toast.vue'

let ToastInstance,div,ToastComponent

export default  {
  show () {
    if(!ToastInstance){
      ToastInstance = Vue.extend(Toast); // 扩展实例
      div = document.createElement('div');
      const divInner = document.createElement('div');// vue实例需要替换的div，这样才能保证最后删除的时候可以清楚外层div
      div.appendChild(divInner)
      document.body.appendChild(div)
      ToastComponent = new ToastInstance({propsData:{ type:'success'}}); // 实例化 
      ToastComponent.$mount(divInner) // 挂载到里层div上，保证后续清楚能清楚掉外层div
      ToastComponent.show()
    }
  },
  hide (){
    document.body.removeChild(div)
    ToastInstance = null;
    div = null;
    ToastComponent = null

  }
}

```