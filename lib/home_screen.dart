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
                            child: Expanded(child: _imageToShow),
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
                                  flex: 1,
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
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            120, 0, 120, 0),
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
                                                                if (checkInMode ==
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
                                                                if (checkInMode ==
                                                                    "1") {
                                                                  Navigator.pushReplacement(context,
                                                                      MaterialPageRoute(builder: (context) => PinScreen(attendanceMode: attendanceMode)));

                                                                } else
                                                                if (checkInMode ==
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
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            120, 30, 120, 0),
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
                                                              if (checkInMode ==
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
                                                              if (checkInMode ==
                                                                  "1") {
                                                                Navigator.pushReplacement(context,
                                                                    MaterialPageRoute(builder: (context) => PinScreen(attendanceMode: attendanceMode)));

                                                              } else
                                                              if (checkInMode ==
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
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            120, 0, 120, 0),
                                                        child: Visibility(
                                                          visible: qrAndpinVisiable,
                                                          // false qrbox hidden
                                                          child: TextButton(
                                                            style: TextButton
                                                                .styleFrom(
                                                              foregroundColor:
                                                              Colors.black,
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(
                                                                  25.0),
                                                              backgroundColor:
                                                              Colors.blue,
                                                              minimumSize:
                                                              const Size
                                                                  .fromHeight(
                                                                  40),
                                                            ),
                                                            onPressed: () async {
                                                              setState(() {
                                                                pinPageVisiable =
                                                                false;
                                                                checkInVisiable =
                                                                true;
                                                                qrAndpinVisiable =
                                                                false;
                                                                pinVisiable =
                                                                false;
                                                                checkOutVisiable =
                                                                    enableVisitorCheckout;
                                                                delayQRPinUI =
                                                                    Timer(
                                                                        Duration(
                                                                            seconds: 15),
                                                                            () {
                                                                          checkInVisiable =
                                                                          false;
                                                                          checkOutVisiable =
                                                                          false;
                                                                          qrAndpinVisiable =
                                                                          true;
                                                                          pinVisiable =
                                                                          true;
                                                                        });
                                                              });
                                                            },
                                                            child: const AutoSizeText(
                                                                "QR Code",
                                                                style: TextStyle(
                                                                    fontSize: 32),
                                                                minFontSize: 14,
                                                                maxLines: 1,
                                                                overflow: TextOverflow
                                                                    .ellipsis),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            120, 30, 120, 0),
                                                        child: Visibility(
                                                          visible: pinVisiable,
                                                          // false pin box hidden
                                                          child: TextButton(
                                                            style: TextButton
                                                                .styleFrom(
                                                              foregroundColor:
                                                              Colors.black,
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(
                                                                  25.0),
                                                              backgroundColor:
                                                              Colors.blue,
                                                              minimumSize:
                                                              const Size
                                                                  .fromHeight(
                                                                  40),
                                                            ),
                                                            onPressed: () async {
                                                              setState(() {
                                                                pinPageVisiable =
                                                                true;
                                                                checkInVisiable =
                                                                false;
                                                                checkOutVisiable =
                                                                false;
                                                                qrAndpinVisiable =
                                                                false;
                                                                pinVisiable =
                                                                false;
                                                                delayQRPinUI =
                                                                    Timer(
                                                                        Duration(
                                                                            seconds: 35),
                                                                            () {
                                                                          pinPageVisiable =
                                                                          false;
                                                                          qrAndpinVisiable =
                                                                          true;
                                                                          pinVisiable =
                                                                          true;
                                                                        });
                                                                _pinStr = "";
                                                                _mobileNumber =
                                                                "";
                                                              });
                                                            },
                                                            child: const AutoSizeText(
                                                                "PIN",
                                                                style: TextStyle(
                                                                    fontSize: 32),
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
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .fromLTRB(
                                                            20, 0, 20, 0),
                                                        child: Visibility(
                                                          visible: pinPageVisiable,
                                                          child: TextFormField(
                                                            onSaved: (val) =>
                                                            _pinStr = val!,
                                                            decoration: InputDecoration(
                                                                labelText: 'Enter PIN'),
                                                            keyboardType:
                                                            TextInputType
                                                                .number,
                                                            maxLength: 5,
                                                            obscureText: true,
                                                            autofocus: true,
                                                            obscuringCharacter: '*',
                                                            onChanged: (pin) {
                                                              _pinStr = pin;
                                                            },
                                                            validator: (Pin) {
                                                              if ((Pin!
                                                                  .length !=
                                                                  5)) {
                                                                return "Enter a valid PIN";
                                                              } else {
                                                                return null;
                                                              }
                                                            },
                                                            style: const TextStyle(
                                                              fontSize: 30,
                                                              color: Colors
                                                                  .black,
                                                              fontWeight:
                                                              FontWeight.normal,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .fromLTRB(
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
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 30,
                                                                fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                            dropdownIconPosition:
                                                            IconPosition
                                                                .trailing,
                                                            onChanged: (phone) {
                                                              _mobileNumber =
                                                                  phone.number;
                                                              _countryCode =
                                                                  phone
                                                                      .countryCode;
                                                              print(
                                                                  _countryCode);
                                                            },
                                                            onCountryChanged:
                                                                (country) {
                                                              _countryCode =
                                                              '+${country
                                                                  .fullCountryCode}';
                                                            },
                                                            style: const TextStyle(
                                                              fontSize: 30,
                                                              color: Colors
                                                                  .black,
                                                              fontWeight:
                                                              FontWeight.normal,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .fromLTRB(
                                                              20, 30, 20, 20),
                                                          child: Visibility(
                                                              visible: pinPageVisiable,
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .bottomRight,
                                                                child: TextButton(
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                    foregroundColor:
                                                                    Colors
                                                                        .black,
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        25.0),
                                                                    backgroundColor:
                                                                    Colors.blue,
                                                                  ),
                                                                  onPressed: () {
                                                                    FocusScope
                                                                        .of(
                                                                        context)
                                                                        .unfocus();
                                                                    if (_pinStr
                                                                        .isEmpty) {
                                                                      context
                                                                          .showToast(
                                                                          "Please Enter pin");
                                                                    } else
                                                                    if (_mobileNumber
                                                                        .isEmpty) {
                                                                      context
                                                                          .showToast(
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
                                                                            "error : ${e
                                                                                .toString()}");
                                                                      }
                                                                    }
                                                                  },
                                                                  child:
                                                                  const AutoSizeText(
                                                                    "Proceed",
                                                                    style: TextStyle(
                                                                        fontSize: 32),
                                                                    minFontSize: 14,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                    TextOverflow
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
          '${volunteerResponse!.responseData!.firstName} ${volunteerResponse!
              .responseData!.middleName} ${volunteerResponse!.responseData!
              .lastName}';
        } else if (volunteerResponse!.responseData!.lastName.isNotEmpty) {
          nameFull =
          '${volunteerResponse!.responseData!.firstName} ${volunteerResponse!
              .responseData!.lastName}';
        }
        if (volunteerResponse!.responseData!.volunteerList!.length == 0) {
          context.showToast("No active slots");
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      VolunteerCheckIn(
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
