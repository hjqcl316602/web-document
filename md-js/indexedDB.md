# indexedDB

```js
function openDB(name, version = 1) {
  return new Promise((resolve, reject) => {
    let indexedDB =
      window.indexedDB ||
      window.mozIndexedDB ||
      window.webkitIndexedDB ||
      window.msIndexedDB;
    if (!indexedDB) {
      reject({ type: "error", message: "浏览器不支持数据库存储！" });
    } else {
      let request = indexedDB.open(name, version);
      request.onerror = function() {
        reject({ type: "error", message: "数据库链接失败！" });
      };
      request.onsuccess = function(e) {
        resolve(e.target.result);
      };
      request.onupgradeneeded = function(e) {
        reject({
          type: "success",
          message: "数据库已升级！",
          value: e.target.result
        });
      };
    }
  });
}

openDB("user", 1)
  .then(db => {
    console.log("then");
    readStore(db);
  })
  .catch(mes => {
    if (mes.type === "success") {
      let db = mes.value;
      var objectStore = db.createObjectStore("person", { autoIncrement: true });
      objectStore.createIndex("name", "name");
      objectStore.createIndex("email", "email");
      objectStore.createIndex("age", "age");
      objectStore.createIndex("address", "address");
    } else {
      alert(mes.message);
    }
    console.log("catch");
  });

function readStore(db) {
  var transaction = db.transaction(["person"]);
  var objectStore = transaction.objectStore("person");
  //console.log(objectStore)
  // 遍历
  // objectStore.openCursor().onsuccess = function (event) {
  //   var cursor = event.target.result;

  //   if (cursor) {
  //     console.log('Id: ' + cursor.key);
  //     console.log('Name: ' + cursor.value.name);
  //     console.log('Age: ' + cursor.value.age);
  //     console.log('Email: ' + cursor.value.email);
  //     cursor.continue();
  //   } else {
  //     console.log('没有更多数据了！');
  //   }
  // };
  // 获取逐渐id值的数据
  //var request = objectStore.get(1);
  //console.log(request)
}

function addStore(db) {
  var request = db
    .transaction(["person"], "readwrite")
    .objectStore("person")
    .add({
      name: "张三",
      age: 24,
      email: "zhangsan@example.com",
      address: "成都市双流县"
    });
  request.onsuccess = function(event) {
    console.log("数据写入成功");
  };

  request.onerror = function(event) {
    console.log("数据写入失败");
  };
}
```
