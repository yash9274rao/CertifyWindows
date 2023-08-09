import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:certify_me_kiosk/pin_qrcode_screen.dart';
import 'package:certify_me_kiosk/pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:certify_me_kiosk/QRViewExmple.dart';
import 'package:certify_me_kiosk/api/api_service.dart';
import 'common/color_code.dart';
import 'common/sharepref.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

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
  late Timer timer;
  String attendanceMode = "0";
  String checkInMode = "0";
  Map<String, dynamic> diveInfo = HashMap();
  var isVisiabilityImag = false;
  late ProgressDialog _isProgressLoading;

  @override
  void initState() {
    super.initState();
    timeDateSet();
    timer = Timer.periodic(Duration(minutes: 15), (Timer t) => healthCheck());
  }

  @override
  Widget build(BuildContext context) {
    _isProgressLoading = ProgressDialog(context,type: ProgressDialogType.normal, isDismissible: false);
    _isProgressLoading.style(padding: EdgeInsets.all(25),);
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return MaterialApp(
        title: 'Certify.me Kiosk',
        home: Scaffold(
            body: Container(
                child: Visibility(
                    visible: isVisiabilityImag,
        child:  Container(
                color: Colors.white,
                height: _height,
                width: _width,
                padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                child: SingleChildScrollView(
                    child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 15, 0),
                        child: Visibility(
                          visible: isVisiabilityImag,
                          child: _imageToShow,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 20, 0),
                        child: Text(
                          lineOneText,
                          style:  TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ColorCode.titleFont,
                              color: Color(ColorCode.line1color),
                          )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 25, 0),
                        child: Text(
                          lineTwoText,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                            fontSize: ColorCode.subTextFont,
                            color: Color(ColorCode.line2color),
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 120, 0, 5),
                        child: Row(children: [
                          Expanded(
                            flex: 1,
                            child: SingleChildScrollView(
                              child: Container(
                                margin: EdgeInsets.only(right: 50),
                                decoration: BoxDecoration(
                                  color: ColorCode.dynamicBackgroundColorBtn,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                 ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Image(
                                        image: AssetImage(
                                            'images/assets/quote.png'),
                                      ),
                                    ),
                                    Center(
                                      child: TextButton.icon(
                                        icon:  Icon(
                                          color: ColorCode.dynamicTextColorBtn,
                                          Icons.access_time,
                                          size: 44.0,
                                        ),
                                        label: AutoSizeText(
                                          timeTextHolderModalController,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                             fontSize: 44,
                                              color: ColorCode.dynamicTextColorBtn),
                                            minFontSize: 32,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis
                                        ), onPressed: null
                                    )),
                                    Center(

                                        child: AutoSizeText(
                                          dateTextHolderModalController,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 28,
                                              color: ColorCode.dynamicTextColorBtn),
                                          minFontSize: 22,
                                          maxLines: 1,
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
                              flex: 1,
                              child: Container(
                                  // height:
                                  // MediaQuery.of(context).size.height,
                                  // width: MediaQuery.of(context).size.width,
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    elevation: 9,
                                                  shadowColor:  Colors.grey,
                                                  backgroundColor: const Color(
                                                      0xff46973F),
                                                  shape:
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(15.0),
                                                  ),
                                                  ),
                                                    onPressed: () async {
                                                      SharedPreferences pref =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      attendanceMode = "1";
                                                      if (pref.getString(Sharepref
                                                              .checkInMode) ==
                                                          "0") {
                                                        pref.setBool(
                                                            Sharepref
                                                                .isQrCodeScan,
                                                            true);
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    QRViewExample(
                                                                        attendanceMode:
                                                                            attendanceMode)));
                                                      } else if (pref.getString(
                                                              Sharepref
                                                                  .checkInMode) ==
                                                          "1") {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    PinScreen(
                                                                        attendanceMode:
                                                                            attendanceMode)));
                                                      } else if (pref.getString(
                                                              Sharepref
                                                                  .checkInMode) ==
                                                          "2") {
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    PinQrCodeScreen(
                                                                        attendanceMode:
                                                                            attendanceMode)));
                                                      }
                                                    },
                                                    child: Container(
                                                      constraints: BoxConstraints(
                                                          maxWidth: _width * ColorCode.buttonsValues, minHeight: ColorCode.buttonsHeight),
                                                      padding: const EdgeInsets.all(16.0),
                                                      alignment: Alignment.center,
                                                      child: AutoSizeText(
                                                          textAlign: TextAlign.center,
                                                          "Check - In",
                                                          style: TextStyle(
                                                              fontSize: ColorCode.buttonFont,color: Colors.white),
                                                          minFontSize: 14,
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis),
                                                    )),
                                              ),

                                              Container(alignment: Alignment.center,
                                                margin: EdgeInsets.only(
                                                    top: 30),
                                                child: TextButton(
                                               style: TextButton.styleFrom(
                                              elevation: 9,
                                              shadowColor: Colors.grey,
                                              backgroundColor: const Color(0xffDF473D),
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(15.0),
                                              ),
                                            ),
                                                  onPressed: () async {
                                                    SharedPreferences pref =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    attendanceMode = "2";
                                                    if (pref.getString(Sharepref
                                                            .checkInMode) ==
                                                        "0") {
                                                      pref.setBool(
                                                          Sharepref
                                                              .isQrCodeScan,
                                                          true);
                                                      // ignore: use_build_context_synchronously
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  QRViewExample(
                                                                      attendanceMode:
                                                                          attendanceMode)));
                                                    } else if (pref.getString(
                                                            Sharepref
                                                                .checkInMode) ==
                                                        "1") {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PinScreen(
                                                                      attendanceMode:
                                                                          attendanceMode)));
                                                    } else if (pref.getString(
                                                            Sharepref
                                                                .checkInMode) ==
                                                        "2") {
                                                      // ignore: use_build_context_synchronously
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PinQrCodeScreen(
                                                                      attendanceMode:
                                                                          attendanceMode)));
                                                    }
                                                  },
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                        maxWidth: _width * ColorCode.buttonsValues, minHeight: ColorCode.buttonsHeight),
                                                    padding: const EdgeInsets.all(16.0),
                                                    alignment: Alignment.center,
                                                    child: AutoSizeText("Check-Out",
                                                        style: TextStyle(fontSize: ColorCode.buttonFont, color: Colors.white),
                                                        minFontSize: 14,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis),
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
                    ])))))));
  }

  Future<void> timeDateSet() async {
    //updateUI();
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      var timeZone = DateTime.now().timeZoneOffset.toString().split(':');
      pref.setString(Sharepref.timeZone, '${timeZone[0]}:${timeZone[1]}');
    } catch (e) {
      print(e.toString());
    }
    dataTime = Timer.periodic(const Duration(seconds: 1), (dataTime) {
      String time = DateFormat('hh:mm a').format(DateTime.now());
      String date = DateFormat('EEEEE, dd MMM yyyy').format(DateTime.now());
      setState(() {
        timeTextHolderModalController = time;
        dateTextHolderModalController = date;
      });
    });
    pref.setString(Sharepref.APP_LAUNCH_TIME,
        DateTime.now().millisecondsSinceEpoch.toString());
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
    await _isProgressLoading.show();
    Map<String, dynamic> deviceSetting = HashMap();
    deviceSetting['deviceSN'] = '${pref.getString(Sharepref.serialNo)}';
    deviceSetting['institutionId'] =
        '${pref.getString(Sharepref.institutionID)}';
    deviceSetting['settingType'] = 10;
    String req = await ApiService().deviceSetting(pref) as String;
    if (req == "1") {
      await _isProgressLoading.hide();
      updateUI();
    }
  }

  Future<void> updateUI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      ColorCode.dynamicBackgroundColorBtn = Color(int.parse(pref.getString(Sharepref.colourCodeForButton)?? "0xff3A95EF"));
     ColorCode.dynamicTextColorBtn = Color(int.parse(pref.getString(Sharepref.colourCodeForTextButton)?? "0xffEBF1F8"));
    print('${pref.getString(Sharepref.colourCodeForButton)},${pref.getString(Sharepref.colourCodeForTextButton)}');
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
      isVisiabilityImag = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    dataTime.cancel();
    // timer.cancel();
  }
}
