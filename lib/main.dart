import 'dart:collection';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:client_information/client_information.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:certify_me_kiosk/api/response/activate_application_response.dart';
import 'package:certify_me_kiosk/api/response/getdevice_token_response.dart';
import 'package:certify_me_kiosk/common/sharepref.dart';
import 'package:certify_me_kiosk/common/util.dart';
import 'package:certify_me_kiosk/home_screen.dart';

import 'api/api_service.dart';
import 'common/color_code.dart';
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
      title: 'Certify.me KIOSK',
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
  var _is_web = true;
  late ProgressDialog _isProgressLoading;
  @override
  void initState() {
    super.initState();
    initPlatformState();
    getDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    _isProgressLoading = ProgressDialog(context,type: ProgressDialogType.normal, isDismissible: false);
    _isProgressLoading.style(padding: EdgeInsets.all(25),);
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Certify.me KIOSK',
      home: Scaffold(
        body: Container(
          color: Colors.white,
          height: _height,
          width: _width,
          child: SingleChildScrollView(
              child: Visibility(
            visible: _isVisibility,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.fromLTRB(45, 55, 45, 0),
                  child: Image(
                    image: AssetImage('images/assets/final_logo.png'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(45, 40, 45, 0),
                  child: AutoSizeText(
                    'Register the device',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ColorCode.titleFont,
                        color: Color(ColorCode.addColorTitle)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.fromLTRB(45, 5, 45, 35),
                    child: Divider(color: Colors.grey)),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 45,),
                    Icon(Icons.error_outline,color:Color(ColorCode.addColorTitle) ,),
                    SizedBox(width: 10,),
                    Flexible(
                      child: AutoSizeText(
                          'This device is not configured to work online. If'
                          ' you already have a cloud account, then',
                          style: TextStyle(
                            fontSize: ColorCode.subTextFont,
                            color: Color(ColorCode.addColorSub),
                          ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        minFontSize: 18,),
                    ),
                    SizedBox(width: 15,),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(85, 20, 45, 45),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => login()));
                    },
                    style: TextButton.styleFrom(
                      elevation: 20,
                      shadowColor: Colors.grey,
                      backgroundColor: Color(0xff3A95EF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),),
                    ),

                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: _width * ColorCode.buttonsValues, minHeight: 90.0),
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          "Log-In to Register",
                          style: TextStyle(fontSize: ColorCode.subTextFont, color: Colors.white),
                          minFontSize: 22,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 45,),
                    Visibility(
                      visible: _is_web,
                      child: Icon(Icons.error_outline,color: Color(ColorCode.addColorTitle),),
                    ),
                    const SizedBox(width: 10,),
                    Flexible(
                      child: Visibility(
                        visible: _is_web,
                        child: AutoSizeText(
                            '${textHolderModalController}, then',
                            style: TextStyle(
                                fontSize: ColorCode.subTextFont, color: Color(ColorCode.addColorSub)),
                            minFontSize: 18,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const SizedBox(width: 15,),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(85, 25, 45, 0),
                  child: Visibility(
                    visible: _is_web,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(
                            color: Color(ColorCode.colorRegister), width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 9,
                        //Defines Elevation
                        shadowColor:Colors.grey,
                        //Defines shadowColor
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        await _isProgressLoading.show();
                        activiAPI();
                      },
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: _width * ColorCode.buttonsValues, minHeight: 90.0),
                        padding: const EdgeInsets.all(14.0),
                        alignment: Alignment.center,
                        child: AutoSizeText("Try Re-activation",
                            style: TextStyle(
                                fontSize: ColorCode.buttonFont, color: Color(ColorCode.colorRegister)),
                            minFontSize: 22,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 45,height: 16,),
              ],
            ),
          )),
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

    if (pref.getString(Sharepref.serialNo) == null ||
        pref.getString(Sharepref.serialNo)!.isEmpty) {
      pref.setString(Sharepref.serialNo, _clientInfo.deviceId.toUpperCase());
    }
    if (_clientInfo.osName == 'Android') {
      pref.setString(Sharepref.platform, "Android Tablet");
      pref.setString(Sharepref.platformId, "4");
    } else if ((_clientInfo.osName == 'Windows') ||
        (_clientInfo.osName == 'Mac OS')) {
      pref.setString(Sharepref.platform, "web");
      pref.setString(Sharepref.platformId, "5");
    } else {
      pref.setString(Sharepref.platform, "IOS Tablet");
      pref.setString(Sharepref.platformId, "3");
    }
    pref.setString(Sharepref.deviceModel, _clientInfo.deviceName);
    pref.setString(Sharepref.appVersion, 'v${_clientInfo.applicationVersion}');
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
      ActivateApplicationResponse activateApplicationResponse =
          await ApiService().activateApplication(diveInfo, sn)
              as ActivateApplicationResponse;
      print("activateApplicationResponse == $activateApplicationResponse");

      if (activateApplicationResponse.responseCode == 1) {
        await _isProgressLoading.hide();
        print("activateApplicationResponse.responseCode ==1");
        Map<String, dynamic> tokenBody = HashMap();
        tokenBody['email'] = "";
        tokenBody['password'] = "";
        tokenBody['deviceSN'] = sn;
        GetDeviceTokenResponse getDeviceTokenResponse = await ApiService()
            .getGenerateToken(tokenBody) as GetDeviceTokenResponse;
        if (getDeviceTokenResponse.responseCode == 1) {

          pref.setString(Sharepref.accessToken,
              getDeviceTokenResponse.responseData.responseData.access_token);
          pref.setString(Sharepref.institutionID,
              getDeviceTokenResponse.responseData.responseData.institutionID);
          Navigator.pushReplacement(context as BuildContext,
              MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          await _isProgressLoading.hide();
          setState(() {
            if (pref.getString(Sharepref.platform) == "web") _is_web = false;
            _isVisibility = true;
          });
        }
      } else {
        await _isProgressLoading.hide();
        setState(() {
          if (pref.getString(Sharepref.platform) == "web") _is_web = false;
          _isVisibility = true;
        });
      }
  }
}
