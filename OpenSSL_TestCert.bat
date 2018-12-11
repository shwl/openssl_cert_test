%~d0
cd %~dp0
makecert -sky signature -a sha256 -n "CN=Test;O=TestO;L=杭州市;S=浙江省;C=CN;DC=DCTest" -iv ca_test.pvk -ic ca_test.cer -sv test.pvk test.cer

cert2spc test.cer  test.spc
pvk2pfx -pvk  test.pvk -spc  test.spc -pfx  test.pfx

set y=%date:~0,4%
set m=%date:~5,2%
set d=%date:~8,2%
set t=%time: =0% 
set h=%t:~0,2%
set mm=%t:~3,2%
ren test.cer test_%y%%m%%d%_%h%%mm%.cer
ren test.pvk test_%y%%m%%d%_%h%%mm%.pvk
ren test.spc test_%y%%m%%d%_%h%%mm%.spc
ren test.pfx test_%y%%m%%d%_%h%%mm%.pfx

