
#!/bin/bash
DB="collectiondb"
USERNAME=
USER_PASSWORD=
HOSTS=$(ls -l /root/collection/data/srv/ | awk {'print $9'})
DATA_DIR=/root/collection/data/srv/

#function drop_tables() {
#mysql -u$USERNAME -p$USER_PASSWORD $DB -e "drop table cmp0001, cmp0003, cmp0007, cmp0008, cmp0009, win0001, win0002, win0003, win0004, win0005, win0006, win0009, win0111, win0112;;"
#}

function drop_tables() {
mysql -u$USERNAME -p$USER_PASSWORD $DB -e "DELETE FROM $table_name WHERE ID='1';"
}

function insert_in_tables() {
mysql -u$USERNAME -p$USER_PASSWORD $DB -e "LOAD DATA LOCAL INFILE '$DATA_DIR/$table_name' INTO TABLE $table_name FIELDS TERMINATED BY ' ';"
}

for table_name in $HOSTS;
    do drop_tables;
done

for table_name in $HOSTS;
    do insert_in_tables $table_name;
done
