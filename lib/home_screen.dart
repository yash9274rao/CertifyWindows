import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
        title: 'Certify.me Kiosk',
        home: Scaffold(
            body: SingleChildScrollView(
                child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Row(children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 55, 15, 25),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 1, child: _imageToShow),
                      Expanded(
                        flex: 1,
                          child: SingleChildScrollView(
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
                      ),
                      Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          //scrolling off
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                            child: Container(
                              color: Colors.blueGrey.shade900,
                              // width: MediaQuery.of(context).size.width * 0.4,

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Image(
                                    image:
                                        AssetImage('images/assets/quote.png'),
                                  ),
                                  Center(
                                      child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: TextButton.icon(
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
                                            fontSize: 32,
                                            color: Colors.white),
                                      ),
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
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 0, 5),
                                    child: Text(
                                      versionId,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 55, 30, 55),
                  child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey.shade200,
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
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                120, 0, 120, 0),
                                            child: Visibility(
                                              visible: checkInVisiable,
                                              child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            25.0),
                                                    backgroundColor:
                                                        Colors.green,
                                                    minimumSize:
                                                        const Size.fromHeight(
                                                            40),
                                                  ),
                                                  onPressed: () async {
                                                    SharedPreferences pref =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    pref.setBool(
                                                        Sharepref.isQrCodeScan,
                                                        true);
                                                    attendanceMode = "1";
                                                    try {
                                                      if (pinVisiable) {
                                                        delayQRPinUI
                                                            .cancel();
                                                      }
                                                    }catch(e){
                                                      print(e.toString());
                                                    }
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                QRViewExample(
                                                                    attendanceMode:
                                                                        attendanceMode)));
                                                  },
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: const AutoSizeText(
                                                        "Check-In",
                                                        style: TextStyle(
                                                            fontSize: 40),
                                                        minFontSize: 14,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                120, 30, 120, 0),
                                            child: Visibility(
                                              visible: checkOutVisiable,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  foregroundColor:
                                                      Colors.redAccent,
                                                  padding: const EdgeInsets.all(
                                                      25.0),
                                                  backgroundColor:
                                                      Colors.red.shade200,
                                                  minimumSize:
                                                      const Size.fromHeight(40),
                                                ),
                                                onPressed: () async {
                                                  SharedPreferences pref =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  pref.setBool(
                                                      Sharepref.isQrCodeScan,
                                                      true);
                                                  attendanceMode = "2";
    try {
      if (pinVisiable) {
        delayQRPinUI
            .cancel();
      }
    }catch(e){
      print(e.toString());
    }
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              QRViewExample(
                                                                  attendanceMode:
                                                                      attendanceMode)));
                                                },
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: const AutoSizeText(
                                                      "Check-Out",
                                                      style: TextStyle(
                                                          fontSize: 40),
                                                      minFontSize: 14,
                                                      maxLines: 1,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                120, 0, 120, 0),
                                            child: Visibility(
                                              visible: qrAndpinVisiable,
                                              // false qrbox hidden
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.black,
                                                  padding: const EdgeInsets.all(
                                                      25.0),
                                                  backgroundColor: Colors.blue,
                                                  minimumSize:
                                                      const Size.fromHeight(40),
                                                ),
                                                onPressed: () async {
                                                  setState(() {
                                                    pinPageVisiable = false;
                                                    checkInVisiable = true;
                                                    qrAndpinVisiable = false;
                                                    pinVisiable = false;
                                                    checkOutVisiable = enableVisitorCheckout;
                                                    delayQRPinUI = Timer(
                                                        Duration(seconds: 15),
                                                            () {
                                                              checkInVisiable = false;
                                                              checkOutVisiable = false;
                                                          qrAndpinVisiable = true;
                                                          pinVisiable = true;
                                                        });
                                                    });
                                                },
                                                child: const AutoSizeText(
                                                    "QR Code",
                                                    style:
                                                        TextStyle(fontSize: 40),
                                                    minFontSize: 14,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                120, 30, 120, 0),
                                            child: Visibility(
                                              visible: pinVisiable,
                                              // false pin box hidden
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.black,
                                                  padding: const EdgeInsets.all(
                                                      25.0),
                                                  backgroundColor: Colors.blue,
                                                  minimumSize:
                                                      const Size.fromHeight(40),
                                                ),
                                                onPressed: () async {
                                                    setState(() {
                                                    pinPageVisiable = true;
                                                    checkInVisiable = false;
                                                    checkOutVisiable = false;
                                                    qrAndpinVisiable = false;
                                                    pinVisiable = false;
                                                    delayQRPinUI = Timer(
                                                        Duration(seconds: 35),
                                                            () {
                                                          pinPageVisiable =
                                                          false;
                                                          qrAndpinVisiable =
                                                          true;
                                                          pinVisiable = true;
                                                        });
                                                    _pinStr = "";
                                                    _mobileNumber = "";
                                                  });
                                                },
                                                child: const AutoSizeText("PIN",
                                                    style:
                                                        TextStyle(fontSize: 40),
                                                    minFontSize: 14,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 0, 20, 0),
                                            child: Visibility(
                                              visible: pinPageVisiable,
                                              child: TextFormField(
                                                onSaved: (val) =>
                                                    _pinStr = val!,
                                                decoration: InputDecoration(
                                                    labelText: 'Enter PIN'),
                                                keyboardType:
                                                    TextInputType.number,
                                                maxLength: 5,
                                                obscureText: true,
                                                obscuringCharacter: '*',
                                                onChanged: (pin) {
                                                  _pinStr = pin;
                                                },
                                                validator: (Pin) {
                                                  if ((Pin!.length != 5)) {
                                                    return "Enter a valid PIN";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                style: const TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 20, 20, 20),
                                            child: Visibility(
                                              visible: pinPageVisiable,
                                              child: IntlPhoneField(
                                                decoration:
                                                    const InputDecoration(
                                                  counter: Offstage(),
                                                  hintText:
                                                      'Enter Mobile Number',
                                                ),
                                                initialCountryCode: 'US',
                                                showDropdownIcon: true,
                                                dropdownTextStyle:
                                                    const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                dropdownIconPosition:
                                                    IconPosition.trailing,
                                                onChanged: (phone) {
                                                  _mobileNumber = phone.number;
                                                  _countryCode =
                                                      phone.countryCode;
                                                  print(_countryCode);
                                                },
                                                style: const TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 20, 20),
                                              child: Visibility(
                                                  visible: pinPageVisiable,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        foregroundColor:
                                                            Colors.black,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(25.0),
                                                        backgroundColor:
                                                            Colors.blue,
                                                      ),
                                                      onPressed: () {
                                                        if (_pinStr.isEmpty) {
                                                          context.showToast(
                                                              "Please Enter pin");
                                                        } else if (_mobileNumber
                                                            .isEmpty) {
                                                          context.showToast(
                                                              "Please Enter Mobile Number");
                                                        } else {
                                                          VolunteerValidation();
                                                          try {
                                                            if (pinVisiable) {
                                                              delayQRPinUI
                                                                  .cancel();
                                                            }
                                                          } catch (e) {
                                                            print(
                                                                "error : ${e.toString()}");
                                                          }
                                                        }
                                                      },
                                                      child: const AutoSizeText(
                                                        "Proceed",
                                                        style: TextStyle(
                                                            fontSize: 40),
                                                        minFontSize: 14,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  )))
                                        ],
                                      ),
                                    ),
                                  ]),
                            ],
                          ))),
                ))
          ]),
        ))));
  }

  Future<void> timeDateSet() async {
    //updateUI();
    SetDefaultUI();
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

    Map<String, dynamic> deviceSetting = HashMap();
    deviceSetting['deviceSN'] = '${pref.getString(Sharepref.serialNo)}';
    deviceSetting['institutionId'] =
        '${pref.getString(Sharepref.institutionID)}';
    deviceSetting['settingType'] = 10;
    String req = await ApiService().deviceSetting(pref) as String;
    if (req == "1") updateUI();
  }

  Future<void> VolunteerValidation() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map<String, dynamic> volunteerInfo = HashMap();
    volunteerInfo['pin'] = base64Url.encode(utf8.encode(_pinStr));
    volunteerInfo['countrycode'] = _countryCode;
    volunteerInfo['phoneNumber'] = _mobileNumber;
    volunteerInfo['deviceSN'] = '${pref.getString(Sharepref.serialNo)}';


    VolunteerResponse? volunteerResponse = await ApiService()
        .volunteerApiCall(pref.getString(Sharepref.accessToken), volunteerInfo);
    if (volunteerResponse?.responseCode == 1) {
      if (volunteerResponse?.responseData!.volunteerList != null) {
        String nameFull = volunteerResponse!.responseData!.firstName;
        if (volunteerResponse!.responseData!.middleName.isNotEmpty &&
            volunteerResponse!.responseData!.lastName.isNotEmpty) {
          nameFull =
              '${volunteerResponse!.responseData!.firstName} ${volunteerResponse!.responseData!.middleName} ${volunteerResponse!.responseData!.lastName}';
        } else if (volunteerResponse!.responseData!.lastName.isNotEmpty) {
          nameFull =
              '${volunteerResponse!.responseData!.firstName} ${volunteerResponse!.responseData!.lastName}';
        }
        if (volunteerResponse!.responseData!.volunteerList!.length == 0) {
          context.showToast("No active slots");
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VolunteerCheckIn(
                      itemId: volunteerResponse!.responseData!.id,
                      name: nameFull,
                      volunteerList:
                          volunteerResponse!.responseData!.volunteerList!)));
        }
      }
    } else {
      if (volunteerResponse?.responseMessage != null) {
        context.showToast(volunteerResponse!.responseMessage!);
      } else {
        context.showToast("Invalid PIN or mobile number");
      }
    }
  }

  Future<void> updateUI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("ddddddddd pref.getString(Sharepref.enableVisitorCheckout)= ${pref.getString(Sharepref.enableVisitorCheckout)},pref.getString(Sharepref.enableVisitorQR) =${pref.getString(Sharepref.enableVisitorQR)}");
   if(pref.getString(Sharepref.enableVisitorQR) == "0")
     {
       enableVisitorCheckout = true;
     } else if(pref.getString(Sharepref.enableVisitorCheckout) == "1" && pref.getString(Sharepref.enableVisitorQR) == "1"){
     enableVisitorCheckout = true;
   }else enableVisitorCheckout = false;
    setState(() {
      if (pref.getString(Sharepref.checkInMode) == "0") {
        checkInVisiable = true;
        checkOutVisiable = enableVisitorCheckout;
      } else if (pref.getString(Sharepref.checkInMode) == "1") {
        pinPageVisiable = true;

        // qrAndpinVisiable = false;
        // pinVisiable = false;
      } else if (pref.getString(Sharepref.checkInMode) == "2") {
        // checkInVisiable = false;
        // checkOutVisiable = false;
        qrAndpinVisiable = true;
        pinVisiable = true;
        //pinPageVisiable = false;
      }
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

  Future<void> SetDefaultUI() async{
setState(() {
   checkInVisiable = false;
   checkOutVisiable = false;
   qrAndpinVisiable = false;
   pinPageVisiable = false;
   pinVisiable = false;
});
  }

  @override
  void dispose() {
    super.dispose();
    dataTime.cancel();
    // timer.cancel();
  }
}
