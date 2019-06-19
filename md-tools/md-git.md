
# git

* git branch // 查找分支
* git branch name // 创建分支
* git checkout name //切换到分支
* git checkout -b // 创建并切换到分支
* git merge name //合并某分支到当前分支：
* git branch -d name //删除分支

* git add [file] // 添加文件本地
* git commit -m 'update' // 提交到本地
* git push origin master // 提交到某个分支上

* git diff master // 查看本地分支于原有的分支的不同

// 对master文件的修改提交步骤
// git pull origin [master] // 如果是当前位置可直接 书写为 git pull
// git add -A .
// git commit -m '[update]' // update不能为空
// git push origin [master] // master也不能空

// 合并master huangjunquan并提交
// git pull origin master // 拉取master文件代码
// 此时需要进行冲突代码处理
// 再进行提交
// git add -A .
// git commit -m '[update]' // update不能为空
// git push origin [master] // master也不能空