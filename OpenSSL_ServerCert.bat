%~d0
cd %~dp0

rem ���������ļ�;
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

rem ����˽�h;
openssl genrsa -aes256 -passout pass:111111 -out cert\server.pem 2048

rem �������ܺ��֤��˽Կ;
openssl rsa -in cert\server.pem -passin pass:111111 -out cert\server.key

rem ���ɷ�����֤��ǩ������;
openssl req -new -key cert/server.pem -passin pass:111111 -out cert/server.csr -subj "/C=CN/ST=ZJ/L=HZ/0=���������Ϣ�Ƽ����޹�˾(�ͻ��˲���)/OU=TGClientServer/CN=192.168.120.238"

rem ǩ��������֤��;
openssl ca -policy policy_anything -days 18250 -cert cert/ca_cert.crt -keyfile cert/ca_rsa_private.key  -passin pass:111111 -in cert/server.csr -out cert/server.crt

pause