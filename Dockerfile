FROM postgres:12.3

ENV METASTORE_DUMP tpcds30tb_metastore_3_1_3000

# The following environment variables related to upgrading the metastore are
# subject to change. Ideally the upgrade shouldn't be part of the responsibility
# of this project but purely handled by the Hive schemaTool. However at the
# moment it is impossible to use schema tool to pass from 3.1.3000 to 4.0.0 so
# we use the following vars for doing this.
ENV UPGRADE true
ENV UPGRADE_FROM 3.1.3000
ENV UPGRADE_TO 4.0.0

COPY dbdumps/ /tmp/dbdumps
COPY upgrades/ /tmp/upgrades
COPY init_user_db.sql /docker-entrypoint-initdb.d/init_user_db.sql
COPY restore_metastore.sh /docker-entrypoint-initdb.d/restore_metastore.sh
COPY upgrade_metastore.sh /docker-entrypoint-initdb.d/upgrade_metastore.sh
