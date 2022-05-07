$airflowCred = Get-Credential -Message 'Please, privide username/password for airflow service (airflow/airflow by default)'
$token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes("$($airflowCred.UserName):$($airflowCred.GetNetworkCredential().Password)"))
$authHeader = @{
    'Authorization' = "Basic $token"
}

# Check the instance state
$(Invoke-WebRequest 'http://localhost:8080/api/v1/health' -ContentType 'application/json' -Method Get -Headers $authHeader).Content | Out-Host
if ($(Read-Host "Do you confirm that Airflow state is ready to deploy new DAGs? (y/n)") -eq 'y')
{

"CREATE CONNECTIONS" | Out-Host
"postgresql_movies_db:" | Out-Host
$pgMoviesConn = @"
{
    "connection_id": "postgresql_movies_db",
    "conn_type": "Postgres",
    "host": "host.docker.internal",
    "login": "postgres",
    "schema": "movies",
    "port": 5433,
    "password": "I5jvu8wZsy9z"
}
"@
$(Invoke-WebRequest 'http://localhost:8080/api/v1/connections' -ContentType 'application/json' -Method Post -Headers $authHeader -Body $pgMoviesConn).StatusDescription | Out-Host

"FTP_LOCALHOST:" | Out-Host
$ftpLocalhost = @"
{
    "connection_id": "ftp_localhost",
    "conn_type": "FTP",
    "host": "host.docker.internal",
    "login": "airflow_ftp_user",
    "schema": "",
    "port": 21,
    "password": "Aa123456"
}
"@
$(Invoke-WebRequest 'http://localhost:8080/api/v1/connections' -ContentType 'application/json' -Method Post -Headers $authHeader -Body $ftpLocalhost).StatusDescription | Out-Host

"CREATE DAG's VARIABLES" | Out-Host
"ARGS_CONFIG:" | Out-Host
$argsConfig = @"
{
    "key": "ARGS_CONFIG",
    "value": "{\"owner\": \"v.kisel\", \"start_year\": \"2021\", \"start_month\": \"9\", \"start_day\": \"4\", \"start_hour\": \"1\", \"start_minute\": \"30\"}"
}
"@
$(Invoke-WebRequest 'http://localhost:8080/api/v1/variables' -ContentType 'application/json' -Method Post -Headers $authHeader -Body $argsConfig).StatusDescription | Out-Host
"DAG_CONFIG" | Out-Host
$dagConfig = @"
{
    "key": "DAG_CONFIG",
    "value": "{\"dag_id\": \"my-first-dag\", \"max_active_runs\": \"10\", \"concurrency\": \"10\", \"description\": \"DAG for sending email with CSV file report\", \"schedule_interval\": \"1\"}"
}
"@
$(Invoke-WebRequest 'http://localhost:8080/api/v1/variables' -ContentType 'application/json' -Method Post -Headers $authHeader -Body $dagConfig).StatusDescription | Out-Host
"EMAIL" | Out-Host
$email = @"
{
    "key": "EMAIL",
    "value": "basilix@yandex.ru"
}
"@
$(Invoke-WebRequest 'http://localhost:8080/api/v1/variables' -ContentType 'application/json' -Method Post -Headers $authHeader -Body $email).StatusDescription | Out-Host
"PG_MOVIES_CONN_ID" | Out-Host
$pgMoviesConnId = @"
{
    "key": "PG_MOVIES_CONN_ID",
    "value": "postgresql_movies_db"
}
"@
$(Invoke-WebRequest 'http://localhost:8080/api/v1/variables' -ContentType 'application/json' -Method Post -Headers $authHeader -Body $pgMoviesConnId).StatusDescription | Out-Host
"FTP_LOCAL_CONN" | Out-Host
$ftpLocalCOnn = @"
{
    "key": "FTP_LOCAL_CONN",
    "value": "ftp_localhost"
}
"@
$(Invoke-WebRequest 'http://localhost:8080/api/v1/variables' -ContentType 'application/json' -Method Post -Headers $authHeader -Body $ftpLocalCOnn).StatusDescription | Out-Host
"FTP_REPORT_PATH" | Out-Host
$ftpReportPath = @"
{
    "key": "FTP_REPORT_PATH",
    "value": "/report/report.csv"
}
"@
$(Invoke-WebRequest 'http://localhost:8080/api/v1/variables' -ContentType 'application/json' -Method Post -Headers $authHeader -Body $ftpReportPath).StatusDescription | Out-Host


Copy-Item -Path .\airflow_operator.py -Destination .\airflow_docker\dags -Force
Copy-Item -Path .\airflow_dag.py -Destination .\airflow_docker\dags -Force

New-Item -Path .\airflow_docker\dags\sql -ItemType Directory -ErrorAction SilentlyContinue
Copy-Item -Path .\sql\* -Destination .\airflow_docker\dags\sql -Force
Copy-Item -Path .\fill_movies_dag.py -Destination .\airflow_docker\dags -Force

Start-Sleep -Seconds 60

"`nDeployed DAGs' status" | Out-Host
$(Invoke-WebRequest 'http://localhost:8080/api/v1/dags/my-first-dag' -ContentType 'application/json' -Method Get -Headers $authHeader).Content | Out-Host
$(Invoke-WebRequest 'http://localhost:8080/api/v1/dags/load_movies_table' -ContentType 'application/json' -Method Get -Headers $authHeader).Content | Out-Host

}