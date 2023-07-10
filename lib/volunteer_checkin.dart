import 'dart:convert';

import 'package:certify_me_kiosk/common/qr_data.dart';
import 'package:certify_me_kiosk/volunteer_schedul_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/response/response_data_voluntear.dart';
import 'common/sharepref.dart';

typedef StringValue = String Function(String);
var _imageToShow = const Image(image: AssetImage('images/assets/final_logo.png'));

class VolunteerCheckIn extends StatelessWidget {
  const VolunteerCheckIn(
      {Key? key,
      required this.itemId,
      required this.name,
      required this.volunteerList})
      : super(key: key);
  final int itemId;
  final String name;
  final List<VolunteerSchedulingDetailList> volunteerList;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Certify.me Kiosk',
      debugShowCheckedModeBanner: false,
      home: ConfirmLanch(itemId, name, volunteerList),
    );
  }
}

class ConfirmLanch extends StatefulWidget {
  ConfirmLanch(this.itemId,  this.name, this.volunteerList);

  final String name;
  final int itemId;
  final List<VolunteerSchedulingDetailList> volunteerList;

  @override
  _Confirm createState() => _Confirm();
}

class _Confirm extends State<ConfirmLanch> {
  var textHolderModalController = "";
  bool _isLoading = false;
  var confirmationText = "";
  var confirmationSubText = "";
  var screenDelayValue = "120";
  var result;
  String attendanceMode = "0";
  QrData qrData = QrData();

  @override
  void initState() {
    super.initState();
    updateUI();
    screenDelay();
  }

  Future<void> screenDelay() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString(Sharepref.viewDelay) == "") {
      screenDelayValue;
    } else {
      screenDelayValue = pref.getString(Sharepref.viewDelay).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: Center(
                child: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(150, 50, 10, 0),
                            child: Container(
                            child: _imageToShow),
                          ),
                          Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      150, 10, 150, 50),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7.0))),
                                      child: ListView(children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      35, 5, 0, 0),
                                              child: TextButton.icon(
                                                onPressed: () {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop(context);
                                                },
                                                icon: const Icon(
                                                  color: Colors.black,
                                                  Icons.arrow_back_outlined,
                                                  size: 30.0,
                                                ),
                                                label: Text(
                                                  "Hi ${widget.name}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Padding(
                                        //   padding:
                                        //       const EdgeInsets.fromLTRB(50, 50, 5, 5),
                                        //   child: Text(
                                        //     "Hi Heena",
                                        //     style: const TextStyle(
                                        //         fontWeight: FontWeight.bold,
                                        //         fontSize: 25),
                                        //   ),
                                        // ),
                                        const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              50, 5, 0, 0),
                                          child: Text(
                                            "What Would you like to do?",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              50, 5, 0, 0),
                                          child: Text(
                                            "Click on Check-In to sign in and Check-Out to \nsign out.",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey,
                                                fontSize: 20),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              50, 10, 0, 0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 20, 50, 0),
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    textStyle: const TextStyle(
                                                        fontSize: 24),
                                                    backgroundColor:
                                                        Colors.green,
                                                    minimumSize:
                                                        const Size.fromHeight(
                                                            90),
                                                  ),
                                                  onPressed: () {
                                                    attendanceMode = "1";
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    VolunteerSchedulingList(itemId : widget.itemId, name : widget.name, attendanceMode: attendanceMode, volunteerList : widget.volunteerList)
                                                        ));
                                                  },
                                                  child: const Text(
                                                    "       Check-In       ",
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 20, 50, 0),
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.redAccent,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    textStyle: const TextStyle(
                                                        fontSize: 24),
                                                    backgroundColor:
                                                        Colors.red.shade200,
                                                    minimumSize:
                                                        const Size.fromHeight(
                                                            85),
                                                  ),
                                                  onPressed: () {
                                                    attendanceMode = "2";

                                                  },
                                                  child: const Text(
                                                    "       Check-Out       ",
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        )
                                      ]))))
                        ])))));
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
    });
    }
}
