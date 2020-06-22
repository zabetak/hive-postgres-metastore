#!/bin/bash

if [ "$UPGRADE" = true ] ; then
    echo "Attempt to upgrade the metastore version from $UPGRADE_FROM to $UPGRADE_TO"
    upgradeFile="/tmp/upgrades/$UPGRADE_FROM-to-$UPGRADE_TO.sql"
    if [ -f "$upgradeFile" ]; then
      psql -U hive -d metastore -f $upgradeFile
      echo "Upgrade finished sucessfully"
    else
      echo "Upgrade file $upgradeFile is missing."
      echo "Check the environment variables UPGRADE_FROM and UPGRADE_TO and verify that the upgrade is supported."
    fi
fi
