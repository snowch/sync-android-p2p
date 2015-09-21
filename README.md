# sync-android-p2p

[![Build Status](https://travis-ci.org/snowch/sync-android-p2p.png?branch=master)](https://travis-ci.org/snowch/sync-android-p2p)

This project implements a http listener on top of sync-android to allow sync-android to become a replication target.

This project is a prototype.  It can perform a basic replication based on the steps below, however, a lot more functionality needs to be implemented to support replication proper.  In theory this code should work on Android, but this has not been tried yet.

Expect lots of bugs, this code needs much more testing.

### Testing this project

- check out this project
```
git clone https://github.com/snowch/sync-android-p2p
cd sync-android
```

- start the development environment

```
vagrant up
vagrant ssh
cd /vagrant
./test_env.sh
```

- when the top window shows the restlet server has started:

```
Starting the Simple [HTTP/1.1] server on port 8182
> Building 85% > :executeApp
```

- in the bottom window press ENTER to start a replication:

```
[ENTER]
```

- To exit the session: 

```
[CTRL-B X]
```

### Deploying this project's jars to the github repo

```
./gradlew clean build uploadArchives
git add repository/
git commit ...
git push 
```

### Using this project's jars from another project 

Example build.gradle:


```
apply plugin: 'android'

android {
  compileSdkVersion 19
  buildToolsVersion '19.0.0'

  repositories {
    mavenLocal()
    mavenCentral()
    maven { url "http://maven.restlet.org" }
    maven { url "http://cloudant.github.io/cloudant-sync-eap/repository/" }
    maven { url 'https://github.com/snowch/sync-android-p2p/raw/master/repository/' }
  }

  ...
    
  dependencies {
    compile 'net.christophersnow:sync-android-p2p:0.0.2-SNAPSHOT'
  }
}
```
