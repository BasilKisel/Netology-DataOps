set SPARK_HOME=C:\spark\spark-3.2.1-bin-hadoop3.2
%SPARK_HOME%\bin\spark-submit --master local[2] "%~dp0wordcounter.py"