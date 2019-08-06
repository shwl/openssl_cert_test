%~d0
cd %~dp0

cd cert

rem 重命名旧文件;
set y=%date:~0,4%
set m=%date:~5,2%
set d=%date:~8,2%
set t=%time: =0% 
set h=%t:~0,2%
set mm=%t:~3,2%
ren user_rsa_private.key		user_rsa_private_%y%%m%%d%_%h%%mm%.key
ren user_cert.csr				user_cert_%y%%m%%d%_%h%%mm%.csr
ren user_cert.crt				user_cert_%y%%m%%d%_%h%%mm%.crt
ren user.pfx					user_%y%%m%%d%_%h%%mm%.pfx

cd ..

rem 生成私玥;
openssl genrsa -aes256 -passout pass:111111 -out cert\user_rsa_private.key 2048

rem 生成证书请求;
openssl req -utf8 -new -days 3650 -key cert\user_rsa_private.key -passin pass:111111 -out cert\user_cert.csr -config user.cnf

rem 中级证书签发下级证书;
openssl ca -utf8 -in cert\user_cert.csr -config user.cnf -days 365 -out cert\user_cert.crt -cert cert\ca_cert.crt -keyfile cert\ca_rsa_private.key -passin pass:111111 -batch

rem 转换文pfx格式证书;
openssl pkcs12 -export -inkey cert\user_rsa_private.key -passin pass:111111 -in cert\user_cert.crt -out cert\user.pfx -passout pass:111111

pause