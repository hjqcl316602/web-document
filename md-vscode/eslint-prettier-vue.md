# eslint-prettier-vue

## 步骤一

vscode 安装插件 eslint + prettier

## 步骤二

添加 .eslintrc.js 和 .prettierrc.js

## 步骤三

vscode 配置（可以将 prettierrc 文件中的一起配置）

### .eslintrc.js

```js
module.exports = {
  root: true,
  parserOptions: {
    parser: 'babel-eslint'
  },
  env: {
    browser: true
  },
  extends: ['plugin:vue/essential', 'eslint:recommended'],
  // required to lint *.vue files
  plugins: ['vue', 'prettier'],
  // add your custom rules here
  rules: {
    // allow async-await
    'generator-star-spacing': 'off',
    // allow debugger during development
    'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off'
  }
};
```

### vscode 的 setting 中额外添加配置

```js
    "vetur.format.defaultFormatter.html": "js-beautify-html",
    "vetur.format.defaultFormatterOptions": {
        "js-beautify-html": {
            "wrap_attributes": "auto" //属性强制折行对齐 force force-aligned force-expand-multiline
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
    "prettier.htmlWhitespaceSensitivity": "css"
```
