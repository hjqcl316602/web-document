# promise

- 理解

  - eject 后的东西，一定会进入 then 中的第二个回调，如果 then 中没有写第二个回调，则进入 catch
  - 理解了 promise 源码得知，then 中的回调函数是放在 resolve()函数中执行的，catch 则是放在 reject()函数中

```js
let testPromise = new Promise((resolve, reject) => {
  setTimeout(() => {
    reject("hahah");
  }, 1000);
});

testPromise.then(res => {
  console.log(res);
});

testPromise.catch(res => {
  console.log(res);
});
testPromise.finaly(() => {
  console.log("finaly");
});
```
