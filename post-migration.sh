#! /bin/bash
## delete old files

cd /flyway/conf/

export PGUSER=$(grep -i flyway.user flyway.conf | awk -F "=" '{print $2}')
export PGPASSWORD=$(grep -i flyway.password flyway.conf | awk -F "=" '{print $2}')
export PGHOST=$(grep -i flyway.url flyway.conf | awk -F "/" '{print $3}' | awk -F ":" '{print $1}')
export PGDATABASE=$(grep -i flyway.url flyway.conf | awk -F "/" '{print $4}')

psql -c"DELETE FROM flyway_schema_history WHERE installed_rank >1;" 

## grants on tables and sequences

export control="excelloader"

if [ $PGDATABASE == $control ]
then
  psql -t -c"SELECT 'GRANT SELECT, INSERT, UPDATE, DELETE ON ' || table_schema ||'.'||table_name || ' TO app_group;' FROM information_schema.tables WHERE table_schema='public' UNION SELECT 'GRANT USAGE ON '||sequence_schema ||'.'|| sequence_name||' TO app_group;' FROM information_schema.sequences order by (1);" >grants_tables_sequences.sql
else
  psql -t -c"SELECT 'GRANT SELECT, INSERT, UPDATE, DELETE ON ' || table_schema ||'.'||table_name || ' TO app_group;' FROM information_schema.tables WHERE table_schema='public' UNION SELECT 'GRANT USAGE ON '||sequence_schema ||'.'|| sequence_name||' TO app_group;' FROM information_schema.sequences order by (1);" >grants_tables_sequences.sql
  psql -t -c"SELECT 'GRANT SELECT, INSERT, UPDATE, DELETE ON ' || table_schema ||'.'||table_name || ' TO appintegrationrndc;' FROM information_schema.tables WHERE table_schema='rndc' UNION SELECT 'GRANT USAGE ON '||sequence_schema ||'.'|| sequence_name||' TO app_group;' FROM information_schema.sequences order by (1);" >>grants_tables_sequences.sql
fi

echo "Grants on $PGDATABASE"
psql < grants_tables_sequences.sql
