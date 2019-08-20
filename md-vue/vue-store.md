<!--
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2019-08-17 19:57:05
 * @LastEditTime: 2019-08-18 20:45:53
 * @LastEditors: Please set LastEditors
 -->

# vue-store

## element-resize-detector

监听某个元素尺寸的变化

```js
this.mutationObserver = new MutationObserver(() => {
  if (hiddenParentNode.style.display !== 'none') {
    this.updateBar();
    this.mutationObserver.disconnect();
  }
});

this.mutationObserver.observe(hiddenParentNode, { attributes: true, childList: true, characterData: true, attributeFilter: ['style'] });
```

```js
// this.observer = elementResizeDetectorMaker();
this.observer = elementResizeDetectorMaker({
  strategy: 'scroll' //<- For ultra performance. 提高性能
});
this.observer.listenTo(this.$refs.box, e => {
  console.log(e);
});
```
