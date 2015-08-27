#!/bin/bash

sudo /etc/init.d/couchdb start

echo "Cleaning up 'newdb'"

curl -X DELETE http://localhost:5984/newdb
curl -X PUT http://localhost:5984/newdb
curl -X POST -H 'Content-Type:application/json' -d ' { "_id": "12345" }' http://localhost:5984/newdb

read -p "Stop debugging 'App' in eclipse.  Press ENTER when done."

echo "Cleaning up sqlite datastores"
rm -rf /tmp/datastores
mkdir -p /tmp/datastores

read -p "Start debugging 'App' in eclipse.  Press ENTER when done."


echo "Sending '_replicate' request"
curl --connect-timeout 3600 -X POST -H 'Content-Type:application/json' -d ' { "source": "http://localhost:5984/newdb", "target": "http://localhost:8182/mydb" }' http://localhost:5984/_replicate

response=$?

if [[ $response == 0 ]]
then
  echo "checking sqlite has had document replicated to it"
  echo 'select * from docs;' | sqlite3 /tmp/datastores/mydb/db.sync
fi





