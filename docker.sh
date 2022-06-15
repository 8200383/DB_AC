sudo docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=ZsI1TZbFF7X" \
   -p 1433:1433 --name sql1 --hostname sql1 -e "MSSQL_PID=Developer"  \
   -d mcr.microsoft.com/mssql/server:2019-latest
