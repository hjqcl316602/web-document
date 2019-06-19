
# react-immutable-render-mixin

```

    进行数据比较，没有改变则不更新
    使用方法 
    
    import { shallowEqualImmutable } from 'react-immutable-render-mixin';
    
    shouldComponentUpdate(nextProps, nextState) {
        return !shallowEqualImmutable(this.props, nextProps)
            || !shallowEqualImmutable(this.state, nextState);
    }

```