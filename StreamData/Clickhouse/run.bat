pushd "%~dp0"
docker stop clickhouse-server-local
docker rm clickhouse-server-local
docker run -d --name clickhouse-server-local --ulimit nofile=262144:262144 clickhouse/clickhouse-server
docker cp .\dsw\metrika_sample.tsv clickhouse-server-local:/tmp/metrika_sample.tsv
docker cp .\clickhouse-homework.sh clickhouse-server-local:/tmp/clickhouse-homework.sh
docker exec clickhouse-server-local chmod u+x /tmp/clickhouse-homework.sh
docker exec -it clickhouse-server-local /bin/bash -v /tmp/clickhouse-homework.sh
popd
pause