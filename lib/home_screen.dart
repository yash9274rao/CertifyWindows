import 'dart:async';
import 'dart:collection';
import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snaphybrid/QRViewExmple.dart';
import 'package:snaphybrid/api/api_service.dart';
import 'package:snaphybrid/pinView.dart';

import 'common/sharepref.dart';
import 'common/util.dart';
import'package:intl_phone_field/intl_phone_field.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MyHome createState() => _MyHome();
}

class _MyHome extends State<HomeScreen> {
  final _formGlobalKey = GlobalKey<FormState>();
  var timeTextHolderModalController = "",
      dateTextHolderModalController = "",
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
      home: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          // reverse: false,
          child:Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

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
                          child:SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),//scrolling off
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
                                  Center(
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(0,0,0,50),
                                    child: Text(
                                      dateTextHolderModalController,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18,
                                          color: Colors.white),
                                    ),
                                  ),
                                  )],
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                      child:Visibility(
                        visible: checkInVisiable,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(16.0),
                          textStyle: const TextStyle(fontSize: 24),
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () async {
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          bool result =
                          await InternetConnectionChecker().hasConnection;
                          if (result) {
                            attendanceMode = "1";
                            SharedPreferences pref =
                            await SharedPreferences.getInstance();
                            if(pref.getString(Sharepref.checkInMode) == "0"){
                              pref.setBool(Sharepref.isQrCodeScan, true);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                       QRViewExample(
                                          attendanceMode: attendanceMode)));

                          }else if(pref.getString(Sharepref.checkInMode) == "1"){
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
                          }else if (pref.getString(Sharepref.checkInMode) == "2") {
                              checkInVisiable = false;
                              checkOutVisiable = false;
                              qrAndpinVisiable = true;
                          }
                          } else {
                            Util.showToastError("No Internet");
                          }
                        },
                        child: const Text("       Check-In       ",),
                      ),
                    ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 0, 20),
                      child: Visibility(
                        visible: checkOutVisiable,
                        child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                          padding: const EdgeInsets.all(16.0),
                          textStyle: const TextStyle(fontSize: 24),
                          backgroundColor: Colors.red.shade200,
                        ),
                        onPressed: () async {

                          SharedPreferences pref = await SharedPreferences.getInstance();
                          bool result =
                          await InternetConnectionChecker().hasConnection;
                          if (result) {
                            attendanceMode = "2";
                            if(pref.getString(Sharepref.checkInMode) == "0") {
                              pref.setBool(Sharepref.isQrCodeScan, true);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          QRViewExample(
                                              attendanceMode: attendanceMode)));
                            }else if(pref.getString(Sharepref.checkInMode) == "1") {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => PinViewPage(attendanceMode: attendanceMode)),
                              // );
                              pinPageVisiable = true;
                              checkInVisiable = false;
                              checkOutVisiable = false;
                              qrAndpinVisiable = false;
                            }else if (pref.getString(Sharepref.checkInMode) == "2"){
                              checkInVisiable = false;
                              checkOutVisiable = false;
                              qrAndpinVisiable = true;
                            }
                          } else {
                            Util.showToastError("No Internet");
                          }
                        },
                        child: const Text("      Check-Out      "),
                      ),
                    ),
                    ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 0, 20),
              child:Visibility(
              visible:qrAndpinVisiable,// false qrbox hidden
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 24),
                  backgroundColor: Colors.blue,

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
                          builder: (context) =>
                           QRViewExample(
                              attendanceMode: attendanceMode)));
                } else {
                  Util.showToastError("No Internet");
                }
              }, child: const Text("        QrCode        "),
              ),
          ),
          ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 0, 20),
                      child:Visibility(
                        visible:qrAndpinVisiable,// false pin box hidden
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.all(16.0),
                          textStyle: const TextStyle(fontSize: 24),
                          backgroundColor: Colors.blue,
                        ), onPressed: () async {
                        bool result =
                            await InternetConnectionChecker().hasConnection;
                        if (result) {
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
                        } else {
                          Util.showToastError("No Internet");
                        }
                      }, child: const Text("            PIN            "),
                      ),
                    ),
                    ),
                   Padding(
                      padding: const EdgeInsets.all(30),
                      child:Visibility(
                          visible:pinPageVisiable,
                      child:TextFormField(
                        decoration: InputDecoration(labelText: 'Enter Pin'),
                        keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                          maxLength: 6,
                          obscureText: true,
                        obscuringCharacter: '*',
                          validator: (Pin) {
                          if ((Pin!.length != 6)){
                            return "Enter a valid Pin";
                          }
                          else{
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
                    padding: const EdgeInsets.all(30),
                      child:Visibility(
                        visible:pinPageVisiable,
                    child:IntlPhoneField(
                      decoration: const InputDecoration(
                        counter: Offstage(),
                        hintText: 'Enter Mobile Number',
                        // border: OutlineInputBorder(
                        //   borderSide: BorderSide(),
                        // ),
                      ),
                      initialCountryCode: 'IN',
                      showDropdownIcon: true,
                      dropdownIconPosition:IconPosition.trailing,
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                    ),
                    ),
                    ),

          SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
            child:Visibility(
              visible:pinPageVisiable,
            child: Align(
              alignment: Alignment.centerRight,

                    child: ElevatedButton(
                      onPressed: () {
                        // if (formGlobalKey.currentState.validate()) {
                        //   // take action what you want
                        // }
                      },
                      child: Text("Proceed"),
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20)
                      ),
                    ),

          ),
          )
          )  ],


                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> timeDateSet() async {
    updateUI();
    dataTime = Timer.periodic(const Duration(seconds: 1), (dataTime) {
      String time = DateFormat('hh:mm a').format(DateTime.now());
      String date = DateFormat('EEEEE, dd MMM yyyy').format(DateTime.now());

      setState(() {
        timeTextHolderModalController = time;
        dateTextHolderModalController = date;
      });
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
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
    healthCheckRequest['pushAuthToken'] = pref.getString(Sharepref.firebaseToken);
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
      if(qrAndpinVisiable){
        checkOutVisiable = false;
      }else
      if ( pref.getString(Sharepref.enableVisitorCheckout) == "0" && pref.getString(Sharepref.enableVisitorQR) == "1"){
        setState(() {
          checkOutVisiable = false;
        }
        );
      }else {
        setState(() {
          checkOutVisiable = true;
        }
        );
      }
      lineOneText = pref.getString(Sharepref.line1HomePageView)?? "";
      lineTwoText = pref.getString(Sharepref.line2HomePageView)?? "";
      String? base64 = pref.getString(Sharepref.logoHomePageView)?? "";
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
