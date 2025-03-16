#!/bin/bash

# Adicionando conector para Postgres
curl -X POST -H "Content-Type: application/json" --data '{
  "name": "postgres-connector",
  "config": {
    "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
    "tasks.max": "1",
    "database.hostname": "postgres",
    "database.port": "5432",
    "database.user": "user",
    "database.password": "pass",
    "database.dbname": "mydb",
    "database.server.name": "pg_server",
    "slot.name": "debezium",
    "plugin.name": "pgoutput",
    "topic.prefix": "pg",
    "snapshot.mode": "no_data"
  }
}' http://localhost:8083/connectors

# Adicionando conector para MySQL
curl -X POST -H "Content-Type: application/json" --data '{
  "name": "mysql-connector",
  "config": {
    "connector.class": "io.debezium.connector.mysql.MySqlConnector",
    "tasks.max": "1",
    "database.hostname": "mysql",
    "database.port": "3306",
    "database.user": "root",
    "database.password": "pass",
    "database.server.name": "mysql_server",
    "database.include.list": "mydb",
    "topic.prefix": "mysql",
    "snapshot.mode": "schema_only",
    "database.server.id": "1002",
    "schema.history.internal.kafka.topic": "mysql_history_internal",
    "schema.history.internal.kafka.bootstrap.servers": "kafka:9092",
    "schema.history.internal.skip.unparseable.ddl": "true",
    "schema.history.internal.recover": "true"
  }
}' http://localhost:8083/connectors

# Adiciona conector para MongoDB
curl -X POST -H "Content-Type: application/json" --data '{
  "name": "mongo-connector",
  "config": {
    "connector.class": "io.debezium.connector.mongodb.MongoDbConnector",
    "mongodb.connection.string": "mongodb://user:pass@mongo1:27017,mongo2:27018/?replicaSet=rs0",
    "mongodb.name": "my-mongodb",
    "mongodb.user": "user",
    "mongodb.password": "pass",
    "database.history.kafka.bootstrap.servers": "kafka:9092",
    "database.history.kafka.topic": "schema-changes.mongodb",
    "capture.mode": "change_streams",
    "topic.prefix": "mongo",
    "snapshot.mode": "no_data"
  }
}' http://localhost:8083/connectors