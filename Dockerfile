FROM postgres:12.3

ENV METASTORE_DUMP tpcds30tb_metastore_3_1_3000

COPY dbdumps/ /tmp/dbdumps
COPY init_user_db.sql /docker-entrypoint-initdb.d/init_user_db.sql
COPY restore_metastore.sh /docker-entrypoint-initdb.d/restore_metastore.sh
