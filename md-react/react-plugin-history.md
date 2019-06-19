# react-history

## api 

### createBrowserHistory

### createHashHistory

### createLocation

### createMemoryHistory

### createPath

### locationAreEqual

### parsePath

# history对象

## location
    
    当前应用所在的位置，包含了pathname search hash...,并且拥有一个与之关联的独一无二的key，拥有与之关联且url中没有的数据和状态等
``` processing
    {
      pathname: '/here',
      search: '?key=value',
      hash: '#extra-information',
      state: { modal: true },
      key: 'abc123'
    }
```

## navigatation

## push
    
    push方法使能你跳转到新的location。通过在当前location后添加新的location时，任意的'未来'location会被清除（之前由后退按钮而形成的在当前location后的location）
    
``` less
    history.push({ pathname: '/new-place' })
```

## replace
    
    replace方法与push相似，但它并非添加location，而是替换当前索引上的位置。'未来'location将不会被清除
``` less
    history.replace({ pathname: '/go-here-instead' })
```


## go

## goBack

## goForward

## listen

    采用观察者模式，在location改变时，history会发出通知。每一个history对象都有listen方法，接受一个函数作为参数。这个函数会被添加到history储存的监听函数数组中。当location变化时（如代码调用history方法或用户点击浏览器按钮），history对象将会调用所有listener方法。这能让你在location变化时来设置代码更新。

## memory

    缓存所有的history（好像已废弃）



    