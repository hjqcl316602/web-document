
# react-css css样式书写方式

## 对象形式

缺点：一些动画和伪类不能使用

``` a

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {date: new Date()};
  }

  render() {
    const styleCss = {
      header : {
        color: 'red',
        backgroundColor: '#ccc',
        "padding-top": '20px',
        paddingBottom: '20px'
      }
    }

    return (
      <div className="App">
        <p style={styleCss.header}>这是一段文字，哈哈</p>
      </div>
    );
  }
}

```

## 模块化

优点：

* 所以的样式都是local的，解决了命名冲突和全局污染
* class名生成规则灵活，可以此来压缩class名
* 只需引入组件的js就能搞定组件的所有js和css

``` a
npm install style-loader css-loader babel-plugin-react-html-attrs --save

render() {
    var colorCss = require('./style/style.css')
    return (
      <div className="App">
        <p className={colorCss.blueColor}></p>
        <p >这是一段文字，哈哈</p>
      </div>
    );
}

```

## MallStyleSheet

style的封装

``` a

import * as StyleSheet from 'MallStyleSheet';

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#F5FCFF',
        justifyContent: 'center',
        alignItems: 'center'
    },
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10
    }
});

render() {
    console.log('render in ViewThree');
    return (
        <View style={styles.container}>
            <Text style={styles.welcome}>
                {this.props.content.get('name')}
            </Text>
        </View>
    );
}

```