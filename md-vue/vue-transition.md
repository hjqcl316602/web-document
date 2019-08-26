<!--
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2019-08-24 08:37:44
 * @LastEditTime: 2019-08-24 08:39:23
 * @LastEditors: Please set LastEditors
 -->

# vue-transition

```html
<transition name="fade" appear @after-enter="afterEnter" @after-leave="afterEnter" @after-appear="afterApper">
  <div v-if="show" class="modal" @click="show = !show">
    内容
  </div>
</transition>
```

```css
.fade-leave-active {
  animation-fill-mode: both;
  animation-name: ivuFadeOut;
  animation-play-state: linear;
  animation-duration: 0.3s;
}

.fade-enter-active {
  animation-name: ivuFadeIn;
  animation-timing-function: linear;
  animation-fill-mode: both;
  animation-duration: 0.3s;
}

@keyframes ivuFadeIn {
  0% {
    opacity: 0;
  }

  100% {
    opacity: 1;
  }
}

@keyframes ivuFadeOut {
  0% {
    opacity: 1;
  }

  100% {
    opacity: 0;
  }
}
```
