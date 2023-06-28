import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snaphybrid/QRViewExmple.dart';
import 'package:snaphybrid/api/api_service.dart';
import 'package:snaphybrid/checkincheckoutVoluntear.dart';
import 'package:snaphybrid/pinView.dart';

import 'common/sharepref.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MyHome createState() => _MyHome();
}

class _MyHome extends State<HomeScreen> {
  final _formGlobalKey = GlobalKey<FormState>();
  var timeTextHolderModalController = "",
      dateTextHolderModalController = "",
      versionId = "",
      lineOneText = "",
      lineTwoText = "";
  var _imageToShow = const Image(image: AssetImage('images/assets/quote.png'));
  late Timer dataTime;
  late Timer timer;
  String attendanceMode = "0";
  bool checkInVisiable = true;
  bool checkOutVisiable = true;
  bool qrAndpinVisiable = false;
  bool pinPageVisiable = false;
  bool pinVisiable = false;

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
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              25, 20, 25, 15),
                                          child: Text(
                                            lineOneText,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              25, 0, 25, 0),
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
                                  child: SingleChildScrollView(
                                    physics: NeverScrollableScrollPhysics(),
                                    //scrolling off
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          25, 0, 25, 25),
                                      child: Container(
                                        color: Colors.blueGrey.shade900,
                                        // width: MediaQuery.of(context).size.width * 0.4,

                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            const Image(
                                              image: AssetImage(
                                                  'images/assets/quote.png'),
                                            ),
                                            Center(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 20, 0, 5),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )),
                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 0, 20),
                                                child: Text(
                                                  dateTextHolderModalController,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 0, 0, 5),
                                              child: Text(
                                                versionId,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 10,
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
                              padding:
                                  const EdgeInsets.fromLTRB(25, 55, 30, 55),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                alignment: Alignment.center,
                                color: Colors.grey.shade200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            width:width * 0.3,
                                            height:height * 0.4,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 40, 0, 180),
                                            child: Visibility(
                                              visible: checkInVisiable,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  textStyle: const TextStyle(
                                                      fontSize: 24),
                                                  backgroundColor: Colors.green,
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
                                                        Sharepref.isQrCodeScan,
                                                        true);
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
                                                    // Navigator.pushReplacement(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             PinViewPage(
                                                    //                 attendanceMode: attendanceMode)));
                                                    pinPageVisiable = true;
                                                    checkInVisiable = false;
                                                    checkOutVisiable = false;
                                                    qrAndpinVisiable = false;
                                                    pinVisiable = false;
                                                  } else if (pref.getString(
                                                          Sharepref
                                                              .checkInMode) ==
                                                      "2") {
                                                    checkInVisiable = false;
                                                    checkOutVisiable = false;
                                                    qrAndpinVisiable = true;
                                                    pinPageVisiable = false;
                                                    pinVisiable = true;
                                                  }
                                                },
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: const Text(
                                                  "Check-In",
                                                ),
                                                )
                                              ),
                                            ),
                                          ),
                              ),
                                          SizedBox(
                                            width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 160, 0, 40),
                                      child: Visibility(
                                        visible: checkOutVisiable,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.redAccent,
                                            padding: const EdgeInsets.all(16.0),
                                            textStyle:
                                                const TextStyle(fontSize: 24),
                                            backgroundColor:
                                                Colors.red.shade200,
                                          ),
                                          onPressed: () async {
                                            SharedPreferences pref =
                                                await SharedPreferences
                                                    .getInstance();
                                            attendanceMode = "2";
                                            if (pref.getString(
                                                    Sharepref.checkInMode) ==
                                                "0") {
                                              pref.setBool(
                                                  Sharepref.isQrCodeScan, true);
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          QRViewExample(
                                                              attendanceMode:
                                                                  attendanceMode)));
                                            } else if (pref.getString(
                                                    Sharepref.checkInMode) ==
                                                "1") {
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(builder: (context) => PinViewPage(attendanceMode: attendanceMode)),
                                              // );
                                              pinPageVisiable = true;
                                              checkInVisiable = false;
                                              checkOutVisiable = false;
                                              qrAndpinVisiable = false;
                                              pinVisiable = false;
                                            } else if (pref.getString(
                                                    Sharepref.checkInMode) ==
                                                "2") {
                                              checkInVisiable = false;
                                              checkOutVisiable = false;
                                              qrAndpinVisiable = true;
                                              pinVisiable = true;
                                              pinPageVisiable = false;
                                            }
                                          },
                                          child: const Text(
                                              "Check-Out"),
                                        ),
                                      ),
                                    ),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 40, 0, 120),
                                      child: Visibility(
                                        visible: qrAndpinVisiable,
                                        // false qrbox hidden
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.black,
                                            padding: const EdgeInsets.all(16.0),
                                            textStyle:
                                                const TextStyle(fontSize: 24),
                                            backgroundColor: Colors.blue,
                                          ),
                                          onPressed: () async {
                                            SharedPreferences pref =
                                                await SharedPreferences
                                                    .getInstance();
                                            pref.setBool(
                                                Sharepref.isQrCodeScan, true);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        QRViewExample(
                                                            attendanceMode:
                                                                attendanceMode)));
                                          },
                                          child: const Text(
                                              "        QrCode        "),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 150, 0, 40),
                                      child: Visibility(
                                        visible: pinVisiable,
                                        // false pin box hidden
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.black,
                                            padding: const EdgeInsets.all(16.0),
                                            textStyle:
                                                const TextStyle(fontSize: 24),
                                            backgroundColor: Colors.blue,
                                          ),
                                          onPressed: () async {
                                            // Navigator.pushReplacement(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //        PinViewPage(
                                            //                 attendanceMode: attendanceMode)));
                                            pinPageVisiable = true;
                                            checkInVisiable = false;
                                            checkOutVisiable = false;
                                            qrAndpinVisiable = false;
                                            pinVisiable = false;
                                          },
                                          child: const Text(
                                              "            PIN            "),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 15, 20, 90),
                                      child: Visibility(
                                        visible: pinPageVisiable,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              labelText: 'Enter Pin'),
                                          keyboardType: TextInputType.number,
                                          maxLength: 5,
                                          obscureText: true,
                                          obscuringCharacter: '*',
                                          validator: (Pin) {
                                            if ((Pin!.length != 5)) {
                                              return "Enter a valid Pin";
                                            } else {
                                              return null;
                                            }
                                          },
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 160, 20, 20),
                                      child: Visibility(
                                        visible: pinPageVisiable,
                                        child: IntlPhoneField(
                                          decoration: const InputDecoration(
                                            counter: Offstage(),
                                            hintText: 'Enter Mobile Number',
                                          ),
                                          initialCountryCode: 'IN',
                                          showDropdownIcon: true,
                                          dropdownIconPosition:
                                              IconPosition.trailing,
                                          onChanged: (phone) {
                                            print(phone.completeNumber);
                                          },
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 300, 0, 20),
                                        child: Visibility(
                                            visible: pinPageVisiable,
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  // if(Pin == null || Pin.isNull){
                                                  //   Util.showToastError("Please enter email");
                                                  // }else{
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              VolunteerCheckinCheckOut()));
                                                },
                                                // },

                                                child: Text("Proceed"),
                                                style: ElevatedButton.styleFrom(
                                                    textStyle: const TextStyle(
                                                        fontSize: 20)),
                                              ),
                                            )))
                                    )],)
                                ]),
                              )))
                    ])))));
  }

  Future<void> timeDateSet() async {
    updateUI();
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

  Future<void> updateUI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      versionId = 'V${pref.getString(Sharepref.appVersion)!.substring(0, 3)}';
      if ((qrAndpinVisiable) || (pinPageVisiable) || (pinVisiable) ){
        checkOutVisiable = false;
      } else if (pref.getString(Sharepref.enableVisitorCheckout) == "0" &&
          pref.getString(Sharepref.enableVisitorQR) == "1") {
        setState(() {
          checkOutVisiable = false;
        });
      } else {
        setState(() {
          checkOutVisiable = true;
        });
      }
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
