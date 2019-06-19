
# vue-render

```js
 Vue.component('elem', {
    render: function(createElement) {
        var self = this;
        return createElement('div', {//一个包含模板相关属性的数据对象
            'class': {
                foo: true,
                bar: false
            },
            style: {
                color: 'red',
                fontSize: '14px'
            },
            attrs: {
                id: 'foo'
            },
            domProps: {
                innerHTML: 'baz'
            }
        });
    }
});

```