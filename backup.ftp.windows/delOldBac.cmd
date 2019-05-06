forfiles /P "D:\SqlBackups\DBCLUSTER$MainDB" /S /M *.* /D -7 /C "cmd /c del @path"
