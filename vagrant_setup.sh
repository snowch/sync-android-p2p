#!/bin/bash

sudo apt-get install git couchdb

cd /vagrant
git clone https://github.com/cloudant/sync-android
cd sync-android/
git checkout 0.10.0
./gradlew install

cd /vagrant
git clone https://github.com/snowch/sync-android-p2p
cd sync-android-p2p/
git checkout migrate_to_cloudant_sync_0_10_0

mkdir -p /tmp/datastores
./gradlew execute -DDB_DIR=/tmp/datastores/
