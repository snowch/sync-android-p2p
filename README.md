# sync-android-p2p
http listener to support p2p on sync-android

check out sync-android
```
git clone https://github.com/cloudant/sync-android
cd sync-android
```

we need the lastest sync-android libraries, so
install 0.9.4-SNAPSHOT install ~/.m2 repository
`gradle install`

check out this project
`git clone https://github.com/snowch/sync-android-p2p`
`cd sync-android-p2p`

create a directory to hold the sqlite datastore
`mkdir -p /tmp/datastores`

execute this project
`gradle execute -DDB_DIR=/tmp/datastores/`

in another terminal window start couchDB
`couchdb`

create a database on couchdb
`curl -X PUT http://localhost:5984/newdb`

add a document
`curl -X POST -H 'Content-Type:application/json' -d '
{
  "_id": "12345"
}' http://localhost:5984/newdb`


start replication
`curl -X POST -H 'Content-Type:application/json' -d '
{
  "source": "http://localhost:5984/newdb",
  "target": "http://localhost:8182/mydb"
}' http://localhost:5984/_replicate`

make sure our document 12345 was replicated
`echo 'select * from docs;' | sqlite3 /tmp/datastores/mydb/db.sync`
