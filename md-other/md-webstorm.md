
# webstorm

## 安装Webstorm破解版

安装好软件之后 找到webstorm.exe.vmoptions、webstorm64.exe.vmoptions文件进行修改
修改首行
-javaagent:C:\AA.SOFT\AA.WEBSTORM\WebStorm 2018.1.5\bin\JetbrainsCrack-2.10-release-enc.jar
JetbrainsCrack-2.10-release-enc.jar
启动软件之后选择中间的选项，并将 -javaagent:C:\AA.SOFT\AA.WEBSTORM\WebStorm 2018.1.5\bin\JetbrainsCrack-2.10-release-enc.jar 复制进去即可

## 配置鼠标右键webtorm快捷打开文件夹

Win+R -> regedit -> HKEY_CLASSES_ROOT->Directory->shell->鼠标右键新建 项（K）webstorm->再在webstorm下新建项command->双击command,添加‘数值数据’（C:\AA.SOFT\AA.WEBSTORM\WebStorm 2018.1.5\bin\WebStorm.exe %1）（%1前有空格）

## 关闭 node_modules 校验

在 node 项目中存在 node_modules 目录，每次打开 webstrom 时会校验文件，同样也会校验 node_modules 中的内容，这会浪费很多时间。

## 取消勾选不常用的插件

webstorm 中可以集成很多插件，这些插件也会影响运行速度，有的插件你可能压根都没听过，更不会使用，可以取消勾选

## 快捷键

* Ctrl + Shift + U —— 大小写切换
* Ctrl + E —— 打开最近操作过的文件
* Ctrl + Y —— 删除光标所在行
* Ctrl + Alt + L —— 格式化代码
* Ctrl + Alt + S —— 打开设置窗口
