%~d0
cd %~dp0
makecert -ikv2 -n "CN=ZJRoot;O=浙江省数字认证中心;L=杭州市;S=浙江省;C=CN" -r -sv root_test.pvk root_test.cer

makecert -n "CN=ZJCA;O=浙江省数字认证中心;L=杭州市;S=浙江省;C=CN" -iv root_test.pvk -ic root_test.cer -sv ca_test.pvk ca_test.cer

makecert -n "CN=Test;O=TestO;L=杭州市;S=浙江省;C=CN;DC=DCTest" -iv D:\cert\ZJCATest.pvk-ic D:\cert\ZJCATest.cer -sv D:\cert\test.pvk D:\cert\test.cer

cert2spc D:\cert\test.cer D:\cert\test.spc
pvk2pfx -pvk D:\cert\test.pvk -spc D:\cert\test.spc -pfx D:\cert\test.pfx
