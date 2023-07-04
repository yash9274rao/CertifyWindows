import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:certify_me_kiosk/api/response/register_device/register_device_response.dart';
import 'package:certify_me_kiosk/main.dart';
import 'package:certify_me_kiosk/toast.dart';

import 'api/api_service.dart';
import 'common/sharepref.dart';

class AddDevice extends StatelessWidget {
  const AddDevice({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Certify.me Kiosk',
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var textHolderModalController;
  var textHolderInfo;
  final _formAddDeviceKey = GlobalKey<FormState>();
  String _deviceName = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

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
          key: _formAddDeviceKey,
          child: Container(
            margin: const EdgeInsets.fromLTRB(180, 80, 180, 80),
            color: Colors.white,
            child: Column(
              // crossAxisAlignment : CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, right: 0, bottom: 10),
                        child: IconButton(
                            icon: const ImageIcon(
                              AssetImage('images/assets/aerrow.png'),
                              size: 60,
                              // color: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop(context);
                            }),
                      ),
                      // Spacer(),

                      const Padding(
                        padding: EdgeInsets.all(10),
                          child: Text(
                            'Add Device',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              // height: 2, //line height 200%, 1= 100%, were 0.9 = 90% of actual line height
                              color: Colors.black87,
                              //font color
                              decorationThickness: 2,
                              //decoration 'underline' thickness
                              // fontStyle: FontStyle.italic
                            ),
                          ),
                        ),
                    ],
                  ),
                  // Image.asset("Assets/images/aerrow.png"),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 5, top: 20),
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: textHolderModalController,
                          enabled: false //disabel this text field input

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 20, top: 20),
                    child: TextFormField(
                      onSaved: (val) => _deviceName = val!,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        enabledBorder: UnderlineInputBorder(
                          // borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(5))),

                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Device Name",
                        // hintText: 'your-email@domain.com',
                        labelStyle: TextStyle(color: Colors.black26),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 20, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).pop(context);
                              },
                              style: const ButtonStyle(
                                visualDensity: VisualDensity(
                                  horizontal: VisualDensity.maximumDensity,
                                  vertical: VisualDensity.maximumDensity,
                                ),
                              ),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(fontSize: 20),
                              ),
                            )),
                        //
                        const SizedBox(
                          width: 70, //<-- SEE HERE
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _formAddDeviceKey.currentState!.save();
                              if (_deviceName.isEmpty) {
                                context.showToast("Please enter Device Name");
                              } else {
                                addDevice();
                              }
                            },
                            style: const ButtonStyle(
                              visualDensity: VisualDensity(
                                horizontal: VisualDensity.maximumDensity,
                                vertical: VisualDensity.maximumDensity,
                              ),
                            ),
                            child: const Text(
                              "Save",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 10, 20, 15),
                    child: Text(
                      '$textHolderInfo',
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          wordSpacing: 1,
                          // height: 2, //line height 200%, 1= 100%, were 0.9 = 90% of actual line height
                          color: Colors.grey),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      textHolderModalController = pref.getString(Sharepref.platform);
      if (pref.getString(Sharepref.platform) == "web") {
        textHolderInfo =
            'Device Model: ${pref.getString(Sharepref.deviceModel)}, Version:${pref.getString(Sharepref.osVersion)}';
      } else {
        textHolderInfo =
            'Device Model: ${pref.getString(Sharepref.deviceModel)}, Version:${pref.getString(Sharepref.osVersion)}, Serial Number: ${pref.getString(Sharepref.serialNo)}';
      }
    });
  }

  Future<void> addDevice() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> registerBody = HashMap();
    registerBody['deviceType'] = pref.getString(Sharepref.platformId);
    registerBody['deviceName'] = _deviceName;
    registerBody['serialNumber'] = pref.getString(Sharepref.serialNo);
    registerBody['IMEINumber'] = "";
    registerBody['status'] = 1;

    RegisterDeviceResponse registerDeviceResponse = await ApiService()
        .registerDeviceForApp(pref, registerBody) as RegisterDeviceResponse;
    if (registerDeviceResponse.responseCode == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    } else {
      context.showToast(registerDeviceResponse.responseMessage!);
    }
  }
}
