#!/bin/bash

# Adicionando conector para Postgres
# Parâmetros do JSON:
# - name: Nome do conector
# - config.connector.class: Classe do conector Postgres do Debezium
# - config.tasks.max: Número máximo de tarefas paralelas
# - config.database.hostname: Hostname do banco de dados
# - config.database.port: Porta do banco de dados
# - config.database.user: Usuário do banco
# - config.database.password: Senha do banco
# - config.database.dbname: Nome do banco de dados
# - config.database.server.name: Nome lógico do servidor
# - config.slot.name: Nome do slot de replicação
# - config.plugin.name: Plugin de publicação do Postgres
# - config.topic.prefix: Prefixo dos tópicos Kafka
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
    "snapshot.mode": "always"
  }
}' http://localhost:8083/connectors

# Adicionando conector para MySQL
# Parâmetros do JSON:
# - name: Nome do conector
# - config.connector.class: Classe do conector MySQL do Debezium
# - config.tasks.max: Número máximo de tarefas paralelas
# - config.database.hostname: Hostname do banco de dados
# - config.database.port: Porta do banco de dados
# - config.database.user: Usuário do banco
# - config.database.password: Senha do banco
# - config.database.server.name: Nome lógico do servidor
# - config.database.include.list: Lista de bancos a serem monitorados
# - config.topic.prefix: Prefixo dos tópicos Kafka
# - config.snapshot.mode: Modo de snapshot inicial
# - config.database.server.id: ID único do servidor
# - config.schema.history.internal.kafka.topic: Tópico para histórico de schema
# - config.schema.history.internal.kafka.bootstrap.servers: Endereço do broker Kafka
# - config.schema.history.internal.skip.unparseable.ddl: Pular DDL não analisável
# - config.schema.history.internal.recover: Recuperar histórico em caso de falha
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

# Adding connector for MongoDB
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
    "snapshot.mode": "always"
  }
}' http://localhost:8083/connectors