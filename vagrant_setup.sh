#!/bin/bash

sudo apt-get update
sudo apt-get remove openjdk-6* -y
sudo apt-get install git couchdb tmux sqlite3 wireshark openjdk-7-jdk -y

wget -P /home/vagrant/ "https://eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/mars/R/eclipse-java-mars-R-linux-gtk.tar.gz&r=1" -O eclipse-java-mars-R-linux-gtk.tar.gz
tar xzvf eclipse-java-mars-R-linux-gtk.tar.gz

sudo apt-get install linux-image-generic-lts-trusty -y



cd /vagrant
git clone https://github.com/cloudant/sync-android
cd sync-android/
git checkout 0.10.0
./gradlew install

cd /vagrant
git clone https://github.com/snowch/sync-android-p2p
cd sync-android-p2p/
git checkout migrate_to_cloudant_sync_0_10_0
./gradlew ecilpse

