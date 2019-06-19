# typescript

## 类型

- 类型别名声明（type sn = number | string;）
- 接口声明（interface I { x: number[]; }）
- 类声明（class C { }）
- 枚举声明（enum E { A, B, C }）
- 指向某个类型的 import 声明

## 范例

### 对象

foo.js

```js
const foo = {
  name: "",
  getName() {
    return this.name;
  },
  setName(name) {
    this.name = name;
    return this;
  }
};

export default foo;
```

foo.d.ts

```js
export interface Foo {
  getName(): string;
  setName(name: string): void;
}
declare const Foo: Foo;
export default Foo;

```

### 方法

stringContains.js

```js
export default function stringContains(string, prex) {
  let regex = new RegExp(`${prex}`, "g");
  let res = [];
  string.replace(regex, function(match, index) {
    res.push(index);
  });
  return res;
}
```

stringContains.d.ts

```js
declare const stringContains: stringContains;
export interface stringContains {
  [new] (string: string, prex?: string): number[];
}
export default stringContains;
```

### 综合

index.js

```js
import stringContains from "./stringContains";
export { stringContains };
```

index.d.ts

```js
export const stringContains: (string: string, prex?: string) => number[];
```

## 泛型

数组中只能是某一种类型，返回值也是某种类型

```js
export default function map<T>(arr: T[], index: number): T {
  return arr[index];
}
```

```js
function identity<T>(arg: T): T {
  return arg;
}
// 返回值是参数类型
interface Generic<T> {
  (arg: T): T;
}

let getArg: Generic<number[]> = identity;
console.log(getArg([1]));
```

### 注意

- 不要定义一个从来没使用过其类型参数的泛型类型
- 不要为返回值被忽略的回调函数设置一个 any 类型的返回值类型

```js
// 错误
function fn(x: () => any) {
  x();
}
// 正确
function fn(x: () => void) {
  x();
}
```

- 不要在回调函数里使用可选参数除非你真的要这么做

```js
/* 错误 */
interface Fetcher {
  getObject(done: (data: any, elapsedTime?: number) => void): void;
}
// 正确
interface Fetcher {
  getObject(done: (data: any, elapsedTime: number) => void): void;
}
```

- 不要因为回调函数参数个数不同而写不同的重载

```js
/* 错误 */
declare function beforeAll(action: () => void, timeout?: number): void;
declare function beforeAll(
  action: (done: DoneFn) => void,
  timeout?: number
): void;

/* OK */
declare function beforeAll(
  action: (done: DoneFn) => void,
  timeout?: number
): void;
```

## 枚举

enum 类型是对 JavaScript 标准数据类型的一个补充。 像 C#等其它语言一样，使用枚举类型可以为一组数值赋予友好的名字

### 注意

- 枚举各项没有赋值，则获取到的是它的角标值

```js
enum Color {Red, Green, Blue = 1}
let c: Color = Color.Green;

enum Color {
  Red = "red",
  Green = "green",
  Blue = "blue"
}
enum Colors {
  Red,
  Green,
  Blue
}

function getColor(color: string): string {
  let name: Colors = Colors.Blue;
  return color + name;
}


```

## object

object 表示非原始类型，也就是除 number，string，boolean，symbol，null 或 undefined 之外的类型

定义一个任意类型的对象

```js
interface requestsTypes {
  [propName: string]: any;
}
```

### 注意

- Array 也属于 object 类型
- 不能使用‘!’的类型断言

```js
interface LikeObject {
  name: string;
  age!: number; // 会报错
  address?: object;
}
```

## 命名空间

### 注意

- vscode 编辑不会提示错误，运行时才会提示错误

```js
declare namespace Obj {
  interface Like {
    name: string;
    age: number;
    address?: object;
  }
}
```

## 类型的短名

```js
declare type Types = string | string[] | Function;

let getName: Types = function(name: string): string {
  return name;
};
console.log(getName("huang"));
```
