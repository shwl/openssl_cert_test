%~d0
cd %~dp0
certutil2 -addstore -f root cert\root_cert.crt
certutil2 -addstore -f ca cert\ca_cert.crt