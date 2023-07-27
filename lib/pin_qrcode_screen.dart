import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:certify_me_kiosk/QRViewExmple.dart';
import 'package:certify_me_kiosk/pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/sharepref.dart';
import 'home_screen.dart';

class PinQrCodeScreen extends StatefulWidget {
  const PinQrCodeScreen({Key? key, required this.attendanceMode})
      : super(key: key);
  final String attendanceMode;

  @override
  _MyPinQrCodeScreen createState() => _MyPinQrCodeScreen();
}

class _MyPinQrCodeScreen extends State<PinQrCodeScreen> {
  var lineOneText = "", lineTwoText = "";
  var _imageToShow =
      const Image(image: AssetImage('images/assets/final_logo.png'));
  late Timer timer, delayQRPinUI;

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Certify.me Kiosk',
      home: Scaffold(
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            lineTwoText,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                color: Color(0xff245F99)),
                          ),
                        ),
                      ]),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
                ),
                Center(
                  // false qrbox hidden
                  child: TextButton(
                    style: TextButton.styleFrom(
                      elevation: 20,
                      shadowColor: Colors.grey,
                    ),
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.setBool(Sharepref.isQrCodeScan, true);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QRViewExample(
                                  attendanceMode: widget.attendanceMode)));
                    },
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff175EA5), Color(0xff163B60)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          tileMode: TileMode.repeated,
                          stops: [0.0, 1.7],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                            maxWidth: 300.0, minHeight: 50.0),
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const AutoSizeText("QR-Code",
                            style: TextStyle(fontSize: 32, color: Colors.white),
                            minFontSize: 14,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                ),
                    Container(alignment: Alignment.center,
                      margin:EdgeInsets.only(top: 15), child: Text("Click here if you have the QR code",style: TextStyle(color: Colors.grey),),),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                ),
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      elevation: 20,
                      shadowColor: Colors.grey,
                    ),
                    onPressed: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PinScreen(
                                  attendanceMode: widget.attendanceMode)));
                    },
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff175EA5), Color(0xff163B60)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          tileMode: TileMode.repeated,
                          stops: [0.0, 1.7],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                            maxWidth: 300.0, minHeight: 50.0),
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const AutoSizeText("Enter PIN",
                            style: TextStyle(fontSize: 32, color: Colors.white),
                            minFontSize: 14,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                ),
             Container(alignment: Alignment.center,
               margin:EdgeInsets.only(top: 15),
               child: Text("Click here if you have the PIN and phone number",style: TextStyle(color: Colors.grey),),),

                  ])),
        ),
      ),
    );
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
        lineOneText = "Check-In";
        lineTwoText = "Choose your mode of check-in through this device.";
      } else {
        lineOneText = "Check-Out";
        lineTwoText = "Choose your mode of check-out through this device.";
      }
    });
    Future.delayed(Duration(seconds: 15), () {
      try {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      } catch (e) {
        print("Error :" + e.toString());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
