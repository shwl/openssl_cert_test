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
ren ca_rsa_private.key		ca_rsa_private_%y%%m%%d%_%h%%mm%.key
ren ca_cert.csr				ca_cert_%y%%m%%d%_%h%%mm%.csr
ren ca_cert.crt				ca_cert_%y%%m%%d%_%h%%mm%.crt
ren ca.pfx					ca_%y%%m%%d%_%h%%mm%.pfx

cd ..

rem 生成私玥;
openssl genrsa -aes256 -passout pass:111111 -out cert\ca_rsa_private.key 4096

rem 生成证书请求;
openssl req -utf8 -new -days 10950 -sha256 -key cert\ca_rsa_private.key -passin pass:111111 -out cert\ca_cert.csr -config ca.cnf

rem 根证书签发下级证书;
openssl ca -utf8 -extensions v3_ca -in cert\ca_cert.csr -config ca.cnf -days 10950 -out cert\ca_cert.crt -cert cert\root_cert.crt -keyfile cert\root_rsa_private.key -passin pass:111111 -batch

rem 转换文pfx格式证书;
openssl pkcs12 -export -inkey cert\ca_rsa_private.key -passin pass:111111 -in cert\ca_cert.crt -out cert\ca.pfx -passout pass:111111

pause