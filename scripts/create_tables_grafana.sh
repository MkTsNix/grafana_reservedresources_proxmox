#!/bin/bash
DB="collectiondb"
USERNAME=
USER_PASSWORD=
HOSTS=$(ls -l /root/collection/data/srv/ | awk {'print $9'})

function create_tables() {
mysql -u$USERNAME -p$USER_PASSWORD $DB -e "create table $table_name(ID INT, name VARCHAR(10), using_cores INT, using_ram INT, cores_on_node INT, ram_on_node INT);"
}

for table_name in $HOSTS; do create_tables $table_name; done
