The following commands were used to create the dumps and split them into files.

    pg_dump -h localhost -p 5432 -U hive -d metastore -Fc > meta.dump
    split -b 25m -d meta.dump part  

Depending from where the dump is taken host, port, user, dbname, and password
have to be adapted accordingly.
