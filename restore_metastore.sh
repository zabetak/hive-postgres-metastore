#!/bin/bash
# Merge the different parts into a single dump file
cat /tmp/dbdumps/$METASTORE_DUMP/part* > /tmp/metastore.dump
# Restore may exit with non-blocking errors so we shouldn't stop the script
# since in many cases the dump will be restored correctly
pg_restore -d metastore /tmp/metastore.dump || true
# Remove the temporary file
rm /tmp/metastore.dump
