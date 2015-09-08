# sync-android-p2p
This project implements a http listener on top of sync-android to allow sync-android to become a replication target.

This project is a prototype.  It can perform a basic replication based on the steps below, however, a lot more functionality needs to be implemented to support replication proper.  In theory this code should work on Android, but this has not been tried yet.

Expect lots of bugs, this code needs much more testing.

- check out this project
```
git clone https://github.com/snowch/sync-android-p2p
cd sync-android
```

- start the development environment
```
vagrant up
```

- open a terminal in the ubuntu window
- open eclipse 
  - import General Project `/vagrant`
  - import Run/Debug Breakpoints  `/vagrant/Breakpoints.bkpt`
  - import Run/Debug Launch Configuration `/vagrant/App.launch`

- run the script to start a replication and follow the instructions
```
./run_sync_eclipse.sh
```
