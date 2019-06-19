# `vscode-react` #

## `vscode实现react编写是tab键补全html` ##

首选项 -> 设置 -> 变成code的形式（单击右上角‘{}’即可）->用户设置->添加
```
"emmet.includeLanguages": {
    "javascript": "javascriptreact"
},
```

## `插件安装 ，react 开发的一些简写，提高开发效率` ##

 `reactjs code snippets`
  
## `react（jsx） 模板` ##  

  文件 - 首选项 - 用户代码片段 - javascriptreact
  
  ```js

  {
      "JSX": {
          "prefix": "jsx", // 触发的关键字 输入jsx按下tab键
          "body": [
              "import React, { Component }  from 'react'",
              "",// 空的一行
              "class $1 extends Component {",
              "\trender() {", // 有制表符的一行
              "\t\treturn (",
              "\t\t\t$1",    //光标首次出现的位置
              "\t\t)",
              "\t}",
              "}",
              "",
              "export default $1",
          ],
          "description": "jsx components"
      }
    }
  ```

  新建文件 - 输入jsx - 按下tab键即可