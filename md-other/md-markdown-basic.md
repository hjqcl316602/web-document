# `markdown` #

## `标题` ##

  标题下需要换行、标题前面不能有空格，否则书写会出现波浪线，

# 一级标题 #
   
## 二级标题 ##

### 三级标题 ###

#### 四级标题 ####

##### 五级标题 #####

###### 六级标题 ######

####### 七级标题 #######

一级标题
===

二级标题
----

## `列表` ##

列表分为有序列表和无序列表 <br/>

* '* ， + ， — '均可表示无序列表<br/>
* 有序列表就相对简单一点，只有这一种方式，注意，数字后面的点只能是英文的点，特别注意，有序列表的序号是根据第一行列表的数字顺序来的

1. '* ， + ， — '均可表示无序列表<br/>
2. 有序列表就相对简单一点，只有这一种方式，注意，数字后面的点只能是英文的点，特别注意，有序列表的序号是根据第一行列表的数字顺序来的

## `区块引用` ##

* 不以结婚为目的的谈恋爱都叫耍流氓
  > 这是毛主席说的呢
  >> 多级
  >>> 很多级
* 前方高能
  > 注意，这是为了提醒  

## `华丽的分隔线` ##

分割线可以由* - _（星号，减号，底线）这3个符号的至少3个符号表示，注意至少要3个，且不需要连续，有空格也可以

***
******
---
- - -
* * * 
_ _ _

## `链接` ##

  [百度](http://www.baidu.com)

## `图片` ##

  ![我是图片](https://images2015.cnblogs.com/blog/600165/201701/600165-20170121185054312-549083784.png)

## `代码框` ##  

  如果代码量比较少，只有单行的话，可以用单反引号包起来<br>
  `let aType = getType(a),bType = getType(b);`

  多行用三个反引号，如果要写注释，可以在反引号后面写
  ``` 多行的
    let aType = 
    getType(a),
    bType = getType(b)
  ```

## `表格` ##

  | name | age | sex |
  |:-----:|:-----:|:------:|
  | toney | 20 | 男 |
  | toney | 20 | 男 |

  name | age | sex
  -----|-----|------
  toney | 20 | 男
  toney | 20 | 男

  name | age | sex
  -|-|-
  toney | 20 | 男
  toney | 20 | 男

## `强调` ##

    一个星号或者是一个下划线包起来，会转换为<em>倾斜，如果是2个，会转换为<strong>加粗

  *字体斜体*
  _字体倾斜_
  **字体加粗**
  __字体加粗__

## `转义` ##

  * \\
  * \`
  * \~

## `删除线` ##

  ~~请删掉我把~~
