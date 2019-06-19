3300379903@qq.com    hjqCL316602

appid:wx48531fbd8099a410

MVC:controller是view和model的协调者，model提供数据，view负责显示
     (backbone.js knockout.js spine.js ember.js angular.js)
MVP:MVP 模式将Controller 改名为 Presenter，同时改变了通信方向

1. 各部分之间的通信，都是双向的。

2. View 与 Model 不发生联系，都通过 Presenter 传递。

3. View 非常薄，不部署任何业务逻辑，称为"被动视图"（Passive View），即没有任何主动性，而 Presenter非常厚，所有逻辑都部署在那里
MVVM:model + view + viewmodel
     view的变化会自动的更新到viewmodel，viewmodel的变化也会同步到view上进行显示
     vue.js React.js Angular.js 
     
vue.js可以说并不算是一个框架，因为它只能聚焦视图层，是一个构建数据驱动的web界面的库
通过简单的API（应用程序编程接口）提供高效的数据绑定和灵活的组件系统
特性：
     轻量级的框架
     双向数据绑定（view的数据改变即model数据改变，model数据改变即view数据改变）
     指令
     插件化（router(单页应用),resourse（后端数据）,ajax）

和angular的区别
     相同：
          1.都支持指令（内置，自定义）
          2.过滤器（内置（2.0以上废弃，需要引入），自定义）
          3.双向数据绑定
          4.不支持低端的浏览器（IE9以上）
     不同：
          1.angular 的学习成本高，vue本身api简单，直观
          2.性能，angular依赖数据需要做脏检查，所以watcher越多越慢，（脏检查：angular么有办法判断数据是否变化，通过设置了一些条件，当触发这些条件的时候，它即执行一个监测来遍历所有的数据，对比更改前的数据，然后执行变化，效率差）
          3.vuejs使用基于依赖追踪的观察并使用队列更新，所有数据都是独立的触发

和react的区别
     相同：
          1.react采用jsx语法，vue可采用.vue的文件进行编写，都需要编译才能执行
          2.中心思想：组件化开发，组件实例可以嵌套
          3.都提供钩子函数（生命周期）可以让开发者定制化的去处理需求
          4.不设置ajax，router等核心功能，都是以插件的方式加载     
          4.在组件开发中都支持mixins（组件通信）的特性
     不同：
          1.react依赖virtual DOM（虚拟DOM），而vue使用的DOM模板，react采用virtual对渲染的结果做脏检查
          2.vue在模板中提供了指令，过滤器等，可以非常方便，快捷地操作DOM，过渡效果，内容分发等