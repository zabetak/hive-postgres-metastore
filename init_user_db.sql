CREATE ROLE hive WITH LOGIN PASSWORD 'hive';
-- Required if metastore dump is coming from Amazon RDS
CREATE ROLE rdsadmin WITH PASSWORD 'rdsadmin';

CREATE DATABASE metastore WITH OWNER = hive TEMPLATE template0;
