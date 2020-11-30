#!/bin/sh -l

echo $INPUT_FLYWAY_CONF_SHA | base64 -d > /flyway/conf/flyway.conf

cp $INPUT_FLYWAY_SQL/* /flyway/sql

flyway info
sh /pre-migration.sh
flyway migrate
sh /post-migration.sh
flyway info
