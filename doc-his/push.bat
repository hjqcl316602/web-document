echo 更新代码
git pull
echo 更新结束

echo 开始添加变更
git add -A .
echo 执行结束！

echo;
echo 提交变更到本地仓库
git commit -m "修改代码"

echo;
echo 将变更情况提交到远程git服务器
git push origin master

echo;
echo 批处理执行完毕！
echo;

pause