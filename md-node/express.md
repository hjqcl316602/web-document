<!--
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2019-08-28 22:27:16
 * @LastEditTime: 2019-08-28 23:30:09
 * @LastEditors: Please set LastEditors
 -->

# express

## 登录

不能在跨域的环境执行，直接浏览器访问该路径是可以的

```js
var cookieParser = require('cookie-parser');
app.use(cookieParser('my_cookie_secret'));

router.get('/login', function(req, res) {
  res.cookie('logined', 1, { maxAge: 10 * 1000 });
  res.send('登录成功');
});
router.get('/query', function(req, res) {
  console.log(req.cookies);
  if (req.cookies.logined) {
    res.send('登录成功');
  } else {
    res.send('登录失败');
  }
});
```

```js
// 暂时还未调通
var session = require('express-session');
var redis = require('redis');
var redisClient = redis.createClient('6379', '127.0.0.1');
var RedisStore = require('connect-redis')(session);
app.use(
  session({
    secret: 'signkey',
    store: new RedisStore({ client: redisClient }),
    resave: false,
    saveUninitialized: false,
    name: 'session_id'
  })
);
```

## 持久化

```js
var session = require('express-session');
var NedbStore = require('nedb-session-store')(session);
const sessionMiddleware = session({
  secret: 'fas fas',
  resave: true,
  saveUninitialized: false,
  cookie: {
    path: '/',
    httpOnly: true,
    maxAge: 10 * 1000
  },
  store: new NedbStore({
    filename: 'path_to_nedb_persistence_file.db'
  })
});
app.use(sessionMiddleware);
```
