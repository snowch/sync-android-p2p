# sync-android-p2p-example

An example Android application that uses https://github.com/snowch/sync-android-p2p to expose a device sync android 
database allowing the device to become a target destination for a couchdb replication.

*Setup instructions*

- Ensure you have couchdb running

- Deploy this code to device that is on the same network as the couchdb server.

```
$ ./gradlew build assembleRelease
$ adb uninstall com.example.snowch.myapplication
$ adb install app/build/outputs/apk/app-debug.apk
$ adb shell am start -n com.example.snowch.myapplication/com.example.snowch.myapplication.MainActivity
```

- Ensure the restlet server is listening

```
$ adb shell netstat -nalt | grep 8182
tcp6       0      0 :::8182                :::*                   LISTEN
```

- Run netcfg to get the wlan0 IP address on the device:

```
$ adb shell netcfg | grep wlan0
wlan0    UP                                192.168.1.65/24  0x00001043 60:a4:4c:90:20:93
```

- Ensure the device http listener is accepting connections:
```
$ curl http://192.168.1.65:8182/mydb
{"update_seq":"3","instance_start_time":"1381218659871282"}
```

