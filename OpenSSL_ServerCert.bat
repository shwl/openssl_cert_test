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

ren server.key			server_%y%%m%%d%_%h%%mm%.key
ren server.cer			server_%y%%m%%d%_%h%%mm%.cer
ren server.csr			server_%y%%m%%d%_%h%%mm%.csr

cd ..

rem 生成私玥;
openssl genrsa -aes256 -passout pass:111111 -out cert\server.key 1024

rem 生成服务器证书签发申请;
openssl req -new -key cert/server.key -out cert/server.csr -subj "/C=CN/ST=ZJ/L=HZ/0=timevale_test/OU=timevale_test/CN=www.tsign.cn"

rem 签发服务器证书;
openssl x509 -req -days 18250 -sha256 -extensions v3_req -CA cert\ca_cert.cer -CAkey cert\ca_rsa_private.key -passin pass:111111 -CAserial ca_cert.srl -CAcreateserial -in cert/server.csr -out cert/server.cer

pause