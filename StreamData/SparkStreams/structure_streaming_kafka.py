from pyspark.sql import SparkSession
from time import sleep
from pyspark.sql.functions import col,from_json
from pyspark.sql.types import StructType, StringType, IntegerType

# явным образом задаем структуру json-контента
schema = StructType().add("id",IntegerType()).add("action", StringType())

users_schema = StructType().add("id",IntegerType()).add("user_name", StringType()).add("user_age", IntegerType())

spark = SparkSession.builder.appName("SparkStreamingKafka").getOrCreate()
spark.sparkContext.setLogLevel('WARN')

# static dataset - эмуляция внешнего источника данных

input_stream = spark \
  .readStream \
  .format("kafka") \
  .option("kafka.bootstrap.servers", "localhost:9092") \
  .option("subscribe", "netology") \
  .option("failOnDataLoss", False) \
  .load()

#покажем входящий контент
#input_stream.writeStream.format("console").outputMode("append").start().awaitTermination()
#input_stream = input_stream.writeStream.format("console").outputMode("append").start()


#разберем входящий контент из json
json_stream = input_stream.select(col("timestamp").cast("string"), from_json(col("value").cast("string"), schema).alias("parsed_value"))
#проверим что все ок
#json_stream.printSchema()
#json_stream.writeStream.format("console").outputMode("append").option("truncate", False).start().awaitTermination()

#выделем интересующие элементы
clean_data = json_stream.select(col("timestamp"), col("parsed_value.id").alias("id"), col("parsed_value.action").alias("action"))
#проверим
#clean_data.writeStream.format("console").outputMode("append").option("truncate", False).start().awaitTermination()

#добавим агрегат - отображать число уникальных айдюков
stat_stream = clean_data.groupBy("id").count().alias("stat")
#stat_stream.writeStream.format("console").outputMode("complete").option("truncate", False).start().awaitTermination()


#добавим join с статическим dataset - создаем данные
users_data = [(1,"Jimmy",18),(2,"Hank",48),(3,"Johnny",9),(4,"Erle",40)]
users = spark.createDataFrame(data=users_data,schema=users_schema).alias("users")
#users.repartition(1).write.csv("static/users","overwrite",header=True)

#делаем join
stat_join_stream = stat_stream.join(users, stat_stream.id == users.id, "left_outer").select(col('stat.id').alias("id"), col('user_name'), col('user_age'), col('count'))

stat_join_stream.printSchema()

res = stat_join_stream.writeStream.\
  format("console").\
  outputMode("complete").\
  option("truncate", False).\
  option("checkpointLocation", "checkpoint/target").\
  trigger(processingTime = '5 seconds').\
  start()

sleep(120)
res.stop()