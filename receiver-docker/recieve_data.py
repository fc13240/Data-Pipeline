import os
os.environ['PYSPARK_SUBMIT_ARGS'] = '--conf spark.ui.port=4040 --packages org.apache.spark:spark-streaming-kafka-0-8_2.11:2.0.0,com.datastax.spark:spark-cassandra-connector_2.11:2.0.0-M3 pyspark-shell'
import time

from pyspark import SparkContext, SparkConf
from pyspark.sql import SQLContext, Row
conf = SparkConf() \
    .setAppName("Streaming test") \
    .setMaster("local[2]") \
    .set("spark.cassandra.connection.host", "127.0.0.1")
sc = SparkContext(conf=conf)
sqlContext=SQLContext(sc)
from pyspark.streaming import StreamingContext
from pyspark.streaming.kafka import KafkaUtils

def saveToCassandra(rows):
    if not rows.isEmpty():
        sqlContext.createDataFrame(rows).write\
        .format("org.apache.spark.sql.cassandra")\
        .mode('append')\
        .options(table="text_received", keyspace="test_data")\
        .save()


ssc = StreamingContext(sc, 5)
kvs = KafkaUtils.createStream(ssc, "127.0.0.1:2181", "spark-streaming-consumer", {'test': 1})
data = kvs.map(lambda x: x[1])
rows= data.map(lambda x:Row(message=x,time_received=time.strftime("%Y-%m-%d %H:%M:%S")))
rows.foreachRDD(saveToCassandra)
rows.pprint()

ssc.start()
