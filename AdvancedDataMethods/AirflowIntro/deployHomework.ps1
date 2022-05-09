########################################################################################################
"INITIALIZATION" | Out-Host

:MAIN while ($true)
{

$proj_home = $env:PROJ_HOME
if ($proj_home -eq $null) {
    $proj_home = (Get-Location).Path
}

'Please, specify Airflow address and port or leave blank for default "localhost:8080"' | Out-Host
$airflow_addr = $(Read-Host).Trim()
if ($airflow_addr -eq '') {
    $airflow_addr = 'localhost:8080'
}

# Check the instance state
$(Invoke-WebRequest "http://$airflow_addr/api/v1/health" -ContentType 'application/json' -Method Get -Headers $authHeader).Content | Out-Host
if ($(Read-Host "Do you confirm that Airflow state is ready to deploy new DAGs? (y/n)") -ne 'y')
{
    break MAIN
}

$airflowCred = Get-Credential -Message 'Please, privide username/password for airflow service (airflow/airflow by default)'
$token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes("$($airflowCred.UserName):$($airflowCred.GetNetworkCredential().Password)"))
$authHeader = @{
    'Authorization' = "Basic $token"
}
########################################################################################################
"CREATE CONNECTIONS" | Out-Host

function Apply-Connection {
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true)]
        [String] $jsonBody,
        [Parameter(
            Mandatory = $true)]
        [Alias('AuthHeader')]
        $auth)

    process {
        $new_conn_id = ($jsonBody | ConvertFrom-Json).connection_id
        "`n" | Out-Host

        # Delete a connection with the same name as a new one
        $conn_list = $($(Invoke-WebRequest "http://$airflow_addr/api/v1/connections" `
                -ContentType 'application/json' `
                -Method Get `
                -Headers $auth).Content | ConvertFrom-Json).connections
        foreach ($conn in $conn_list) {
            if ($conn.connection_id -eq $new_conn_id) {
                $_foo = Invoke-WebRequest "http://$airflow_addr/api/v1/connections/$($new_conn_id)" `
                    -ContentType 'application/json' `
                    -Method Delete `
                    -Headers $auth

                "Old connection with id = '$new_conn_id' was deleted" | Out-Host
                break
            }
        }

        # Create a new connection
        $response = $(Invoke-WebRequest "http://$airflow_addr/api/v1/connections" `
            -ContentType 'application/json' `
            -Method Post `
            -Headers $auth `
            -Body $jsonBody)

        "Applied Connection = $($response.Content.Trim())`nStatusCode = $($response.StatusCode)`nStatusDescription = $($response.StatusDescription)"
    }
}

Get-ChildItem -Path "$proj_home\settings\connections\*.json" | Get-Content -Raw | Apply-Connection -AuthHeader $authHeader

########################################################################################################
"`nCREATE DAG's VARIABLES" | Out-Host

function Apply-Variable {
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true)]
        [String] $jsonBody,
        [Parameter(
            Mandatory = $true)]
        [Alias('AuthHeader')]
        $auth)

    process {
        $response = $(Invoke-WebRequest "http://$airflow_addr/api/v1/variables" `
            -ContentType 'application/json' `
            -Method Post `
            -Headers $auth `
            -Body $jsonBody)
        "`nApplied Variable = $($response.Content.Trim())`nStatusCode = $($response.StatusCode)`nStatusDescription = $($response.StatusDescription)`n"
    }
}

Get-ChildItem -Path "$proj_home\settings\variables\*.json" | Get-Content -Raw | Apply-Variable -AuthHeader $authHeader

########################################################################################################
"`nDEPLOYING PY AND SQL SCRIPTS" | Out-Host

New-Item -Path "$proj_home\airflow_docker\dags\sql" -ItemType Directory -ErrorAction SilentlyContinue
Copy-Item -Path "$proj_home\src\sql\*.sql" -Destination "$proj_home\airflow_docker\dags\sql" -Force
Copy-Item -Path "$proj_home\src\*.py" -Destination "$proj_home\airflow_docker\dags" -Force

"`nWaiting 60 seconds for Airflow to pick up changes" | Out-Host
Start-Sleep -Seconds 60

"`nDeployed DAGs' status" | Out-Host
$($(Invoke-WebRequest "http://$airflow_addr/api/v1/dags" -ContentType 'application/json' -Method Get -Headers $authHeader).Content | ConvertFrom-Json).dags `
    | Sort-Object -Property "fileloc" `
    | Format-Table -Property "dag_id","fileloc","is_active","is_paused","next_dagrun","last_parsed_time" `
    | Out-Host

########################################################################################################
break MAIN
}

########################################################################################################
"`nFINISHED" | Out-Host

"Press Enter button to exit..." | Out-Host
Read-Host