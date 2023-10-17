import 'dart:collection';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:certify_me_kiosk/toast.dart';
import 'add_device.dart';
import 'api/api_service.dart';
import 'api/response/getdevice_token_response.dart';
import 'common/color_code.dart';
import 'common/sharepref.dart';

void main() {
  runApp(const login());
}

class login extends StatelessWidget {
  const login({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Certify.me kiosk',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // primarySwatch: Colors.blue,
          ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formGlobalKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  bool _isVisible = false;
   late ProgressDialog _isProgressLoading;
  @override
  Widget build(BuildContext context) {

    _isProgressLoading = ProgressDialog(context,type: ProgressDialogType.normal, isDismissible: false);
    _isProgressLoading.style(padding: EdgeInsets.all(25),);
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
        child: SingleChildScrollView(
          child: Form(
              key: _formGlobalKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 55, 0, 40),
                      child: Image(
                        image: AssetImage('images/assets/final_logo.png'),
                      ),
                    ),
                    // crossAxisAlignment : CrossAxisAlignment.stretch,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xffE0E9F2),
                            shape: BoxShape.rectangle,
                             borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                            splashColor: Colors.lime,
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop(context);
                            },
                          ),
                        ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: AutoSizeText('Log-In to Register',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ColorCode.titleFont,
                                  color: Color(ColorCode.addColorTitle)),
                              minFontSize: 22,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 10, 45),
                        child: Divider(color: Colors.grey)),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 60, right: 60, bottom: 20, top: 0),
                      child: TextFormField(
                          onSaved: (val) => _email = val!,
                          decoration:  InputDecoration(
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            enabledBorder: UnderlineInputBorder(
                                // borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            prefixIcon: Icon(
                              Icons.mail,
                              color: Color(ColorCode.addColorTitle),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "E-mail address",
                            // hintText: 'your-email@domain.com',
                            labelStyle:
                                TextStyle(color: Colors.black26, fontSize: 18),
                          ),
                          style: TextStyle(fontSize: ColorCode.editTextFont)),
                    ),

                    // Padding(
                    //     padding: EdgeInsets.fromLTRB(20 ,20, 20, 0),
                    //     child: Divider(color: Colors.grey)),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 60, right: 60, bottom: 20, top: 20),
                      child: TextFormField(
                          onSaved: (val) => _password = val!,
                          obscuringCharacter: '*',
                          obscureText: !_isVisible,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            enabledBorder: const UnderlineInputBorder(
                                // borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Password",
                            // hintText: 'your-email@domain.com',
                            labelStyle: const TextStyle(
                                color: Colors.black26, fontSize: 18),

                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isVisible = !_isVisible;
                                });
                              },
                              icon: _isVisible
                                  ? Icon(
                                      Icons.visibility,
                                      color: Color(ColorCode.addColorTitle),
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Color(ColorCode.addColorTitle),
                                    ),
                            ),
                          ),
                          style: TextStyle(fontSize: ColorCode.editTextFont)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(65, 15, 45, 0),
                            child: TextButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                _formGlobalKey.currentState!.save();
                                if (_email == null || _email.isEmpty) {
                                  context.showToast("Please enter email");
                                } else if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                    .hasMatch(_email.trim())) {
                                  context.showToast("Please enter valid email");
                                } else if (_password.isEmpty ||
                                    _password.length < 8) {
                                  context.showToast("Please enter Password");
                                } else {
                                  loginUser();
                                }
                              },
                              style: TextButton.styleFrom(
                                elevation: 20,
                                shadowColor: Colors.grey,
                                backgroundColor: Color(0xff3A95EF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),),
                              ),

                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth: _width * ColorCode.buttonsValues, minHeight: ColorCode.buttonsHeight),
                                  padding: const EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    "Continue",
                                    style: TextStyle(
                                        fontSize: ColorCode.buttonFont, color: Colors.white),
                                    minFontSize: 18,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 45,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [

                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                            child: Icon(Icons.error_outline,color:Color(ColorCode.addColorTitle) , ) ,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: AutoSizeText('User should have administrative rights on the account',
                                style: TextStyle(fontSize: ColorCode.subTextFont,color: Color(ColorCode.addColorSub)),
                                minFontSize: 12,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ])),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    await _isProgressLoading.show();
    Map<String, dynamic> tokenBody = HashMap();
    tokenBody['email'] = _email.trim();
    tokenBody['password'] = base64Url.encode(utf8.encode(_password));
    tokenBody['deviceSN'] = "";
    GetDeviceTokenResponse getDeviceTokenResponse = await ApiService()
        .getGenerateToken(tokenBody) as GetDeviceTokenResponse;
    if (getDeviceTokenResponse.responseCode == 1) {
      await _isProgressLoading.hide();
      var pref = await SharedPreferences.getInstance();
      pref.setString(Sharepref.accessToken,
          getDeviceTokenResponse.responseData.responseData.access_token);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddDevice(
                    offlineDeviceData:
                        getDeviceTokenResponse.responseData.offlineDeviceData!!,
                    tabletSettingData:
                        getDeviceTokenResponse.responseData.tabletSettingData!!,
                    facilityListData:
                        getDeviceTokenResponse.responseData.facilityListData!!,
                  )));
    } else {
      await _isProgressLoading.hide();
      context.showToast(getDeviceTokenResponse.responseMessage);
    }
  }

  emailValid(String email) async {
    return !RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }
}
