import 'dart:collection';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snaphybrid/api/api_service.dart';
import 'package:snaphybrid/common/qr_data.dart';
import 'package:snaphybrid/home_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:intl/intl.dart';
import 'api/response/accesslogs_Response.dart';
import 'common/sharepref.dart';
import 'common/util.dart';

typedef StringValue = String Function(String);

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen(
      {Key? key, required this.dataStr, required this.attendanceMode})
      : super(key: key);
  final String dataStr;
  final String attendanceMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConfirmLanch(dataStr, attendanceMode),
    );
  }
}

class ConfirmLanch extends StatefulWidget {
  ConfirmLanch(this.dataStr, this.attendanceMode);

  final String dataStr, attendanceMode;

  @override
  _Confirm createState() => _Confirm();
}

class _Confirm extends State<ConfirmLanch> {
  var textHolderModalController = "";
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child : new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // padding: const EdgeInsets.all(100),
              // margin:const EdgeInsets.all(100) ,

              // color: Colors.blue[100],
              child: Center(
                child: !_isLoading
                    ?const Text("")
                    :const CircularProgressIndicator(),
              ),
            ),
            Text(
              textHolderModalController,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 40, color: Colors.black),
            ),
          ],
        )
      ),
    );
  }

  Future<void> initPlatformState() async {
    setState(() {
      _isLoading=true;

    });
    var pref = await SharedPreferences.getInstance();
    if (widget.dataStr.contains("vn_")) {
      Map<String, dynamic> validateVendor = new HashMap();
      validateVendor['vendorGuid'] = widget.dataStr;
      validateVendor['deviceSNo'] = pref.getString(Sharepref.serialNo);
      QrData qrData = await ApiService().validateVendor(
          pref.get(Sharepref.accessToken), validateVendor) as QrData;

      // await Future.delayed(const Duration(seconds: 5));
      qrData.setQrCodeID = widget.dataStr;
      updateUI(qrData);
    } else if (widget.dataStr.contains("tr")) {
      Map<String, dynamic> qrValidation = new HashMap();
      qrValidation['qrCodeID'] = widget.dataStr;
      qrValidation['institutionId'] = pref.getString(Sharepref.institutionID);
      qrValidation['deviceSNo'] = pref.getString(Sharepref.serialNo);

      QrData qrData = await ApiService().validateQRCode(
          pref.get(Sharepref.accessToken), qrValidation) as QrData;

      // await Future.delayed(const Duration(seconds: 5));
      qrData.setQrCodeID = widget.dataStr;
      updateUI(qrData);
    } else {
      QrData qrData = QrData();
      qrData.setIsValid = false;
      qrData.setFirstName = "Anonymous";
      qrData.setQrCodeID = widget.dataStr;
      qrData.setIsValid = false;
      updateUI(qrData);

    }
  }

  Future<void> updateUI(QrData qrData) async {
    timeDateSet(qrData);
    setState(() {
      _isLoading = false;
      textHolderModalController = qrData.getFirstName;
    });
    Future.delayed(Duration(milliseconds: 5000), () {
      // Your code
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  Future<void> timeDateSet(QrData qrData) async {
    Map<String, dynamic> diveInfo = new HashMap();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(Sharepref.APP_LAUNCH_TIME,
        DateTime.now().millisecondsSinceEpoch.toString());
    WidgetsFlutterBinding.ensureInitialized();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      diveInfo['osVersion'] = androidInfo.version.release;
      diveInfo['uniqueDeviceId'] = '${pref.getString(Sharepref.serialNo)}';
      diveInfo['deviceModel'] = androidInfo.model;
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
    Map<String, dynamic> accessLogs = HashMap();
    accessLogs['id'] = qrData.getId;
    accessLogs['accessId'] = qrData.getQrCodeID;
    accessLogs['firstName'] = qrData.getFirstName;
    accessLogs['lastName'] = qrData.getLastName;
    accessLogs['middleName'] = qrData.getMiddleName;
    accessLogs['memberId'] = qrData.getMemberId;
    accessLogs['temperature'] = 0;
    accessLogs['qrCodeId'] = qrData.getQrCodeID;
    accessLogs['deviceId'] = pref.getString(Sharepref.serialNo);
    accessLogs['deviceName'] = pref.getString(Sharepref.deviceName);
    accessLogs['institutionId'] = '${pref.getString(Sharepref.institutionID)}';
    accessLogs['facilityId'] = 0;
    accessLogs['locationId'] = 0;
    accessLogs['facilityName'] = "";
    accessLogs['locationName'] = '';
    accessLogs['deviceTime'] = DateFormat("MM/dd/yyyy HH:mm:ss")
        .format(DateTime.now().toUtc()).toString();
    //healthCheckRequest['timezone'] = '05:30';
    accessLogs['sourceIP'] = ipv4;
    accessLogs['deviceData'] = diveInfo;
    accessLogs['guid'] = '';
    accessLogs['faceParameters'] = "";
    accessLogs['eventType'] = '';
    accessLogs['evenStatus'] = '';
    accessLogs['utcRecordDate'] = DateFormat("yyyy-MM-dd HH:mm:ss")
        .format(DateTime.now().toUtc())
        .toString();
    accessLogs['loggingMode'] = '2';
    accessLogs['accessOption'] = 1;
    accessLogs['attendanceMode'] = widget.attendanceMode;
    accessLogs['allowAccess'] = qrData.getIsValid;

    AccesslogsResponse accesslogsResponse = await ApiService().accessLogs(pref.getString(Sharepref.accessToken),accessLogs);
 if(accesslogsResponse.responseSubCode == 0 && int.parse(widget.attendanceMode) == 1 && qrData.isValid == true){
   Util.showToastErrorAccessLogs("Check In");
 }else if (accesslogsResponse.responseSubCode == 0 && int.parse(widget.attendanceMode) == 2 && qrData.isValid == true){
   Util.showToastErrorAccessLogs("Check Out");
 }else if (accesslogsResponse.responseSubCode == 103 && int.parse(widget.attendanceMode) == 1 && qrData.isValid == true) {
   Util.showToastErrorAccessLogs("Already Check In");
 }else if (accesslogsResponse.responseSubCode == 103 && int.parse(widget.attendanceMode) == 2 && qrData.isValid == true){
   Util.showToastErrorAccessLogs("Already Check Out");
 }
    Future.delayed(Duration(milliseconds: 50), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }
}
