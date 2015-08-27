#!/bin/bash

set -e

sudo apt-get update
sudo apt-get remove openjdk-6* -y
sudo apt-get install git tmux sqlite3 wireshark openjdk-7-jdk -y


# via http://wiki.apache.org/couchdb/Installing_on_Ubuntu

sudo apt-get install --yes build-essential curl git
sudo apt-get install --yes python-software-properties python g++ make

sudo apt-get install -y erlang-dev erlang-manpages erlang-base-hipe erlang-eunit erlang-nox erlang-xmerl erlang-inets
sudo apt-get install -y libmozjs185-dev libicu-dev libcurl4-gnutls-dev libtool

# via http://ftp.fau.de/apache/couchdb/source/1.6.1/
cd /tmp
wget -q -c http://ftp.fau.de/apache/couchdb/source/1.6.1/apache-couchdb-1.6.1.tar.gz
tar xvzf apache-couchdb-1.6.1.tar.gz

cd apache-couchdb-*
./configure && make

sudo make install

sudo useradd -m couchdb
sudo chown -R couchdb: /usr/local/var/{lib,log,run}/couchdb /usr/local/etc/couchdb
sudo chmod 0770 /usr/local/var/{lib,log,run}/couchdb/
sudo chmod 664 /usr/local/etc/couchdb/*.ini
sudo chmod 775 /usr/local/etc/couchdb/*.d

# set large timeout to allow debugging
sudo sed -i 's@^os_process_timeout.*$@os_process_timeout = 600000@g' /usr/local/etc/couchdb/default.ini

sudo ln -s /usr/local/etc/init.d/couchdb /etc/init.d/couchdb
sudo /etc/init.d/couchdb start
sudo update-rc.d couchdb defaults
sudo /etc/init.d/couchdb restart



wget -q -c "https://eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/mars/R/eclipse-java-mars-R-linux-gtk.tar.gz&r=1" -O /home/vagrant/eclipse-java-mars-R-linux-gtk.tar.gz
cd /home/vagrant
tar xzvf eclipse-java-mars-R-linux-gtk.tar.gz


cd /home/vagrant
git clone https://github.com/cloudant/sync-android
cd sync-android/
git checkout 4e1b94c290cb01ca524e562f587017b1ea06e55d
cp /vagrant/gradlew .
cp -r /vagrant/gradle .
./gradlew install

cd /vagrant
git checkout migrate_to_cloudant_sync_0_10_0
./gradlew eclipse

echo 'Done'
