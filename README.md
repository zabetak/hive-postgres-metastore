# Hive metastores in Postgres

The project holds database dumps from [Hive metastores](https://cwiki.apache.org/confluence/display/Hive/AdminManual+Metastore+3.0+Administration)
and scripts to quickly spin up a dockerized Postgres from a given dump.

The current dumps hold metastore data from various [TPC-DS](http://www.tpc.org/tpcds/)
scale factors.

## Usage

-   Install [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/install/)
-   Create and start Postgres container: `docker-compose up`      
-   Stop and remove Postgres container: `docker-compose down`

By default the database will be initialized with `tpcds30tb_metastore_3_1_3000`
dump. You can choose another dump by changing the `METASTORE_DUMP` variable in
`docker-compose.yml`.

If you want to check the contents of the metastore the easiest way would be to
open a shell in the container and connect to the database via psql.

    docker exec -it CONTAINER_ID bash
    su postgres
    psql -U hive -d metastore

The default configuration binds the host port 5432 to the database running in
the container. You can access the database via JDBC using the following
information:

-   URL: `jdbc:postgresql://localhost:5432/metastore`
-   DRIVER: `org.postgresql.Driver`
-   USER: `hive`
-   PASSWORD: `hive`

If you want to start Hive and instruct it to use this database as the metastore
you have to set the following properties in `hive-site.xml`:

-   `javax.jdo.option.ConnectionURL`
-   `javax.jdo.option.ConnectionDriverName`
-   `javax.jdo.option.ConnectionUserName`
-   `javax.jdo.option.ConnectionPassword`

## Dumps and metastore versions

The database dumps are located under the `dbdumps` directory. Their name
indicates the main dataset represented by the store as well as the version of
the metastore.

At the moment, the dumps are not clean meaning that they do not contain only a
single Hive database. We highlight below the name of the Hive database that is
the most relevant for exploration and testing purposes:

| Dump                         | Hive DB Name                    |
| ---------------------------- | ------------------------------- |
| tpcds10tb_metastore_3_1_3000 | tpcds_bin_partitioned_orc_10000 |
| tpcds30tb_metastore_3_1_3000 | tpcds_bin_partitioned_orc_30000 |

If you need to use the current dumps with a more recent version of Hive then
after creating and starting the Postgres container you can use the
[schematool](https://cwiki.apache.org/confluence/display/Hive/Hive+Schema+Tool)
to upgrade the metastore:

    schematool -dbType postgres -upgradeSchemaFrom 3.1.3000 -driver org.postgresql.Driver -url jdbc:postgresql://localhost:5432/metastore -userName hive -passWord hive
