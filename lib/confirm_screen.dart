import 'dart:collection';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snaphybrid/api/api_service.dart';
import 'package:snaphybrid/api/response/qr_data.dart';
import 'package:snaphybrid/api/response/validate_vendor_response.dart';
import 'package:snaphybrid/home_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:intl/intl.dart';
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
  QrData qrData = new QrData();

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
    qrData.setQrCodeID = widget.dataStr;
    if (widget.dataStr.contains("vn_")) {
      var pref = await SharedPreferences.getInstance();
      Map<String, dynamic> validateVendor = new HashMap();
      validateVendor['vendorGuid'] = widget.dataStr;
      validateVendor['deviceSNo'] = pref.getString(Sharepref.serialNo);
      String validateVendorResponse = await ApiService().validateVendor(
          pref.get(Sharepref.accessToken), validateVendor) as String;
      updateUI(validateVendorResponse);
    } else {
      qrData.setName = "Invalid QRCode";
      updateUI("Invalid QRCode");
      timeDateSet(false);
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

  Future<void> timeDateSet(bool isValid) async {
    Map<String, dynamic> diveInfo = new HashMap();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Sharepref.APP_LAUNCH_TIME,
        DateTime.now().millisecondsSinceEpoch.toString());
    WidgetsFlutterBinding.ensureInitialized();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      diveInfo['osVersion'] = '${androidInfo.version.release}';
      diveInfo['uniqueDeviceId'] = '${pref.getString(Sharepref.serialNo)}';
      diveInfo['deviceModel'] = '${androidInfo.model}';
      diveInfo['deviceSN'] = '${pref.getString(Sharepref.serialNo)}';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      diveInfo['osVersion'] = '${iosInfo.systemVersion}';
      diveInfo['uniqueDeviceId'] = '${iosInfo.identifierForVendor}';
      diveInfo['deviceModel'] = '${iosInfo.model}';
      diveInfo['deviceSN'] = '${pref.getString(Sharepref.serialNo)}';
      //   print('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      WebBrowserInfo webBrowserDeviceInfo = await deviceInfo.webBrowserInfo;
      // textHolderModal = 'If you have already added the device on the '
      //     'portal SL NO:${webBrowserInfo.userAgent}';
      diveInfo['osVersion'] = '${webBrowserDeviceInfo.browserName}';
      diveInfo['uniqueDeviceId'] = '${webBrowserDeviceInfo.productSub}';
      diveInfo['deviceModel'] = '${webBrowserDeviceInfo.appName}';
      diveInfo['deviceSN'] = '${pref.getString(Sharepref.serialNo)}';
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      MacOsDeviceInfo macOsDeviceInfo = await deviceInfo.macOsInfo;
    }
    final ipv4 = await Ipify.ipv4();
    diveInfo['appVersion'] = "v3.4.232";
    diveInfo['mobileNumber'] = "+1";
    diveInfo['IMEINumber'] = "";
    diveInfo['batteryStatus'] = "100";
    diveInfo['networkStatus'] = "true";
    diveInfo['appState'] = "Foreground";
    Map<String, dynamic> healthCheckRequest = new HashMap();
    healthCheckRequest['id'] = "0";
    healthCheckRequest['accessId'] = '';
    healthCheckRequest['firstName'] = '${qrData.getName}';
    healthCheckRequest['lastName'] = '';
    healthCheckRequest['memberId'] = '';
    healthCheckRequest['temperature'] = 0;
    healthCheckRequest['qrCodeId'] = '${qrData.qrCodeId}';
    healthCheckRequest['deviceId'] = '${pref.getString(Sharepref.serialNo)}';
    healthCheckRequest['deviceName'] = 'AndroidTab2';
    healthCheckRequest['institutionId'] =
        '${pref.getString(Sharepref.institutionID)}';
    healthCheckRequest['facilityId'] = 0;
    healthCheckRequest['locationId'] = 0;
    healthCheckRequest['facilityName'] = "";
    healthCheckRequest['locationName'] = '';
    healthCheckRequest['deviceTime'] = DateFormat("MM/dd/yyyy HH:mm:ss")
        .format(DateTime.now().toUtc())
        .toString();
    healthCheckRequest['timezone'] = '05:30';
    healthCheckRequest['sourceIP'] = ipv4;
    healthCheckRequest['deviceData'] = diveInfo;
    healthCheckRequest['guid'] = '';
    healthCheckRequest['faceParameters'] = "";
    healthCheckRequest['eventType'] = '';
    healthCheckRequest['evenStatus'] = '';
    healthCheckRequest['utcRecordDate'] = DateFormat("yyyy-MM-dd HH:mm:ss")
        .format(DateTime.now().toUtc())
        .toString();
    healthCheckRequest['loggingMode'] = '3';
    healthCheckRequest['accessOption'] = 1;
    healthCheckRequest['attendanceMode'] = 0;
    healthCheckRequest['allowAccess'] = true;

    ApiService()
        .accessLogs(pref.getString(Sharepref.accessToken), healthCheckRequest);
  }
}
