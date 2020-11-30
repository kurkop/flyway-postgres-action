#! /bin/bash
## delete old files

cd /flyway/conf/

export PGUSER=$(grep -i flyway.user flyway.conf | awk -F "=" '{print $2}')
export PGPASSWORD=$(grep -i flyway.password flyway.conf | awk -F "=" '{print $2}')
export PGHOST=$(grep -i flyway.url flyway.conf | awk -F "/" '{print $3}' | awk -F ":" '{print $1}')
export PGDATABASE=$(grep -i flyway.url flyway.conf | awk -F "/" '{print $4}')

cd /flyway/sql/

for f in * 
do
  _date=$(date +"V%Y%m%d%H%M%S%N__")
  mv "$f" "$_date$f"
done

psql -t -c"SELECT script FROM flyway_schema_records WHERE script !='<< Flyway Baseline >>';" >to_delete_files.sh
while read file
do
  echo $file | awk -F"__V" '{print "rm -rf *"$2}' | grep -i sql >>Delete_Files.sh
done < to_delete_files.sh
bash Delete_Files.sh

## delete old files

cd /flyway/conf/

export PGUSER=$(grep -i flyway.user flyway.conf | awk -F "=" '{print $2}')
export PGPASSWORD=$(grep -i flyway.password flyway.conf | awk -F "=" '{print $2}')
export PGHOST=$(grep -i flyway.url flyway.conf | awk -F "/" '{print $3}' | awk -F ":" '{print $1}')
export PGDATABASE=$(grep -i flyway.url flyway.conf | awk -F "/" '{print $4}')

psql -c"DELETE FROM flyway_schema_history WHERE installed_rank >1;" 

