%~d0
cd %~dp0
certutil2 -addstore -f root root_test.cer
certutil2 -addstore -f ca ca_test.cer