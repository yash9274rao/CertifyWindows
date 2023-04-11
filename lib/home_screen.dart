import 'dart:async';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snaphybrid/QRViewExmple.dart';
import 'package:intl/intl.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:snaphybrid/api/api_service.dart';
import 'common/sharepref.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MyHome createState() => _MyHome();
}

class _MyHome extends State<HomeScreen> {
  var timeTextHolderModalController = "", dateTextHolderModalController = "";
  late Timer dataTime;
  Map<String, dynamic> diveInfo = new HashMap();

  @override
  void initState() {
    super.initState();
    timeDateSet();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        body: Container(
          color: Colors.white,
          child: Container(
            child: Row(
              children: [
                new Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 0, 25),
                    child: Container(
                      color: Colors.grey.shade200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(25, 0, 10, 15),
                              child: new Image(
                                image:
                                    AssetImage('images/assets/final_logo.png'),
                              ),
                            ),
                          ),
                          new Expanded(
                            flex: 1,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(50, 20, 10, 15),
                                    child: Text(
                                      'Wellcome To RR',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(50, 0, 10, 15),
                                    child: Text(
                                      'You are in Home Screen',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18),
                                    ),
                                  ),
                                ]),
                          ),
                          new Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(50, 0, 25, 25),
                              child: Container(
                                color: Colors.blueGrey.shade900,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                     new Image(
                                      image:
                                      AssetImage('images/assets/quote.png'),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(80, 20, 180, 5),
                                      child: TextButton.icon(
                                        // <-- TextButton
                                        onPressed: () {},
                                        icon: Icon(
                                          color: Colors.white,
                                          Icons.access_time,
                                          size: 24.0,
                                        ),
                                        label: Text(
                                          '${timeTextHolderModalController}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(80, 0, 180, 50),
                                      child: Text(
                                        '${dateTextHolderModalController}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                new Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(16.0),
                            textStyle: const TextStyle(fontSize: 24),
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QRViewExample()));
                          },
                          child: Text(
                            "       Check-In       ",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 0, 20),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.redAccent,
                            padding: const EdgeInsets.all(16.0),
                            textStyle: const TextStyle(fontSize: 24),
                            backgroundColor: Colors.red.shade200,
                          ),
                          onPressed: () {
                            print("BBBBBBBBBBBBBBBBBBBB");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QRViewExample()));
                          },
                          child: Text("      Check-Out      "),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> timeDateSet() async {
    dataTime = Timer.periodic(const Duration(seconds: 1), (dataTime) {
      String time = DateFormat('HH:mm a').format(DateTime.now());
      String date = DateFormat('EEEEE, dd MMM yyyy').format(DateTime.now());

      setState(() {
        timeTextHolderModalController = time;
        dateTextHolderModalController = date;
      });
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Sharepref.APP_LAUNCH_TIME,
        DateTime.now().millisecondsSinceEpoch.toString());
    WidgetsFlutterBinding.ensureInitialized();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      diveInfo['osVersion'] = 'Android-12';
      diveInfo['uniqueDeviceId'] = '${pref.getString(Sharepref.serialNo)}';
      diveInfo['deviceModel'] = '${androidInfo.model}';
      diveInfo['deviceSN'] = '${pref.getString(Sharepref.serialNo)}';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      diveInfo['osVersion'] = '${iosInfo.systemVersion}';
      diveInfo['uniqueDeviceId'] = '${iosInfo.identifierForVendor}';
      diveInfo['deviceModel'] = '${iosInfo.model}';
      diveInfo['deviceSN'] = '${pref.getString(Sharepref.serialNo)}';
      //   print('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      WebBrowserInfo webBrowserDeviceInfo = await deviceInfo.webBrowserInfo;
      // textHolderModal = 'If you have already added the device on the '
      //     'portal SL NO:${webBrowserInfo.userAgent}';
      diveInfo['osVersion'] = '${webBrowserDeviceInfo.browserName}';
      diveInfo['uniqueDeviceId'] = '${webBrowserDeviceInfo.productSub}';
      diveInfo['deviceModel'] = '${webBrowserDeviceInfo.appName}';
      diveInfo['deviceSN'] = '${pref.getString(Sharepref.serialNo)}';
    }
    // else if (defaultTargetPlatform == TargetPlatform.macOS) {
    //   MacOsDeviceInfo macOsDeviceInfo = await deviceInfo.macOsInfo;
    // }
    diveInfo['appVersion'] = "v1.0";
    diveInfo['mobileNumber'] = "+1";
    diveInfo['IMEINumber'] = "";
    diveInfo['batteryStatus'] = "100";
    diveInfo['networkStatus'] = "true";
    diveInfo['appState'] = "Foreground";
    Map<String, dynamic> healthCheckRequest = new HashMap();
    healthCheckRequest['lastUpdateDateTime'] = DateFormat("yyyy-MM-dd HH:mm:ss")
        .format(DateTime.now().toUtc())
        .toString();
    healthCheckRequest['deviceSN'] = '${pref.getString(Sharepref.serialNo)}';
    healthCheckRequest['deviceInfo'] = '${diveInfo}'; //
    healthCheckRequest['institutionId'] =
        '${pref.getString(Sharepref.institutionID)}';
    //healthCheckRequest['appState'] = 'Foreground';
    //healthCheckRequest['appUpTime'] = '00:22:00';
    // healthCheckRequest['deviceUpTime'] = '01:20:10';
    ApiService().deviceHealthCheck(pref.getString(Sharepref.accessToken),
        healthCheckRequest, pref.getString(Sharepref.serialNo));
  }

  @override
  void dispose() {
    super.dispose();
    dataTime.cancel();
  }
}
