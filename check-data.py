#ssc.stop(stopSparkContext=False,stopGraceFully=True)
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

data=sqlContext.read \
    .format("org.apache.spark.sql.cassandra") \
    .options(table="text_received", keyspace="test_data") \
    .load()
data.show()
