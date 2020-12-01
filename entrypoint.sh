#!/bin/sh -l

echo $INPUT_FLYWAY_CONF_SHA | base64 -d > /flyway/conf/flyway.conf

cp $INPUT_FLYWAY_SQL/* /flyway/sql

flyway info
bash /pre-migration.sh
flyway migrate
flyway info
bash /post-migration.sh
