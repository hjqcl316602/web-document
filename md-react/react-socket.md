
# socket

## 方式一

sokectjs、stompjs
安装 ： npm install -S sockjs-client stompjs

sockjs-client : 提供了浏览器兼容性。优先使用原生WebSocket，如果在不支持websocket的浏览器中，会自动降为轮询的方式。 
stompjs : websocket连接已经建立, 由于websocket没有规范payload的格式, 所以应用需要自己去定义payload的格式. websocket的payload可以是文本也可以是二进制. 应用一般会选择用文本.这个文本是什么格式websocket协议本身并没有规定, 由应用自己来定。 stomp是一个用于client之间进行异步消息传输的简单文本协议

``` a

socket = new SockJS(wsLocalUrl+'/websocket');
var stompClient = Stomp.over(socket);

stompClient.connect('','',function(frame){
    stompClient.subscribe("/topic/taskNum."+currUserId+"."+taskClassParent, function(message) {
        //alert(JSON.parse(message.body));
    });
});



```

### 创建stomp

socket = new SockJS(wsLocalUrl+'/websocket');
var stompClient = Stomp.over(socket);

### 连接服务器

//接受不同数量的参数
client.connect(login, passcode, connectCallback);
client.connect(login, passcode, connectCallback, errorCallback);
client.connect(login, passcode, connectCallback, errorCallback, host);

var headers = {
login: 'mylogin',
passcode: 'mypasscode',
// additional header
'client-id': 'my-client-id'
}
client.connect(headers, connectCallback);
client.connect(headers, connectCallback, errorCallback);

### 断开服务器

client.disconnect(function() {
  alert("See you next time!");
};

### 发送消息

client.send(destination, {}, body); 

### 订阅（subscribe）

client.subscribe("/queue/test", callback);

### 完整示例

``` a

var url = 'http://localhost:8080/stomp';
var sock = new SockJS(url);
var stomp = Stomp.over(sock);

var strJson = JSON.stringify({'message': 'Marco!'});

//默认的和STOMP端点连接
/*stomp.connect("guest", "guest", function (franme) {

});*/

var headers={
  username:'admin',
  password:'admin'
};

stomp.connect(headers, function (frame) {

  //发送消息
  //第二个参数是一个头信息的Map，它会包含在STOMP的帧中
  //事务支持
  var tx = stomp.begin();
  stomp.send("/app/marco", {transaction: tx.id}, strJson);
  tx.commit();


  //订阅服务端消息 subscribe(destination url, callback[, headers])
  stomp.subscribe("/topic/marco", function (message) {
      var content = message.body;
      var obj = JSON.parse(content);
      console.log("订阅的服务端消息：" + obj.message);
  }, {});


  stomp.subscribe("/app/getShout", function (message) {
      var content = message.body;
      var obj = JSON.parse(content);
      console.log("订阅的服务端直接返回的消息：" + obj.message);
  }, {});


  /*以下是针对特定用户的订阅*/
  var adminJSON = JSON.stringify({'message': 'ADMIN'});
  /*第一种*/
  stomp.send("/app/singleShout", {}, adminJSON);
  stomp.subscribe("/user/queue/shouts",function (message) {
      var content = message.body;
      var obj = JSON.parse(content);
      console.log("admin用户特定的消息1：" + obj.message);
  });
  /*第二种*/
  stomp.send("/app/shout", {}, adminJSON);
  stomp.subscribe("/user/queue/notifications",function (message) {
      var content = message.body;
      var obj = JSON.parse(content);
      console.log("admin用户特定的消息2：" + obj.message);
  });

  /*订阅异常消息*/
  stomp.subscribe("/user/queue/errors", function (message) {
      console.log(message.body);
  });

  //若使用STOMP 1.1 版本，默认开启了心跳检测机制（默认值都是10000ms）
  stomp.heartbeat.outgoing = 20000;

  stomp.heartbeat.incoming = 0; //客户端不从服务端接收心跳包
});
```

## 方式二

socket.io

### 使用

* npm install socket.io-client // 客户端
* npm install socket.io // 服务器端

``` a
import io from 'socket.io-client'
let socket = io('http://www.www.www')

```

### sokect.on()事件

* connect：连接成功
* connecting：正在连接
* disconnect：断开连接
* connect_failed：连接失败
* error：错误发生，并且无法被其他事件类型所处理
* message：同服务器端message事件
* anything：同服务器端anything事件
* reconnect_failed：重连失败
* reconnect：成功重连
* reconnecting：正在重连
当第一次连接时，事件触发顺序为：connecting->connect；当失去连接时，事件触发顺序为：disconnect->reconnecting（可能进行多次）->connecting->reconnect->connect。