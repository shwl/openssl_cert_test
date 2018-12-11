%~d0
cd %~dp0

rem 重命名旧文件;
set y=%date:~0,4%
set m=%date:~5,2%
set d=%date:~8,2%
set t=%time: =0% 
set h=%t:~0,2%
set mm=%t:~3,2%

mkdir cert
cd cert

ren root_rsa_private.key		root_rsa_private_%y%%m%%d%_%h%%mm%.key
ren root_cert.crt				root_cert_%y%%m%%d%_%h%%mm%.crt
ren root.pfx					root_%y%%m%%d%_%h%%mm%.pfx

cd ..

rem 生成私玥;
openssl genrsa -aes256 -passout pass:111111 -out cert\root_rsa_private.key 1024

rem 生成签名证书;
openssl req -utf8 -new -x509 -days 18250 -key cert\root_rsa_private.key -passin pass:111111 -out cert\root_cert.crt -sha1 -config root.cnf -set_serial 0x248b483912a34da1f435da00

rem 转换文pfx格式证书;
openssl pkcs12 -export -inkey cert\root_rsa_private.key -passin pass:111111 -in cert\root_cert.crt -out cert\root.pfx -passout pass:111111

pause