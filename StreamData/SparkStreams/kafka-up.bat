echo off
set KAFKA_BIN="C:\kafka\kafka_2.12-3.2.0\bin\windows"
set SPARK_SQL_KAFKA_DEP=org.apache.spark:spark-sql-kafka-0-10_2.12:3.0.3
set JAVA_HOME=C:\Program Files\AdoptOpenJDK\jdk-11.0.10.9-openj9\
set SPARK_HOME=C:\spark\spark-3.0.3-bin-hadoop3.2
set HADOOP_HOME=C:\spark\winutils\hadoop-3.2.0
set PATH=%PATH%;%HADOOP_HOME%\bin
set KAFKA_TMP_LOG_DIR="C:\tmp\kafka-logs"
set ZOOKEEPER_TMP_DIR="C:\tmp\zookeeper"

REM SPIN UP KAFKA
pushd %KAFKA_BIN%
echo Kafka may fail to delete topics, so deleting "tmp" folders.
echo on
rmdir /S /Q %KAFKA_TMP_LOG_DIR%
rmdir /S /Q %ZOOKEEPER_TMP_DIR%
echo off
start cmd /C .\zookeeper-server-start.bat "..\..\config\zookeeper.properties"
echo Wait Zookeeper to spin up
timeout /T 5
start cmd /C .\kafka-server-start.bat "..\..\config\server.properties"
echo Wait Kafka to spin up
timeout /T 5

REM LAUNCH SOLUTION
cmd /C .\kafka-topics.bat --create --if-not-exists --topic netology --replication-factor 1 --bootstrap-server localhost:9092
pip install --quiet kafka-python confluent-kafka
popd
start python "%~dp0producer.py"
start %SPARK_HOME%\bin\spark-submit --packages %SPARK_SQL_KAFKA_DEP% --master local[1] "%~dp0structure_streaming_kafka.py"
pushd %KAFKA_BIN%

REM SHUTDOWN KAFKA
echo Server is up. Hit any key to stop the server.
pause
cmd /C .\kafka-server-stop.bat
start .\zookeeper-server-stop.bat
pupd