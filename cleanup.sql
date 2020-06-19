-- Script for partially anonymizing and cleaning up the dump.
-- WARNING: The script is not guaranteed to cover any kind of metastore
-- (not even close). It is mostly suitable for cases encountered so far.

-- Statements to remove potentially sensitive URIs and usernames.
UPDATE "CTLGS" SET "LOCATION_URI" = REGEXP_REPLACE("LOCATION_URI",'(s3a|hdfs)://[^/]+','hdfs://localhost:40889');
UPDATE "DBS" SET "DB_LOCATION_URI" = REGEXP_REPLACE("DB_LOCATION_URI",'(s3a|hdfs)://[^/]+','hdfs://localhost:40889');
UPDATE "DBS" SET "OWNER_NAME" = 'hive' WHERE "OWNER_NAME" IS NOT NULL AND "OWNER_NAME" <> 'public';
UPDATE "SDS" SET "LOCATION" = REGEXP_REPLACE("LOCATION",'(s3a|hdfs)://[^/]+','hdfs://localhost:40889') WHERE "LOCATION" IS NOT NULL;
UPDATE "TBLS" SET "OWNER" = 'hive' WHERE "OWNER" IS NOT NULL AND "OWNER" <> 'public';
-- Statements to cleanup potentiall incomplete transactions.
TRUNCATE TABLE "HIVE_LOCKS" CASCADE ;
TRUNCATE TABLE "NOTIFICATION_LOG";
TRUNCATE TABLE "TXNS" CASCADE;
TRUNCATE TABLE "TXN_TO_WRITE_ID";
