CREATE KEYSPACE test_data WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 1};

CREATE TABLE test_data.text_received(
 time_sent TEXT,
 message TEXT,
PRIMARY KEY (time_sent)
);
