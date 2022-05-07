# According to "https://airflow.apache.org/docs/apache-airflow/stable/start/docker.html"

Push-Location .\airflow_docker
docker-compose down --volumes --remove-orphans
Pop-Location
Remove-Item -Force -Recurse .\airflow_docker