import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:certify_me_kiosk/QRViewExmple.dart';
import 'package:certify_me_kiosk/pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/color_code.dart';
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
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Certify.me KIOSK',
      home: Scaffold(
        body: Container(
          color: Colors.white,
          height: _height,
          width:_width,
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
                    style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ColorCode.titleFont,
                        color: Color(ColorCode.line1color)),
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
                          child: AutoSizeText(
                            lineTwoText,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: ColorCode.subTextFont,
                                color: Color(ColorCode.line2color)),
                          ),
                        ),
                      ]),
                ),
                    Container(alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          left: _width * 0.10,
                          right: _width * 0.10,
                          top: 30),
                  // false qrbox hidden
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shadowColor: Colors.grey,
                        backgroundColor: ColorCode.dynamicBackgroundColorBtn,
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius
                              .circular(15.0),
                        ),
                        elevation: 9,
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
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: _width * ColorCode.buttonsValues, minHeight: ColorCode.buttonsHeight),
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: AutoSizeText("QR-Code",
                            style: TextStyle(fontSize: ColorCode.buttonFont, color: ColorCode.dynamicTextColorBtn),
                            minFontSize: 14,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                    Container(alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          left: _width * 0.10,
                          right: _width * 0.10,
                          top: 10),
                      child: AutoSizeText("Click here if you have the QR code",
                        style: TextStyle(fontSize:ColorCode.subTextFont,color: Colors.grey),
                          minFontSize: 20,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),),
                    Container(alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          left: _width * 0.10,
                          right: _width * 0.10,
                          top: 30),

                  child: TextButton(
                    style: TextButton.styleFrom(
                      elevation: 9,
                      shadowColor: Colors.grey,
                      backgroundColor: ColorCode.dynamicBackgroundColorBtn,
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius
                            .circular(15.0),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PinScreen(
                                  attendanceMode: widget.attendanceMode)));
                    },

                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: _width * ColorCode.buttonsValues, minHeight: ColorCode.buttonsHeight),
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: AutoSizeText("Enter PIN",
                            style: TextStyle(fontSize: ColorCode.buttonFont, color: ColorCode.dynamicTextColorBtn),
                            minFontSize: 14,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),

             Container(alignment: Alignment.center,
               margin:EdgeInsets.only(top: 15),
               child: AutoSizeText("Click here if you have the PIN and phone number",
                   style: TextStyle(fontSize:ColorCode.subTextFont,color: Colors.grey),
                 minFontSize: 20,
                 maxLines: 1,
                 overflow: TextOverflow.ellipsis),),
                    const SizedBox(width: 45,height: 16,),

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
