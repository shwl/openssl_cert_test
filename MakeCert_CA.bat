%~d0
cd %~dp0
makecert -iky 2 -n "CN=ZJCA;O=浙江省数字认证中心;L=杭州市;S=浙江省;C=CN" -iv root_test.pvk -ic root_test.cer -sv ca_test.pvk ca_test.cer
pause
