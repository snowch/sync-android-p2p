#!/bin/bash

sudo /etc/init.d/couchdb start

curl -X DELETE http://localhost:5984/newdb
curl -X PUT http://localhost:5984/newdb
curl -X POST -H 'Content-Type:application/json' -d ' { "_id": "12345" }' http://localhost:5984/newdb


rm -rf /tmp/datastores
mkdir -p /tmp/datastores


tmux new-session -s 'run_sync'  -d

tmux split-window -t 'run_sync'

tmux send -t 'run_sync.0' "cd /vagrant/sync-android-p2p";
tmux send -t 'run_sync.0' C-m;
tmux send -t 'run_sync.0' "GRADLE_OPTS='-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5006' ./gradlew execute -DDB_DIR=/tmp/datastores/";
tmux send -t 'run_sync.0' C-m;


tmux send -t 'run_sync.1' "sleep 30";
tmux send -t 'run_sync.1' C-m;
tmux send -t 'run_sync.1' "curl -X POST -H 'Content-Type:application/json' -d ' { \"source\": \"http://localhost:5984/newdb\", \"target\": \"http://localhost:8182/mydb\" }' http://localhost:5984/_replicate";
tmux send -t 'run_sync.1' C-m;
tmux send -t 'run_sync.1' "echo 'select * from docs;' | sqlite3 /tmp/datastores/mydb/db.sync";
tmux send -t 'run_sync.1' C-m;

tmux attach -t 'run_sync'





