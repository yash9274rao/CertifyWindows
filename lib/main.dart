import 'dart:collection';

import 'package:client_information/client_information.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snaphybrid/api/response/activate_application_response.dart';
import 'package:snaphybrid/api/response/getdevice_token_response.dart';
import 'package:snaphybrid/common/sharepref.dart';
import 'package:snaphybrid/common/util.dart';
import 'package:snaphybrid/home_screen.dart';

import 'api/api_service.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyLanch(),
    );
  }
}

class MyLanch extends StatefulWidget {
  @override
  _MyHome createState() => _MyHome();
}

class _MyHome extends State<MyLanch> {
  var textHolderModalController = "";
  Map<String, dynamic> diveInfo = HashMap();
  var _isVisibility = false;
 
  @override
  void initState() {
    super.initState();
    initPlatformState();
    getDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Visibility(
            visible: _isVisibility,
            child: Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Image(
                    image: AssetImage('images/assets/image.png'),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(25, 0, 10, 15),
                        child: Text(
                          'Register Device',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.fromLTRB(25, 0, 10, 15),
                          child: Divider(color: Colors.grey)),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(25, 0, 10, 15),
                        child: Text(
                            'This device is not configured to work online. If'
                            ' you already have a cloud account'),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 0, 20, 15),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(16.0),
                            textStyle: const TextStyle(fontSize: 20),
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            print("AAAAAAAAAAAAAAAA");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => login()));
                          },
                          child: Text("Login to Register the Device"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 0, 20, 15),
                        child: Text(
                          '${textHolderModalController}',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 0, 20, 15),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blue,
                            padding: const EdgeInsets.all(16.0),
                            textStyle: const TextStyle(fontSize: 20),
                            side: BorderSide(color: Colors.blue, width: 1),
                          ),
                          onPressed: () {
                            print("BBBBBBBBBBBBBBBBBBBB");
                            activiAPI();
                          },
                          child: Text("Try Activation Again"),
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

  Future<void> getDeviceToken() async {
    await Firebase.initializeApp();
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString(Sharepref.firebaseToken) == null ||
        pref.getString(Sharepref.firebaseToken) == "") {
      // String? deviceToken = await FirebaseMessaging.instance.getToken();
      pref.setString(Sharepref.firebaseToken, "");
    }
  }

  Future<void> initPlatformState() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Sharepref.APP_LAUNCH_TIME,
        DateTime.now().millisecondsSinceEpoch.toString());
    WidgetsFlutterBinding.ensureInitialized();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    ClientInformation _clientInfo = await ClientInformation.fetch();
    setState(() {
      textHolderModalController = 'If you have already added the device on the '
          'portal SL NO: ${_clientInfo.deviceId.toUpperCase()}';
    });
    pref.setString(Sharepref.serialNo, _clientInfo.deviceId.toUpperCase());
    if (_clientInfo.osName == 'Android') {
      pref.setString(Sharepref.platform, "Android Tablet");
      pref.setString(Sharepref.platformId, "4");
    } else if (_clientInfo.osName == 'Windows') {
      pref.setString(Sharepref.platform, "web");
      pref.setString(Sharepref.platformId, "4");
    } else {
      pref.setString(Sharepref.platform, "IOS Tablet");
      pref.setString(Sharepref.platformId, "3");
    }
    pref.setString(Sharepref.deviceModel, _clientInfo.deviceName);
    pref.setString(Sharepref.appVersion, _clientInfo.applicationVersion);
    pref.setString(Sharepref.osVersion,
        '${_clientInfo.osName} - ${_clientInfo.osVersion}');
    print(
        "_clientInfo.applicationVersion object${_clientInfo.applicationVersion}");
    activiAPI();
  }

  Future<void> activiAPI() async {
    var pref = await SharedPreferences.getInstance();
    String sn = pref.getString(Sharepref.serialNo) as String;
    diveInfo['osVersion'] = pref.getString(Sharepref.osVersion);
    diveInfo['uniqueDeviceId'] = pref.getString(Sharepref.serialNo);
    diveInfo['deviceModel'] = pref.getString(Sharepref.deviceModel);
    diveInfo['deviceSN'] = pref.getString(Sharepref.serialNo);
    diveInfo['appVersion'] = pref.getString(Sharepref.appVersion);
    diveInfo['mobileNumber'] = "+1";
    diveInfo['IMEINumber'] = "";
    diveInfo['batteryStatus'] = "100";
    diveInfo['networkStatus'] = "true";
    diveInfo['appState'] = "Foreground";
    Map<String, dynamic> createDoc = new HashMap();
    createDoc['pushAuthToken'] = pref.getString(Sharepref.firebaseToken);
    createDoc['deviceData'] = diveInfo;
    // bool result = await InternetConnectionChecker().hasConnection;
    if (true) {
      ActivateApplicationResponse activateApplicationResponse =
          await ApiService().activateApplication(diveInfo, sn)
              as ActivateApplicationResponse;
      print("activateApplicationResponse == $activateApplicationResponse");

      if (activateApplicationResponse.responseCode == 1) {
        print("activateApplicationResponse.responseCode ==1");

        Map<String, dynamic> tokenBody = HashMap();
        tokenBody['email'] = "";
        tokenBody['password'] = "";
        tokenBody['deviceSN'] = sn;
        GetDeviceTokenResponse getDeviceTokenResponse = await ApiService()
            .getGenerateToken(tokenBody) as GetDeviceTokenResponse;
        if (getDeviceTokenResponse.responseCode == 1) {
          pref.setString(Sharepref.accessToken,
              getDeviceTokenResponse.responseData.access_token);
          pref.setString(Sharepref.institutionID,
              getDeviceTokenResponse.responseData.institutionID);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          setState(() {
            _isVisibility = true;
          });
        }
      } else {
        setState(() {
          _isVisibility = true;
        });
      }
    } else {
      Util.showToastError("No Internet");
    }
  }
}
