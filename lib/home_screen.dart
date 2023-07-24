import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:certify_me_kiosk/pin_qrcode_screen.dart';
import 'package:certify_me_kiosk/pin_screen.dart';
import 'package:certify_me_kiosk/toast.dart';
import 'package:certify_me_kiosk/volunteer_checkin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:certify_me_kiosk/QRViewExmple.dart';
import 'package:certify_me_kiosk/api/api_service.dart';
import 'api/response/VoluntearResponse.dart';
import 'api/response/response_data_voluntear.dart';
import 'common/sharepref.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MyHome createState() => _MyHome();
}

class _MyHome extends State<HomeScreen> {
  var timeTextHolderModalController = "",
      dateTextHolderModalController = "",
      versionId = "",
      lineOneText = "",
      lineTwoText = "";
  var _imageToShow =
  const Image(image: AssetImage('images/assets/final_logo.png'));
  late Timer dataTime;
  late Timer timer, delayQRPinUI;
  String attendanceMode = "0",
      _pinStr = "",
      _mobileNumber = "",
      _countryCode = "1";
  bool checkInVisiable = false;
  bool checkOutVisiable = false;
  bool qrAndpinVisiable = false;
  bool pinPageVisiable = false;
  bool pinVisiable = false;
  bool enableVisitorCheckout = true;
  int itemId = 0;
  String name = "";
  String checkInMode = "0";
  List<VolunteerSchedulingDetailList> volunteerList = [];
  Map<String, dynamic> diveInfo = HashMap();

  @override
  void initState() {
    super.initState();
    timeDateSet();
    timer = Timer.periodic(Duration(minutes: 15), (Timer t) => healthCheck());
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return MaterialApp(
        title: 'Certify.me Kiosk',
        home: Scaffold(
            body: Container(
                color: Colors.white,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 40, 15, 0),
                            child: _imageToShow,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 20, 0),
                            child: Text(
                              lineOneText,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Color(0xff273C51)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 20, 25, 0),
                            child: Text(
                              lineTwoText,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Color(0xff245F99)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 120, 20, 5),
                            child: Row(children: [
                              Expanded(
                                flex: 1,
                                child: SingleChildScrollView(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff175EA5),
                                          Color(0xff163B60)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        tileMode: TileMode.repeated,
                                        stops: [0.0, 1.7],
                                      ),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: <Widget>[
                                        const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: Image(
                                            image: AssetImage(
                                                'images/assets/quote.png'),
                                          ),
                                        ),
                                        Center(
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .fromLTRB(
                                                  0, 45, 0, 0),
                                              child: TextButton.icon(
                                                icon: const Icon(
                                                  color: Colors.white,
                                                  Icons.access_time,
                                                  size: 24.0,
                                                ),
                                                label: Text(
                                                  timeTextHolderModalController,
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight
                                                          .normal,
                                                      fontSize: 32,
                                                      color: Colors.white),
                                                ),
                                                onPressed: () {},
                                              ),
                                            )),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 0, 0, 20),
                                            child: Text(
                                              dateTextHolderModalController,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 24,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        const Align(
                                          alignment: Alignment.bottomRight,
                                          child: Image(
                                            image: AssetImage(
                                                'images/assets/quote_down.png'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    // height:
                                    // MediaQuery.of(context).size.height,
                                    // width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Stack(
                                              alignment: Alignment.center,
                                              children: <Widget>[
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(left: _width*0.18,right:  _width*0.18),
                                                          child: TextButton(
                                                              style:
                                                              TextButton
                                                                  .styleFrom(
                                                                shape:
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      15.0),
                                                                ),
                                                                elevation: 9,
                                                                //Defines Elevation
                                                                shadowColor:
                                                                Color(
                                                                    0xff46973F),
                                                                foregroundColor:
                                                                Colors.white,
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(25.0),
                                                                backgroundColor:
                                                                const Color(
                                                                    0xff46973F),
                                                                minimumSize: const Size
                                                                    .fromHeight(
                                                                    40),
                                                              ),
                                                              onPressed: () async {
                                                                SharedPreferences pref =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                                attendanceMode =
                                                                "1";
                                                                if (pref.getString(Sharepref.checkInMode) ==
                                                                    "0") {
                                                                  pref.setBool(
                                                                      Sharepref
                                                                          .isQrCodeScan,
                                                                      true);
                                                                  // ignore: use_build_context_synchronously
                                                                  Navigator
                                                                      .pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (
                                                                              context) =>
                                                                              QRViewExample(
                                                                                  attendanceMode: attendanceMode)));
                                                                } else
                                                                if (pref.getString(Sharepref.checkInMode) ==
                                                                    "1") {
                                                                  Navigator.pushReplacement(context,
                                                                      MaterialPageRoute(builder: (context) => PinScreen(attendanceMode: attendanceMode)));

                                                                } else
                                                                if (pref.getString(Sharepref.checkInMode) ==
                                                                    "2") {
                                                                  // ignore: use_build_context_synchronously
                                                                  Navigator
                                                                      .pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (
                                                                              context) =>
                                                                              PinQrCodeScreen(
                                                                                  attendanceMode: attendanceMode)));
                                                                }
                                                              },
                                                              child: const FittedBox(
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                child: AutoSizeText(
                                                                    "Check - In",
                                                                    style: TextStyle(
                                                                        fontSize: 32),
                                                                    minFontSize: 14,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                              )),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(left: _width*0.18,right:  _width*0.18,top: 30),

                                                        child: TextButton(
                                                            style: TextButton
                                                                .styleFrom(
                                                              shape:
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    15.0),
                                                              ),
                                                              elevation: 9,
                                                              //Defines Elevation
                                                              shadowColor:
                                                              Color(0xffDF473D),
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(
                                                                  25.0),
                                                              backgroundColor:
                                                              const Color(
                                                                  0xffDF473D),
                                                              minimumSize:
                                                              const Size
                                                                  .fromHeight(
                                                                  40),
                                                            ),
                                                            onPressed: () async {
                                                              SharedPreferences pref =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                              attendanceMode =
                                                              "2";
                                                              if (pref.getString(Sharepref.checkInMode) ==
                                                                  "0") {
                                                                pref.setBool(
                                                                    Sharepref
                                                                        .isQrCodeScan,
                                                                    true);
                                                                // ignore: use_build_context_synchronously
                                                                Navigator
                                                                    .pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (
                                                                            context) =>
                                                                            QRViewExample(
                                                                                attendanceMode: attendanceMode)));
                                                              } else
                                                              if (pref.getString(Sharepref.checkInMode) ==
                                                                  "1") {
                                                                Navigator.pushReplacement(context,
                                                                    MaterialPageRoute(builder: (context) => PinScreen(attendanceMode: attendanceMode)));
                                                              } else
                                                              if (pref.getString(Sharepref.checkInMode) ==
                                                                  "2") {
                                                                // ignore: use_build_context_synchronously
                                                                Navigator
                                                                    .pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (
                                                                            context) =>
                                                                            PinQrCodeScreen(
                                                                                attendanceMode: attendanceMode)));
                                                              }
                                                            },
                                                            child: const FittedBox(
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                              child: AutoSizeText(
                                                                  "Check - Out",
                                                                  style: TextStyle(
                                                                      fontSize: 32,
                                                                      color:
                                                                      Colors
                                                                          .white),
                                                                  minFontSize: 14,
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow
                                                                      .ellipsis),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ]),
                                        ],
                                      ))),
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 0, 5),
                            child: Text(
                              versionId,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Color(0xff15395C)),
                            ),
                          ),
                        ])))));
  }

  Future<void> timeDateSet() async {
    //updateUI();
    SharedPreferences pref = await SharedPreferences.getInstance();
    dataTime = Timer.periodic(const Duration(seconds: 1), (dataTime) {
      String time = DateFormat('hh:mm a').format(DateTime.now());
      String date = DateFormat('EEEEE, dd MMM yyyy').format(DateTime.now());

      setState(() {
        timeTextHolderModalController = time;
        dateTextHolderModalController = date;
      });
    });
    pref.setString(Sharepref.APP_LAUNCH_TIME,
        DateTime
            .now()
            .millisecondsSinceEpoch
            .toString());
    healthCheck();
    deviceSetting();
  }

  Future<void> healthCheck() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
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
    Map<String, dynamic> healthCheckRequest = HashMap();
    healthCheckRequest['lastUpdateDateTime'] = DateFormat("yyyy-MM-dd HH:mm:ss")
        .format(DateTime.now().toUtc())
        .toString();
    healthCheckRequest['deviceSN'] = '${pref.getString(Sharepref.serialNo)}';
    healthCheckRequest['deviceInfo'] = diveInfo;
    healthCheckRequest['pushAuthToken'] =
        pref.getString(Sharepref.firebaseToken);
    healthCheckRequest['institutionId'] =
    '${pref.getString(Sharepref.institutionID)}';
    //healthCheckRequest['appState'] = 'Foreground';
    //healthCheckRequest['appUpTime'] = '00:22:00';
    // healthCheckRequest['deviceUpTime'] = '01:20:10';
    ApiService().deviceHealthCheck(pref.getString(Sharepref.accessToken),
        healthCheckRequest, pref.getString(Sharepref.serialNo));
  }

  Future<void> deviceSetting() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, dynamic> deviceSetting = HashMap();
    deviceSetting['deviceSN'] = '${pref.getString(Sharepref.serialNo)}';
    deviceSetting['institutionId'] =
    '${pref.getString(Sharepref.institutionID)}';
    deviceSetting['settingType'] = 10;
    String req = await ApiService().deviceSetting(pref) as String;
    if (req == "1") updateUI();
  }


  Future<void> updateUI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      checkInMode = pref.getString(Sharepref.checkInMode)!;
      versionId = pref.getString(Sharepref.appVersion)!;
      lineOneText = pref.getString(Sharepref.line1HomePageView) ?? "";
      lineTwoText = pref.getString(Sharepref.line2HomePageView) ?? "";
      String? base64 = pref.getString(Sharepref.logoHomePageView) ?? "";
      if (base64.isNotEmpty) {
        _imageToShow = Image.memory(const Base64Decoder().convert(base64));
      } else {
        _imageToShow =
        const Image(image: AssetImage('images/assets/final_logo.png'));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    dataTime.cancel();
    // timer.cancel();
  }
}
