
# immutable

## 数据类型

- List -有序索引集，类似js中的Array，使用最多之一
- Map - 无序索引集，类似js中的Object，使用最多之一
- OrderedMap - 有序的Map，根据数据的set()进行排序
- Set - 没有重复值的集合
- OrderedSet - 有序的Set，根据数据的add进行排序
- Stack - 有序集合，支持使用unshift和shift添加和删除
- Range - 返回一个seq.indexed类型的集合，这个方法有三个参数，start表示开始值，默认值是0，end表示结束值，默认为无穷大，step代表每次增大的数值，默认为1，如果start = end，则返回空集合
- Repeat - 返回一个vseq.indexed类型的集合，这个方法有两个参数，value代表需要重复的值，times代表要重复的次数，默认为无穷大
- Record - 一个用于生成Record实例的类，类似于js的Object,但是只接收待定字符串为key，具有默认值
- Seq - 序列，但是可能不能有具体的数据结构支持
- Collection - 是构建所数据结构的基类，不可直接构架

## API

### fromJs()

作用 ： 将一个js数据转换为immutable类型的数据
使用 ： fromJs(value,converter),value是要转换的数据，converter是要做的操作，默认情况是将数组准转换为List类型，将对象转换为Map类型，其余不做操作

### is()

作用 ： 对两个对象进行比较，和js中对象的比较不同，在js中比较的是地址，但是在immutable中比较的是这个对象的hashcode和valueof，只要两个对象的额hashcode相等，值就相同，避免了深度遍历，提高了性能
使用 ： is(map1,map2)

## 解决组件渲染性能

``` a
import { is ,fromJS} from 'immutable'

// 深对比

shouldComponentUpdate(nextProps,nextState){
    return !is(fromJS(nextState),fromJS(this.state)) || !is(fromJS(nextProps),fromJS(this.props))
}

// 浅对比

shouldComponentUpdate(nextProps = {}, nextState = {}) {
    const thisProps = this.props || {}, thisState = this.state || {}
    // 如果参数的长度不一致，更新
    if (Object.keys(thisProps).length !== Object.keys(nextProps).length ||
    Object.keys(thisState).length !== Object.keys(nextState).length) {
    return true;
    }
        // 如果参数的值不一致，更新
    const flag1 = Object.keys(nextProps).some(item => !is(thisProps[item], nextProps[item]))
    if (flag1) return true
        // 如果state值不一致，更新
    const flag2 = Object.keys(nextState).some(item => !is(thisState[item], nextState[item]))
    if(flag2) return true

    return false;
}

```