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
vagrant ssh
cd /vagrant
./test_env.sh
```

- When the top window shows the restlet server has started, in the second window press:

```
[ENTER]
```

- To exit the session: 

```
[CTRL-B X]
```
