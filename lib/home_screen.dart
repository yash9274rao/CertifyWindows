import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snaphybrid/QRViewExmple.dart';
import 'package:snaphybrid/api/api_service.dart';

import 'common/sharepref.dart';
import 'common/util.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MyHome createState() => _MyHome();
}

class _MyHome extends State<HomeScreen> {
  var timeTextHolderModalController = "",
      dateTextHolderModalController = "",
      lineOneText = "",
      lineTwoText = "";
  var _imageToShow = const Image(image: AssetImage('images/assets/quote.png'));
  late Timer dataTime;

  //SharedPreferences pref = SharedPreferences.getInstance() as SharedPreferences;

  Map<String, dynamic> diveInfo = HashMap();

  @override
  void initState() {
    super.initState();
    timeDateSet();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 55, 25, 25),
                  child: Container(
                    color: Colors.grey.shade200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 1, child: _imageToShow),
                        Expanded(
                          flex: 1,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(25, 20, 25, 15),
                                  child: Text(
                                    lineOneText,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(25, 0, 25, 0),
                                  child: Text(
                                    lineTwoText,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                            child: Container(
                              color: Colors.blueGrey.shade900,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Image(
                                    image:
                                        AssetImage('images/assets/quote.png'),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(80, 20, 0, 5),
                                    child: TextButton.icon(
                                      // <-- TextButton
                                      onPressed: () {},
                                      icon: const Icon(
                                        color: Colors.white,
                                        Icons.access_time,
                                        size: 24.0,
                                      ),
                                      label: Text(
                                        timeTextHolderModalController,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        80, 0, 180, 50),
                                    child: Text(
                                      dateTextHolderModalController,
                                      style: const TextStyle(
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
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(16.0),
                          textStyle: const TextStyle(fontSize: 24),
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () async {
                          bool result =
                              await InternetConnectionChecker().hasConnection;
                          if (result) {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref.setBool(Sharepref.isQrCodeScan, true);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const QRViewExample(
                                        attendanceMode: "1")));
                          } else {
                            Util.showToastError("No Internet");
                          }
                        },
                        child: const Text("       Check-In       ",),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 0, 20),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                          padding: const EdgeInsets.all(16.0),
                          textStyle: const TextStyle(fontSize: 24),
                          backgroundColor: Colors.red.shade200,
                        ),
                        onPressed: () async {
                          bool result =
                              await InternetConnectionChecker().hasConnection;
                          if (result) {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref.setBool(Sharepref.isQrCodeScan, true);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const QRViewExample(
                                        attendanceMode: "2")));
                          } else {
                            Util.showToastError("No Internet");
                          }
                        },
                        child: const Text("      Check-Out      "),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> timeDateSet() async {
    updateUI();
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
      diveInfo['deviceModel'] = androidInfo.model;
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
    Map<String, dynamic> healthCheckRequest = HashMap();
    healthCheckRequest['lastUpdateDateTime'] = DateFormat("yyyy-MM-dd HH:mm:ss")
        .format(DateTime.now().toUtc())
        .toString();
    healthCheckRequest['deviceSN'] = '${pref.getString(Sharepref.serialNo)}';
    healthCheckRequest['deviceInfo'] = '$diveInfo'; //
    healthCheckRequest['institutionId'] =
        '${pref.getString(Sharepref.institutionID)}';
    //healthCheckRequest['appState'] = 'Foreground';
    //healthCheckRequest['appUpTime'] = '00:22:00';
    // healthCheckRequest['deviceUpTime'] = '01:20:10';
    ApiService().deviceHealthCheck(pref.getString(Sharepref.accessToken),
        healthCheckRequest, pref.getString(Sharepref.serialNo));
    deviceSetting();
  }

  Future<void> deviceSetting() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, dynamic> deviceSetting = HashMap();
    deviceSetting['deviceSN'] = '${pref.getString(Sharepref.serialNo)}';
    deviceSetting['institutionId'] =
        '${pref.getString(Sharepref.institutionID)}';
    String req = await ApiService().deviceSetting(pref) as String;
    if (req == "1") updateUI();
  }

  Future<void> updateUI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      lineOneText = pref.getString(Sharepref.line1HomePageView)!;
      lineTwoText = pref.getString(Sharepref.line2HomePageView)!;
      String? base64 = pref.getString(Sharepref.logoHomePageView);
      if (base64 != null && base64.isNotEmpty) {
        _imageToShow = Image.memory(const Base64Decoder().convert(base64));
      } else {
        _imageToShow =
            const Image(image: AssetImage('images/assets/quote.png'));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    dataTime.cancel();
  }
}
