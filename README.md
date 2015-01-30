# sync-android-p2p
This project implements a http listener on top of sync-android to allow sync-android to become a replication target.

This project is a prototype.  It can perform a basic replication based on the steps below.  A lot more functionality needs to be implemented to support replication proper.  Also expect lots of bugs, this code needs much more testing.

- check out sync-android
```
git clone https://github.com/cloudant/sync-android
cd sync-android
```

- we need the lastest sync-android libraries, so install 0.9.4-SNAPSHOT install ~/.m2 repository
```
gradle install
```

- check out this project
```
git clone https://github.com/snowch/sync-android-p2p
cd sync-android-p2p
```

- create a directory to hold the sqlite datastore
```
mkdir -p /tmp/datastores
```

- execute this project
```
gradle execute -DDB_DIR=/tmp/datastores/
```
Example output: `> Building 75% > :execute`


- in another terminal window start couchDB
```
couchdb
```

- create a database on couchdb
```
curl -X PUT http://localhost:5984/newdb
```

- add a document to couchdb
```
curl -X POST -H 'Content-Type:application/json' -d '
{
  "_id": "12345"
}' http://localhost:5984/newdb
```

- start replication on couchdb to sync-android
```
curl -X POST -H 'Content-Type:application/json' -d '
{
  "source": "http://localhost:5984/newdb",
  "target": "http://localhost:8182/mydb"
}' http://localhost:5984/_replicate
```

- make sure our document 12345 was replicated
```
echo 'select * from docs;' | sqlite3 /tmp/datastores/mydb/db.sync
```
Example output: `1|12334`
