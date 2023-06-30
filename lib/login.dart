import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_device.dart';
import 'api/api_service.dart';
import 'api/response/getdevice_token_response.dart';
import 'common/sharepref.dart';
import 'common/util.dart';

void main() {
  runApp(const login());
}

class login extends StatelessWidget {
  const login({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formGlobalKey,
          child: Container(
              margin: const EdgeInsets.fromLTRB(180, 80, 180, 80),
              // padding: EdgeInsets.all(50),
              color: Colors.white,
              child: Column(
                  // crossAxisAlignment : CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: const ImageIcon(
                              AssetImage('images/assets/aerrow.png'),
                              size: 60,
                              // color: Colors.red,
                            ),
                            onPressed: () {
                              print("efewfewfwefe");
                              Navigator.of(context, rootNavigator: true).pop(context);
                            }),
                        // Expanded(flex:1,child:  ImageIcon(
                        //   AssetImage("images/assets/aerrow.png"),
                        // ),
                        // ),

                        const Expanded(
                          flex: 7,
                          child: Text(
                            'Login to register the device',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              // height: 2, //line height 200%, 1= 100%, were 0.9 = 90% of actual line height
                              color: Colors.black87,
                              //font color
                              decorationThickness:
                                  2, //decoration 'underline' thickness
                              // fontStyle: FontStyle.italic
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 20),
                      child: TextFormField(
                        onSaved: (val) => _email = val!,
                        decoration: const InputDecoration(
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
                            color: Colors.black26,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Email",
                          // hintText: 'your-email@domain.com',
                          labelStyle: TextStyle(color: Colors.black26),
                        ),
                      ),
                    ),

                    // Padding(
                    //     padding: EdgeInsets.fromLTRB(20 ,20, 20, 0),
                    //     child: Divider(color: Colors.grey)),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 20),
                      child: TextFormField(
                        onSaved: (val) => _password = val!,
                        // validator: (value) {
                        //   if (value == null || value.length < 8) {
                        //     return 'Please enter valid Password';
                        //   }
                        //   return null;
                        // },
                        obscuringCharacter: '*',
                        obscureText: !_isVisible,
                        decoration:  InputDecoration(
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
                            color: Colors.black26,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Password",
                          // hintText: 'your-email@domain.com',
                          labelStyle: const TextStyle(color: Colors.black26),

                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            icon: _isVisible ? const Icon(Icons.visibility, color: Colors.black,):
                            const Icon(Icons.visibility_off, color: Colors.grey,),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            backgroundColor: Colors.indigo,
                            // padding: EdgeInsets.symmetric(
                            //     horizontal: MediaQuery.of(context).size.width / 20,
                            //     vertical: 10)
                            // padding: const EdgeInsets.all(30)
                            padding: const EdgeInsets.symmetric(
                                horizontal: 170, vertical: 20)
                            //
                            // //      padding: const EdgeInsets.all(20)
                            // padding: EdgeInsets.symmetric(
                            //     horizontal: 170, vertical: 20)

                            // padding: const EdgeInsets.fromLTRB(20, 20, 20, 20)
                            ),
                        onPressed: () {
                          _formGlobalKey.currentState!.save();
                          if (_email == null || _email.isEmpty) {
                            Util.showToastError("Please enter email");
                          } else if (!RegExp(
                                  r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                              .hasMatch(_email)) {
                            Util.showToastError("Please enter valid email");
                          } else if (_password.isEmpty ||
                              _password.length < 8) {
                            Util.showToastError("Please enter Password");
                          } else {
                            loginUser();
                          }
                        },
                        child: const Text(
                          'Login', style: TextStyle(fontSize: 19),
                          // textAlign: TextAlign.justify,
                        )),

                    const Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 20, 15),
                      child: Text(
                        'Note:User should have administrative rights on the account',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            wordSpacing: 1,
                            // height: 2, //line height 200%, 1= 100%, were 0.9 = 90% of actual line height
                            color: Colors.grey),
                      ),
                    ),
                  ])),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> tokenBody = HashMap();
    tokenBody['email'] = _email;
    tokenBody['password'] = base64Url.encode(utf8.encode(_password));
    tokenBody['deviceSN'] = "";
    GetDeviceTokenResponse getDeviceTokenResponse = await ApiService()
        .getGenerateToken(tokenBody) as GetDeviceTokenResponse;
    if (getDeviceTokenResponse.responseCode == 1) {
      pref.setString(Sharepref.accessToken,
          getDeviceTokenResponse.responseData.access_token);
      // pref.setString(Sharepref.institutionID,
      //     getDeviceTokenResponse.responseData.institutionID);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddDevice()),
      );
    }else{
      Util.showToastError(getDeviceTokenResponse.responseMessage);

    }
  }

  emailValid(String email) async {
    return !RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }
}
