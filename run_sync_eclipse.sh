#!/bin/bash

sudo /etc/init.d/couchdb start

curl -X DELETE http://localhost:5984/newdb
curl -X PUT http://localhost:5984/newdb
curl -X POST -H 'Content-Type:application/json' -d ' { "_id": "12345" }' http://localhost:5984/newdb


rm -rf /tmp/datastores
mkdir -p /tmp/datastores



curl -X POST -H 'Content-Type:application/json' -d ' { "source": "http://localhost:5984/newdb", "target": "http://localhost:8182/mydb" }' http://localhost:5984/_replicate
echo 'select * from docs;' | sqlite3 /tmp/datastores/mydb/db.sync






