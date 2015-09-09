#!/bin/bash

rm -rf /tmp/datastores
mkdir -p /tmp/datastores

# stop any existing docker containers
docker kill $(docker ps -q)

tmux new-session -s 'run_sync'  -d

tmux bind X kill-session

tmux split-window -t 'run_sync'

tmux send -t 'run_sync.0' "cd /vagrant";
tmux send -t 'run_sync.0' C-m;
tmux send -t 'run_sync.0' "GRADLE_OPTS='-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5006' ./gradlew executeApp -DDB_DIR=/tmp/datastores/";
tmux send -t 'run_sync.0' C-m;

tmux send -t 'run_sync.1' "./test_run.sh"
#tmux send -t 'run_sync.1' C-m;

tmux attach -t 'run_sync'
