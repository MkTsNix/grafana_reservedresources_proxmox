#!/bin/bash
USERNAME=''
USER_PASSWORD=''
DB="collectiondb"

mysql -u$USERNAME -p$USER_PASSWORD -e "CREATE DATABASE $DB;"
