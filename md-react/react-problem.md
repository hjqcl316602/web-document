
# react problem(学习react遇到的问题和坑)

## npm start 启动时出现的问题

### 第一

```js

Cannot compile namespaces when the '--isolatedModules'

```

可能原因是执行了npm run eject之后和配置了es7装饰器并且使用了mobx，导致typescript出现了问题，暂时通过不书写装饰器的写法来避免该问题

### 第二

```js

Error while parsing config - JSON5: invalid end of input at 7:5

```

原因是根目录下创建了一个空的.babelrc文件，删除即可