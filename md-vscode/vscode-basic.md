# vscode-basic

## 基础配置

```js
{
    "workbench.colorTheme": "Monokai", // 主题 ctrl + K + T 更换主题
    "workbench.iconTheme": "material-icon-theme", // 文件图标
    "workbench.panel.defaultLocation": "right", // 控制台的位置
    "window.zoomLevel": 0,
    "editor.lineHeight": 24, // 文本行高
    "editor.wordSeparators": "`~!@#%^&*()=+[{]}\\|;:'\",.<>/?", // 双击选择的文本包含

    // class智能提示，需要先安装 html css support插件
    "editor.parameterHints": true,
    "editor.quickSuggestions": {
      "other": true,
      "comments": true,
      "strings": true
    },

    // prettier 智能格式化 ， 需要安装 eslint + prettier
    "vetur.format.defaultFormatter.html": "prettier", // prettier js-beautify-html
    "vetur.format.defaultFormatterOptions": {
    "js-beautify-html": {
      "wrap_attributes": "force-aligned" //属性强制折行对齐
    }
   },
  "editor.formatOnSave": true, //保存时自动格式化
  "eslint.autoFixOnSave": true, //保存时使用自动格式化
  "eslint.validate": [
    //验证文件类型
    "javascript",
    "javascriptreact",
    "vue",
    "html",
    "jsx",
    {
      "language": "html",
      "autoFix": true
    },
    {
      "language": "vue",
      "autoFix": true
    }
  ],
  "prettier.singleQuote": true, //使用单引号而不是双引号
  "prettier.jsxBracketSameLine": true, //将>多行JSX元素放在最后一行的末尾，而不是单独放在下一行
  "prettier.eslintIntegration": true,
  "prettier.stylelintIntegration": true,
  "prettier.tabWidth": 2,
  "prettier.semi": true,
  "prettier.printWidth": 500,
  "prettier.htmlWhitespaceSensitivity": "css",
  "git.confirmSync": false,
  "git.enableSmartCommit": true
}

```

## 常用的快捷方式

- shift + alt // 快速多行乡下选择
- shift + alt + F // 格式化代码
- shift + -/+ // 文本字体大小的切换
