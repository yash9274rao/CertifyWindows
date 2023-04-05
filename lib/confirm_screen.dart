import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snaphybrid/api/api_service.dart';
import 'package:snaphybrid/api/response/validate_vendor_response.dart';
import 'package:snaphybrid/home_screen.dart';

import 'common/sharepref.dart';

typedef StringValue = String Function(String);

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({Key? key, required this.dataStr}) : super(key: key);
  final String dataStr;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConfirmLanch(dataStr),
    );
  }
}

class ConfirmLanch extends StatefulWidget {
  ConfirmLanch(this.dataStr);

  final String dataStr;

  @override
  _Confirm createState() => _Confirm();
}

class _Confirm extends State<ConfirmLanch> {
  var textHolderModalController = "Validating QR ...";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Text(
          '${textHolderModalController}',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    if (widget.dataStr.contains("vn_")) {
      var pref = await SharedPreferences.getInstance();
      Map<String, dynamic> validateVendor = new HashMap();
      validateVendor['vendorGuid'] = widget.dataStr;
      validateVendor['deviceSNo'] = pref.getString(Sharepref.serialNo);
      String validateVendorResponse = await ApiService().validateVendor(
          pref.get(Sharepref.accessToken), validateVendor) as String;
      updateUI(validateVendorResponse);
    } else {
      updateUI("Invalid QRCode");
    }
  }

  Future<void> updateUI(String str) async {
    print('updateUI = ${str}');

    setState(() {
      textHolderModalController = str;
    });
    Future.delayed(Duration(milliseconds: 5000), () {
      // Your code
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }
}
