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
openssl genrsa -aes256 -passout pass:111111 -out cert\server.pem 2048

rem 制作解密后的证书私钥;
openssl rsa -in cert\server.pem -passin pass:111111 -out cert\server.key

rem 生成服务器证书签发申请;
openssl req -new -key cert/server.pem -passin pass:111111 -out cert/server.csr -subj "/C=CN/ST=ZJ/L=HZ/0=杭州天谷信息科技有限公司(客户端测试)/OU=TGClientServer/CN=192.168.120.238"

rem 签发服务器证书;
openssl ca -policy policy_anything -days 18250 -cert cert/ca_cert.crt -keyfile cert/ca_rsa_private.key  -passin pass:111111 -in cert/server.csr -out cert/server.crt

pause