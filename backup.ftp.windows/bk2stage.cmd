@echo off
setlocal EnableDelayedExpansion
    set /a p=0
    set "from=D:\SqlBackups\DBCLUSTER$MainDB\iikoNet\FULL"
    for /f "tokens=4" %%i in ('dir /O:-D "%from%\*.bak"') do (
							if !p!==2 (
								    set "last=%%i"
								   )
							set /a "p+=1"
							)
echo Last file: %last% >c:\backup\last.txt

ncftpput -z -v -F -r 50 -d c:\backup\bk2st.log -u Cloudberry -p Ftp#8pFzXff ftp.plazius.ru /CBB_backup/exchange/ "%from%\%last%"
ping 127.0.0.1 -n 30
ncftpput -z -v -F -r 50 -d c:\backup\bk2st.log -u Cloudberry -p Ftp#8pFzXff ftp.plazius.ru /CBB_backup/exchange/ "%from%\%last%"
ping 127.0.0.1 -n 30
ncftpput -z -v -F -r 50 -d c:\backup\bk2st.log -u Cloudberry -p Ftp#8pFzXff ftp.plazius.ru /CBB_backup/exchange/ "%from%\%last%"
ping 127.0.0.1 -n 30
ncftpput -z -v -F -r 50 -d c:\backup\bk2st.log -u Cloudberry -p Ftp#8pFzXff ftp.plazius.ru /CBB_backup/exchange/ "%from%\%last%"
ping 127.0.0.1 -n 30
ncftpput -z -v -F -r 50 -d c:\backup\bk2st.log -u Cloudberry -p Ftp#8pFzXff ftp.plazius.ru /CBB_backup/exchange/ "%from%\%last%"
ping 127.0.0.1 -n 30
ncftpput -z -v -F -r 50 -d c:\backup\bk2st.log -u Cloudberry -p Ftp#8pFzXff ftp.plazius.ru /CBB_backup/exchange/ "%from%\%last%"
ping 127.0.0.1 -n 30
ncftpput -z -v -F -r 50 -d c:\backup\bk2st.log -u Cloudberry -p Ftp#8pFzXff ftp.plazius.ru /CBB_backup/exchange/ "%from%\%last%"
ping 127.0.0.1 -n 30
ncftpput -z -v -F -r 50 -d c:\backup\bk2st.log -u Cloudberry -p Ftp#8pFzXff ftp.plazius.ru /CBB_backup/exchange/ "%from%\%last%"
ping 127.0.0.1 -n 30
ncftpput -z -v -F -r 50 -d c:\backup\bk2st.log -u Cloudberry -p Ftp#8pFzXff ftp.plazius.ru /CBB_backup/exchange/ "%from%\%last%"
ping 127.0.0.1 -n 30
ncftpput -z -v -F -r 50 -d c:\backup\bk2st.log -u Cloudberry -p Ftp#8pFzXff ftp.plazius.ru /CBB_backup/exchange/ "%from%\%last%"
ping 127.0.0.1 -n 30
ncftpput -z -v -F -r 50 -d c:\backup\bk2st.log -u Cloudberry -p Ftp#8pFzXff ftp.plazius.ru /CBB_backup/exchange/ "%from%\%last%"
ping 127.0.0.1 -n 30
ncftpput -z -v -F -r 50 -d c:\backup\bk2st.log -u Cloudberry -p Ftp#8pFzXff ftp.plazius.ru /CBB_backup/exchange/ "%from%\%last%"
ping 127.0.0.1 -n 30
ncftpput -z -v -F -r 50 -d c:\backup\bk2st.log -u Cloudberry -p Ftp#8pFzXff ftp.plazius.ru /CBB_backup/exchange/ "%from%\%last%"
ping 127.0.0.1 -n 30
ncftpput -z -v -F -r 50 -d c:\backup\bk2st.log -u Cloudberry -p Ftp#8pFzXff ftp.plazius.ru /CBB_backup/exchange/ "%from%\%last%"
ping 127.0.0.1 -n 30
ncftpput -z -v -F -r 50 -d c:\backup\bk2st.log -u Cloudberry -p Ftp#8pFzXff ftp.plazius.ru /CBB_backup/exchange/ "%from%\%last%"
ping 127.0.0.1 -n 30
ncftpput -z -v -F -r 50 -d c:\backup\bk2st.log -u Cloudberry -p Ftp#8pFzXff ftp.plazius.ru /CBB_backup/exchange/ "%from%\%last%"
move c:\backup\bk2st.log c:\backup\logs\%date%.log


