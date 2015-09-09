#!/bin/bash


curl -X PUT http://localhost:5984/newdb
curl -X POST -H 'Content-Type:application/json' -d ' { "_id": "12345" }' http://localhost:5984/newdb
curl -X POST -H 'Content-Type:application/json' -d ' { "source": "http://localhost:5984/newdb", "target": "http://10.0.2.15:8182/mydb" }' http://localhost:5984/_replicate
echo 'select * from docs;' | sqlite3 /tmp/datastores/mydb/db.sync

