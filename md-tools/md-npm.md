<!--
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2019-04-24 10:26:15
 * @LastEditTime: 2019-08-20 08:58:31
 * @LastEditors: Please set LastEditors
 -->

# npm

## npm publish

- 发布时，只需要发布该库的文件即可，package.json 文件中不要包含依赖文件，否则项目下载时，会影响当前项目的依赖

## 得到本地的镜像地址

npm get registry

## 设置成淘宝镜像

npm config set registry http://registry.npm.taobao.org/

## 换成原本的

npm config set registry https://registry.npmjs.org/
