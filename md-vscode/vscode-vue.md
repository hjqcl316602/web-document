## vscode-vue

### 基础配置

```js
  {
    "vetur.format.defaultFormatter.html": "prettier",  // vue-template 的格式选择 ，需要安装‘prettier’插件才行
    "editor.formatOnSave": true,  // 保存之后自动按 ‘prettier’格式化
  }
```

### 创建配置文件（优先级从上到下）

- .prettierrc
- .editconfig
- 编辑器默认配置

```js
{
  "tabWidth": 2,
  "singleQuote": true,

  "trailingComma": "all",
  "semi": false
}

```
