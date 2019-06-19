
# gulp

## 安装

npm  install -g gulp 
 
## 安装插件 - 指定项目中 
//编译less css
npm install gulp gulp-autoprefixer gulp-clean-css gulp-concat gulp-less gulp-minify-css gulp-rename pump gull-clean
npm install gulp gulp-autoprefixer gulp-less gulp-rename pump
//编译js 
npm install -g babel-cli 
npm install gulp-babel babel-preset-es2015 babel-core @babel/core  --save-dev

## 執行

gulp 执行默认的
gulp [watch] 执行指定任务

## 实例

```js

const gulp = require('gulp');
const minify = require('gulp-minify-css');
const cleanCSS = require('gulp-clean-css');
const concat = require('gulp-concat');
const autoprefixer = require('gulp-autoprefixer');
const rename = require('gulp-rename');
const less = require('gulp-less');
const pump = require('pump')
const babel = require('gulp-babel')
const clean = require('gulp-clean')

gulp.task('clean',async function(){
  await pump([
    gulp.src('./dist'),
    clean()
  ])
})

gulp.task('css', async() =>{
  await  pump([
    gulp.src('src/demo/styles/index.less'),
    clean(),
    less(),
    minify(),
    rename('index.min.css'),
    //gulp.dest('./dist/styles') // 打包到指定的文件夹下 
  ])
})
gulp.task('js', async() =>{
  await  pump([
    gulp.src('src/utils/index.js'),
    babel(),
    rename('utils.js'),
    gulp.dest('./dist') // 打包到指定的文件夹下 
  ])
})


gulp.task('watch-css',async function(){
  await gulp.watch(['src/demo/styles/*.less'],gulp.series('css'))
})

gulp.task('watch-js',async function(){
  await gulp.watch(['src/utils/check/index.js'],gulp.series('js'))
})

gulp.task('default',gulp.series('css')) 

/**
 * 注意事项
 */
//gulp.task('default',['css','fonts']) gulp 3.0的写法
//gulp 4.0 写法 series 按顺序执行 parallel并行执行
//async await 避免出现 Did you forget to signal async completion? 的报错

```
 