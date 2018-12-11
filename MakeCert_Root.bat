%~d0
cd %~dp0
makecert -n "CN=ZJRoot;O=浙江省数字认证中心;L=杭州市;S=浙江省;C=CN" -r -sv root_test.pvk root_test.cer
pause
