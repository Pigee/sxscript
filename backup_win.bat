@echo off

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers cs_y_run > c:\file\databak\cs_y_run%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers cs_y_run_yinchuan > c:\file\databak\cs_y_run_yinchuan%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers bmw > c:\file\databak\bmw%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers cs_platform_dev > c:\file\databak\cs_platform_dev%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers finedb > c:\file\databak\finedb%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers gzl_center > c:\file\databak\gzl_center%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers os_y > c:\file\databak\os_y%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers rdp_server > c:\file\databak\rdp_server%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers report_demo > c:\file\databak\report_demo%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers znb_tp > c:\file\databak\znb_tp%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers yunzm > c:\file\databak\yunzm%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers ys_sx_full > c:\file\databak\ys_sx_full%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers ys_gzl > c:\file\databak\ys_gzl%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers sx_app_dev > c:\file\databak\sx_app_dev%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers snaker-web > c:\file\databak\snaker-web%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers sx_bim > c:\file\databak\sx_bim%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers sx_iot > c:\file\databak\sx_iot%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers sx_obh > c:\file\databak\sx_obh%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers sx_ytj > c:\file\databak\sx_ytj%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

c:\mysql8021\bin\mysqldump.exe -u sssxxx -ppassword -h 192.168.199.100 -E -R --triggers sx_platform_dev > c:\file\databak\sx_platform_dev%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.sql

forfiles /p "c:\file\databak\" /s /m *.* /d -3 /c "cmd /c del @path"

exit
