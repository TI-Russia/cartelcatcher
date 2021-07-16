:1
pushd
start /min php.exe -f daemon.php
popd
timeout 60
goto 1: