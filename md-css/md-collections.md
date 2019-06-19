# css-collections

## 解决 webpack 打包删除 -webkit- 属性，影响 css

```css
.jq-text_clamp {
  display: -webkit-box;
  overflow: hidden;
  /*!autoprefixer:off */
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
  /* autoprefixer:on */
  text-emphasis: none;
}
```
