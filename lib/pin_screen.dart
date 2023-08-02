import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:certify_me_kiosk/confirm_screen.dart';
import 'package:certify_me_kiosk/toast.dart';
import 'package:certify_me_kiosk/volunteer_schedul_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:certify_me_kiosk/api/api_service.dart';
import 'api/response/VoluntearResponse.dart';
import 'api/response/response_data_voluntear.dart';
import 'common/sharepref.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'home_screen.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({Key? key, required this.attendanceMode}) : super(key: key);
  final String attendanceMode;

  @override
  _MyPinScreen createState() => _MyPinScreen();
}

class _MyPinScreen extends State<PinScreen> {
  var lineOneText = "Volunteer Information Centre", lineTwoText = "";
  var _imageToShow =
      const Image(image: AssetImage('images/assets/final_logo.png'));
  String _pinStr = "", _mobileNumber = "", _countryCode = "1";
  int itemId = 0;
  String name = "";
  String nameFull = "";
  late Timer timerDelay;
  List<VolunteerSchedulingDetailList> volunteerList = [];
  late ProgressDialog _isProgressLoading;
  @override
  void initState() {
    super.initState();
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    _isProgressLoading = ProgressDialog(context,type: ProgressDialogType.normal, isDismissible: false);
    _isProgressLoading.style(padding: EdgeInsets.all(25),);
    return MaterialApp(
        title: 'Certify.me Kiosk',
        home: Scaffold(
          body: Container(
              color: Colors.white,
              height: _height,
              width: _width,
              padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: _imageToShow),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        lineOneText,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Color(0xff273C51)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        lineTwoText,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            color: Color(0xff245F99)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top:40, left: _width * 0.20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xffE0E9F2),
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                                splashColor: Colors.lime,
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomeScreen()));
                                },
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: const AutoSizeText('Enter Details',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    color: Color(0xff273C51)),
                                minFontSize: 22,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(
                          top: 40,
                          left: _width * 0.23,
                          right: _width * 0.23),
                      child: Row(children: [
                        const ImageIcon(
                            AssetImage('images/assets/password_pin.png')),
                        const SizedBox(
                          width: 15, //<-- SEE HERE
                        ), Expanded(
                          child: TextFormField(
                            onSaved: (val) => _pinStr = val!,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              // for below version 2 use this
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                             // for version 2 and greater youcan also use this
                              FilteringTextInputFormatter.digitsOnly

                            ],
                            maxLength: 5,
                            obscureText: true,
                            autofocus: true,
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
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius:BorderRadius.all(Radius.circular(5))),
                              enabledBorder: UnderlineInputBorder(
                                  // borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              //  prefixIcon: Icon(Icons.password,color: Colors.black,),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "Enter PIN",
                              // hintText: 'your-email@domain.com',
                              labelStyle: TextStyle(
                                  color: Colors.black26, fontSize: 18),
                            ),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: _height * 0.01,
                          left: _width * 0.23,
                          right: _width * 0.23),
                      child: Row(children: [
                        const ImageIcon(
                            AssetImage('images/assets/phone_pin.png')),
                        const SizedBox(
                          width: 15, //<-- SEE HERE
                        ),
                        Expanded(
                          child: IntlPhoneField(
                            keyboardType: TextInputType.phone,
                            inputFormatters: <TextInputFormatter>[
                              // for below version 2 use this
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              // for version 2 and greater youcan also use this
                              FilteringTextInputFormatter.digitsOnly

                            ],
                            decoration: const InputDecoration(
                              counter: Offstage(),
                              hintText: 'Enter Phone Number',
                              //   prefixIcon: Icon(Icons.wifi_calling_3_sharp,color: Colors.black,),
                            ),
                            initialCountryCode: 'US',
                            showDropdownIcon: true,
                            dropdownTextStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                            dropdownIconPosition: IconPosition.trailing,
                            onChanged: (phone) {
                              _mobileNumber = phone.number;
                              _countryCode = phone.countryCode;
                            },
                            onCountryChanged: (country) {
                              _countryCode = '+${country.fullCountryCode}';
                            },
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: _height * 0.03,
                            left: _width * 0.23,),
                       child: TextButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  if (_pinStr.isEmpty) {
                                    context.showToast("Please Enter PIN");
                                  } else if (_mobileNumber.isEmpty) {
                                    context.showToast(
                                        "Please Enter Phone Number");
                                  } else {
                                    VolunteerValidation();
                                  }
                                },
                                child: Ink(
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
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Container(
                                    constraints: const BoxConstraints(
                                        maxWidth: 300.0, minHeight: 50.0),
                                    padding: const EdgeInsets.all(16.0),
                                    alignment: Alignment.center,
                                    child: const AutoSizeText(
                                      "Continue",
                                      style: TextStyle(
                                          fontSize: 32, color: Colors.white),
                                      minFontSize: 14,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                            )))
                  ],
                ),
              )),
          // false qrbox hidden
        ));
  }

  Future<void> VolunteerValidation() async {
    await _isProgressLoading.show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> volunteerInfo = HashMap();
    volunteerInfo['pin'] = base64Url.encode(utf8.encode(_pinStr));
    volunteerInfo['countrycode'] = _countryCode;
    volunteerInfo['phoneNumber'] = _mobileNumber;
    volunteerInfo['deviceSN'] = '${pref.getString(Sharepref.serialNo)}';

    VolunteerResponse? volunteerResponse = await ApiService()
        .validatePin(pref.getString(Sharepref.accessToken), volunteerInfo);
    if (volunteerResponse?.responseCode == 1) {
      await _isProgressLoading.hide();
      if (volunteerResponse?.responseData!.volunteerList != null) {
        nameFull = volunteerResponse!.responseData!.firstName;
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
          volunteerList = volunteerResponse!.responseData!.volunteerList!;
          CheckInOutValidations(volunteerResponse!.responseData!.id);
        }
      }
    } else {
      await _isProgressLoading.hide();
      if (volunteerResponse?.responseMessage != null) {
        context.showToast(volunteerResponse!.responseMessage!);
      } else {
        context.showToast("Invalid PIN or Phone Number");
      }
    }
  }

  Future<void> updateUI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      String? base64 = pref.getString(Sharepref.logoHomePageView) ?? "";
      if (base64.isNotEmpty) {
        _imageToShow = Image.memory(const Base64Decoder().convert(base64));
      } else {
        _imageToShow =
        const Image(image: AssetImage('images/assets/final_logo.png'));
      }
      if (widget.attendanceMode == "1") {
        lineTwoText =
            "Enter the 5 digit secure PIN along with the registered phone number and click on continue to Check-In.";
      } else {
        lineTwoText =
            "Enter the 5 digit secure PIN along with the registered phone number and click on continue to Check-Out.";
      }
    });
    timerDelay = Timer(Duration(seconds: 60), () {
      try {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      } catch (e) {
        print("Error :" + e.toString());
      }
    });
  }

  Future<void> CheckInOutValidations(int id) async {
    try {
      // final List<VolunteerSchedulingDetailList> volunteerListCheckIn = [];
      final List<VolunteerSchedulingDetailList> volunteerListCheckOut = [];

      for (var item in volunteerList) {
        if (item.checkIndate.isEmpty ||
            (item.checkIndate.isNotEmpty && item.checkOutDate.isNotEmpty)) {
          //  volunteerListCheckIn.add(item);
        } else {
          volunteerListCheckOut.add(item);
        }
      }
      if (widget.attendanceMode == "1") {
        //  if (volunteerListCheckOut.isEmpty) {
        if (volunteerList.length == 1) {
          cancelTimer();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ConfirmScreen(
                      dataStr: '',
                      attendanceMode: widget.attendanceMode,
                      type: "pin",
                      name: nameFull,
                      id: id,
                      scheduleId: volunteerList[0].scheduleId!, scheduleEventName: volunteerList[0].scheduleTitle!, scheduleEventTime: '${volunteerList[0].fromTime} - ${volunteerList[0].toTime}'!)));
        } else {
          cancelTimer();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => VolunteerSchedulingList(
                      itemId: id,
                      name: nameFull,
                      attendanceMode: widget.attendanceMode,
                      volunteerList: volunteerList)));
        }
        // } else {
        //   context.showToast("Already Checked-in");
        // }
      } else {
        if (volunteerListCheckOut.isEmpty) {
          context.showToast("Not Checked-in");
        } else if (volunteerListCheckOut.length == 1) {
          cancelTimer();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ConfirmScreen(
                      dataStr: '',
                      attendanceMode: widget.attendanceMode,
                      type: "pin",
                      name: nameFull,
                      id: id,
                      scheduleId: volunteerListCheckOut[0].scheduleId!, scheduleEventName: volunteerList[0].scheduleTitle!, scheduleEventTime: '${volunteerList[0].fromTime} - ${volunteerList[0].toTime}',)));
        } else {
          cancelTimer();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => VolunteerSchedulingList(
                      itemId: id,
                      name: nameFull,
                      attendanceMode: widget.attendanceMode,
                      volunteerList: volunteerListCheckOut)));
        }
      }
    } catch (e) {
      print("CheckInOutValidations :" + e.toString());
    }
  }

  Future<void> cancelTimer() async {
    try {
      timerDelay.cancel();
    } catch (e) {
      print("cancelTimer ${e.toString()}");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
