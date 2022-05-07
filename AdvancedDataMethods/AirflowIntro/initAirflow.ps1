# According to "https://airflow.apache.org/docs/apache-airflow/stable/start/docker.html"

New-Item -Path .\airflow_docker -ItemType Directory -ErrorAction SilentlyContinue
Push-Location .\airflow_docker

Invoke-WebRequest 'https://airflow.apache.org/docs/apache-airflow/2.3.0/docker-compose.yaml' -OutFile .\docker-compose.yaml
New-Item -ItemType Directory -Path ./dags
New-Item -ItemType Directory -Path ./logs
New-Item -ItemType Directory -Path ./plugins
docker-compose up airflow-init

Pop-Location