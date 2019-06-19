# react-dom

## API

### ReactDOM.render(element,contanier[,callback])

  将 React 元素渲染到提供容器的 DOM 中，并且返回对组件的引用（或者无状态组件返回 null）。

  如果已经将 React 元素渲染到 container 中，则会对其执行更新，并仅根据需要对 DOM 进行变更以显示最新的 React 元素。

  如果提供了可选的回调函数，则在组件中被渲染或更新后执行回调函数

#### 注意事项

* ReactDOM.render() 控制你传入的容器节点的内容。第一次调用时。里面的任何现有 DOM 都会被替换。稍后调用 React 的 DOM diffing 算法进行有效的更新。
* ReactDOM.render() 不修改容器节点（只修改容器的子节点）。将组件插入现有的 DOM 节点而不是覆盖现有的子节点也是可行的。
* ReactDOM.render() 当前返回对根 ReactComponent 实例的引用。但是，使用这个返回值是遗留问题，应该避免。应为在某些情况下，未来版本的 React 可能会异步渲染组件。如果需要对根 ReactComponent 实例的引用，则首选的解决方案是将 回调 ref 附加到根元素上。
* 使用 ReactDOM.render() 来 hydrate（混合） 一个服务器渲染的容器已经被启用了，并且将在 React 17 中移除。请使用 hydrate() 替代


### ReactDOM.hydrate(element,contanier[,callback])

  和 render() 一样，但是用于将其内容与 ReactDOMServer 渲染的容器结合。React 将尝试将事件监听器附加到现有的标记上。

  React 期望在服务器和客户端之间呈现的内容是相同的。它能够修复文本内容（如时间戳）的差异，但是你应该将不匹配视为错误并且修复它们。在开发模式中，React 在 hybrate 期间会警告不匹配。不保证在不匹配的情况下修改属性差异。这对于性能方面的原因很重要，因为在大多数的应用程序中，不匹配是非常罕见的，因此验证所有的标记代价很高。

  如果你有意在服务器和客户端上渲染不同的内容，则可以执行两遍渲染。在客户端上呈现不同内容的组件可以读取类似 this.state.isClient 的 state 变量，你可以在 componentDidMount() 中将其设置为 true。通过这种方式，初始渲染过程将渲染与服务器相同的内容，从而避免不匹配，但是在 hydrate 之后，将会同步发生的额外的传递。请注意，这种方法会使得组件变慢，因为它们必须渲染两次，因此请谨慎使用它。

  请记住，要注意用户在慢速连接上的体验。JavaScript 代码的加载时间可能比最初的 HTML 呈现时间晚得多，所以如果你在仅客户端传递中渲染不同的内容，则转换可能会出现问题。但是，如果执行得当，在服务器上渲染应用程序的 “shell” 可能是有益的，并且只显示客户端上的一些额外的小部件。要了解如何在不出现标记不匹配的情况下执行此操作，请参阅上一段中的解释

### ReactDOM.unmountComponentAtNode(contanier)

  从 DOM 中删除已安装的 React 组件并清理其事件处理程序和状态。如果在容器中没有安装组件，调用这个函数则什么也不做。如果组件已经卸载，则返回 true；如果组件未卸载，则返回 false

### ReactDOM.findDOMNode(component)

  如果这个组件已经被挂载到 DOM 中，则返回相应的本地浏览器 DOM 元素。这个方法对于从 DOM 中读取值（如表单域值和执行 DOM 测量）非常有用。在大多数情况下，你可以附加一个 ref 到 DOM 节点上，避免使用 findDOMNode。

  放组件渲染为 null 或者 false 的时候，findDOMNode 返回 null。当一个组件渲染为字符串的时候，findDOMNode 返回一个包含该字符串的文本 DOM 节点。从 React 16 开始，一个组件可能返回一个带有多个子元素的片段，这种情况下，findDOMNode 将返回与第一个非空子元素对应的 DOM 节点

#### 注意事项

  findDOMNode 是一个用于访问底层 DOM 节点的 escape hatch。大多数情况下，不建议使用这个 escape hatch ，因为它破坏了组件的抽象。
  findDOMNode 只适用于已安装的组件（即已放置在 DOM 中的组件）。如果你尝试在尚未安装的组件上调用它（如在尚未挂载的组件上的 render() 方法中调用 findDOMNode()，则会发生异常）。
  findDOMNode 不能被用与 function 定义的组件。

### ReactDOM.createPortal(child,contanier)

  创建一个 protal。Protals 提供了一种方法来将子元素渲染到 DOM 组件层次结构之外的 DOM 节点中
