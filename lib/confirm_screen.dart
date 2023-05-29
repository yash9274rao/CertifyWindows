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
      {Key? key, required this.dataStr, required this.attendanceMode, required this.type})
      : super(key: key);
  final String dataStr;
  final String attendanceMode;
  final String type;



@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConfirmLanch(dataStr, attendanceMode, type),
    );
  }
}

class ConfirmLanch extends StatefulWidget {
  ConfirmLanch(this.dataStr, this.attendanceMode, this.type);

  final String dataStr, attendanceMode, type;

  @override
  _Confirm createState() => _Confirm();
}

class _Confirm extends State<ConfirmLanch> {
  var textHolderModalController = "";
  bool _isLoading = false;
  var confirmationText = "";
  var confirmationSubText = "";
  var screenDelayValue = "120";


  @override
  void initState() {
    super.initState();
    initPlatformState();
    screenDelay();

  }
  Future<void> screenDelay()async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString(Sharepref.viewDelay) == ""){
      screenDelayValue;
    }else{
      screenDelayValue = Sharepref.viewDelay;
    }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: !_isLoading
                  ?const Text("")
                  :const CircularProgressIndicator(),
            ),
            Text(
              textHolderModalController,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 40, color: Colors.black),
            ),
            Text(
             confirmationText,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
            ),
            Text(
              confirmationSubText,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
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
      if (widget.type == "qr") {
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
          qrValidation['institutionId'] =
              pref.getString(Sharepref.institutionID);
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
      }else if (widget.type == "pin"){
        QrData qrData = QrData();
        qrData.setIsValid = false;
        qrData.setFirstName = "Anonymous";
        qrData.setQrCodeID = widget.dataStr;
        updateUI(qrData);
      }
    //pin
  }

  Future<void> updateUI(QrData qrData) async {
    timeDateSet(qrData);
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = false;
      if (pref.getString(Sharepref.enableConfirmationScreen) == "1" && qrData.isValid) {
        textHolderModalController = qrData.getFirstName;
        confirmationText =
            pref.getString(Sharepref.mainText) ?? "";
        confirmationSubText = pref.getString(Sharepref.subText) ?? "";
      }else {
        if (pref.getString(Sharepref.allowAnonymous) == "1") {
          textHolderModalController = qrData.getFirstName;
          confirmationText =
              pref.getString(Sharepref.mainText) ?? "";
          confirmationSubText =
              pref.getString(Sharepref.subText) ?? "";
          // qrData.lastName = "Invalid QRCode";
        } else {
          textHolderModalController = "";
          Util.showToastError("Invalid QRCode");

        }
      }


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
    diveInfo['osVersion'] = pref.getString(Sharepref.osVersion);
    diveInfo['uniqueDeviceId'] = pref.getString(Sharepref.serialNo);
    diveInfo['deviceModel'] = pref.getString(Sharepref.deviceModel);
    diveInfo['deviceSN'] = pref.getString(Sharepref.serialNo);
    diveInfo['appVersion'] = pref.getString(Sharepref.appVersion);
    diveInfo['mobileNumber'] = "+1";
    diveInfo['IMEINumber'] = "";
    diveInfo['batteryStatus'] = "100";
    diveInfo['networkStatus'] = "true";
    diveInfo['appState'] = "Foreground";
    final ipv4 = await Ipify.ipv4();
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
