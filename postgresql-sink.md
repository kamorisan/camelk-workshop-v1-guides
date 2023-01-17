## PostgresSQL との連携
---

### 1. 目的

Kamelet の **PostgreSQL Sink** を使用して、Camel K と Kafka との連携の方法について理解していただきます。

* [PostgreSQL Sink](https://camel.apache.org/camel-kamelets/{{ KAMELETS_VERSION }}/postgresql-sink.html)


### 2. PostgreSQL Sink を使用してテーブルからデータを取得する

PostgreSQL についての 情報

* Server Name: {{ POSTGRESQL_SERVER }}
* Server Port: 5432
* User Name: demo
* Password: demo
* Database Name: sampledb