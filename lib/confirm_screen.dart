import 'dart:collection';
import 'dart:convert';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:certify_me_kiosk/api/api_service.dart';
import 'package:certify_me_kiosk/common/qr_data.dart';
import 'package:certify_me_kiosk/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:certify_me_kiosk/toast.dart';
import 'api/response/accesslogs_Response.dart';
import 'common/sharepref.dart';

typedef StringValue = String Function(String);

// class ConfirmScreen extends StatelessWidget {
//   const ConfirmScreen(
//       {Key? key,
//       required this.dataStr,
//       required this.attendanceMode,
//       required this.type, required this.name, required this.id,required this.scheduleId})
//       : super(key: key);
//   final String dataStr;
//   final String attendanceMode;
//   final String type;
//   final String name;
//   final int id;
//   final int scheduleId;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Certify.me Kiosk',
//       debugShowCheckedModeBanner: false,
//       home: ConfirmLanch(dataStr, attendanceMode, type, name, id, scheduleId),
//     );
//   }
// }

class ConfirmScreen extends StatefulWidget {
  ConfirmScreen({Key? key,
      required this.dataStr,
      required this.attendanceMode,
      required this.type, required this.name, required this.id,required this.scheduleId})
      : super(key: key);

  final String dataStr, attendanceMode, type, name;
  final int scheduleId, id;

  @override
  _Confirm createState() => _Confirm();
}

class _Confirm extends State<ConfirmScreen> {
  var textHolderModalController = "";
  var confirmationText = "";
  var confirmationSubText = "";
  var screenDelayValue = "120";
  var result;
  var _imageToShow =
  const Image(image: AssetImage('images/assets/final_logo.png'));
  var containerVisibility = false;
  QrData qrData = QrData();
  late ProgressDialog _isProgressLoading;
  @override
  void initState() {
    super.initState();
    initPlatformState();
    screenDelay();
    UpdateLogo();
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
    _isProgressLoading = ProgressDialog(context,type: ProgressDialogType.normal, isDismissible: false);
    _isProgressLoading.style(padding: EdgeInsets.all(25),);
    return Scaffold(
      body:SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 15, 0),
            child: _imageToShow,
          ),
          const SizedBox(
            height: 60,
          ),
          Center(
            child: Padding(padding:EdgeInsets.only(bottom: 20),
            child: Visibility(
                visible: containerVisibility,
                child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff175EA5),
                          Color(0xff163B60)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        tileMode: TileMode.repeated,
                        stops: [0.0, 1.7],
                      ),
                      borderRadius:
                      BorderRadius.all(Radius.circular(20)),
                    ),
            height: MediaQuery
                .of(context)
                .size
                .height * 0.5,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.7,
          child:SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(10),
            child: Text(
            textHolderModalController,textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 32, color: Colors.white),
          ),
                ),
                  Padding(padding: EdgeInsets.all(10),
           child: Text(
            confirmationText,textAlign: TextAlign.center,
            style: const TextStyle( fontSize: 20, color: Colors.white70),
          ),
                  ),
                  Padding(padding: EdgeInsets.all(10),
               child: Text(
            confirmationSubText,textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, color: Colors.white70),
                  )
                  )
    ]
          ),
          )

          )
          )
          )
          )
        ],
      )),
    );
  }
  Future<void> UpdateLogo() async{
    var pref = await SharedPreferences.getInstance();
    String? base64 = pref.getString(Sharepref.logoHomePageView) ?? "";
    setState(() {
      if (base64.isNotEmpty) {
        _imageToShow = Image.memory(const Base64Decoder().convert(base64));
      } else {
        _imageToShow =
        const Image(image: AssetImage('images/assets/final_logo.png'));
      }
    });
    await _isProgressLoading.show();

  }

  Future<void> initPlatformState() async {
    var pref = await SharedPreferences.getInstance();
    qrData.setIsValid = false;
    qrData.setFirstName = "Anonymous";
    qrData.setQrCodeID = widget.dataStr;
    if (widget.type == "qr") {
      if (widget.dataStr.startsWith("vm") &&
          (pref.getString(Sharepref.enableVolunteerQR) != "1") &&
          (pref.getString(Sharepref.enableAnonymousQRCode) != "1")) {
      } else if (widget.dataStr.startsWith("vi") &&
          (pref.getString(Sharepref.enableVisitorQR) != "1") &&
          (pref.getString(Sharepref.enableAnonymousQRCode) != "1")) {
      }else if (widget.dataStr.contains("vn") &&
          (pref.getString(Sharepref.enableVendorQR) != "1") &&
          (pref.getString(Sharepref.enableAnonymousQRCode) != "1")) {
      }
      else if (widget.dataStr.contains("vn")) { // Vendor QR code will come url base so we need use contains
       Map<String, dynamic> validateVendor = new HashMap();
        validateVendor['vendorGuid'] = widget.dataStr;
        validateVendor['deviceSNo'] = pref.getString(Sharepref.serialNo);
        qrData = await ApiService().validateVendor(
            pref.get(Sharepref.accessToken), validateVendor) as QrData;

        // await Future.delayed(const Duration(seconds: 5));
        qrData.setQrCodeID = widget.dataStr;
      }
      // else if (widget.dataStr.contains("tr")  || pref.get(Sharepref.enableVolunteerQR) == "1")
      else if (widget.dataStr.startsWith("tr") ||
          widget.dataStr.startsWith("vm") ||
          (widget.dataStr.startsWith("vi"))) {
        Map<String, dynamic> qrValidation = new HashMap();
        qrValidation['qrCodeID'] = widget.dataStr;
        qrValidation['institutionId'] = pref.getString(Sharepref.institutionID);
        qrValidation['deviceSN'] = pref.getString(Sharepref.serialNo);
        qrData = await ApiService().validateQRCode(
            pref.get(Sharepref.accessToken), qrValidation) as QrData;
        // await Future.delayed(const Duration(seconds: 5));
        qrData.setQrCodeID = widget.dataStr;
      } else if (pref.getString(Sharepref.enableAnonymousQRCode) == "1") {
        qrData = QrData();
        qrData.setIsValid = true;
        qrData.setFirstName = "Anonymous";
        qrData.setQrCodeID = widget.dataStr;
      }

    } else if (widget.type == "pin") {
      qrData = QrData();
      qrData.setIsValid = true;
      qrData.setFirstName = widget.name;
      qrData.setQrCodeID = "";
      qrData.scheduleId = widget.scheduleId;
      qrData.id = '${widget.id}';
      //updateUI(qrData);
    }
    //pin
    timeDateSet(qrData);
  }

  Future<void> updateUI(QrData qrData) async {
    // timeDateSet(qrData);
    print("ffffffffffffffffffffffffffff");
    SharedPreferences pref = await SharedPreferences.getInstance();
    await _isProgressLoading.hide();
    setState(() {
      containerVisibility = true;
      if (pref.getString(Sharepref.enableConfirmationScreen) == "1" &&
          qrData.isValid) {
        if (pref.getString(Sharepref.enableAnonymousQRCode) == "1" &&
            qrData.getFirstName == "Anonymous") {
          textHolderModalController = "";
        } else {
          if (qrData.middleName!.isNotEmpty && qrData.lastName.isNotEmpty) {
            textHolderModalController =
            '${qrData!.firstName} ${qrData!.middleName} ${qrData!.lastName}';
          } else if (qrData!.lastName.isNotEmpty) {
            textHolderModalController =
            '${qrData!.firstName!} ${qrData!.lastName}';
          }else {
            textHolderModalController = qrData.getFirstName;
          }
        }
        confirmationText = pref.getString(Sharepref.mainText) ?? "";
        confirmationSubText = pref.getString(Sharepref.subText) ?? "";
      } else {
        textHolderModalController = "";
        if (widget.type == "pin")
          context.showToast("Invalid PIN");
        else
          context.showToast("Invalid QR Code");
      }
    });
    Future.delayed(Duration(milliseconds: 5000), () {
      // Your code
      try {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } catch (e) {
        print("Error " + e.toString());
      }
    });
  }

  Future<void> navigationHome() async {
    await _isProgressLoading.hide();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  Future<void> timeDateSet(QrData qrData) async {
    var ipv4 = "";
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
    try {
      ipv4 = await Ipify.ipv4();
    } catch (e) {
      ipv4 = "";
    }
    Map<String, dynamic> accessLogs = HashMap();
    accessLogs['id'] = qrData.getId;
    accessLogs['accessId'] = "";
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
    accessLogs['deviceTime'] =
        DateFormat("MM/dd/yyyy HH:mm:ss").format(DateTime.now()).toString();
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
    accessLogs['scheduleId'] = qrData.scheduleId;
    AccesslogsResponse accesslogsResponse = await ApiService()
        .accessLogs(pref.getString(Sharepref.accessToken), accessLogs);
    // updateUI(qrData);
    if (accesslogsResponse.responseSubCode == 0 &&
        int.parse(widget.attendanceMode) == 1 &&
        qrData.isValid == true) {
      updateUI(qrData);
      context.showToast("You have been Checked-in");
    } else if (accesslogsResponse.responseSubCode == 0 &&
        int.parse(widget.attendanceMode) == 2 &&
        qrData.isValid == true) {
      updateUI(qrData);
      context.showToast("Checked-out");
    } else if (accesslogsResponse.responseSubCode == 103 &&
        int.parse(widget.attendanceMode) == 1 &&
        qrData.isValid == true) {
      navigationHome();
      context.showToast("Already Checked-in");
    } else if (accesslogsResponse.responseSubCode == 103 &&
        int.parse(widget.attendanceMode) == 2 &&
        qrData.isValid == true) {
      navigationHome();
      context.showToast("Already Checked-out");
    } else if (qrData.isValid == false) {
      navigationHome();
      if (widget.type == "pin")
        context.showToast("Invalid PIN");
      else
        context.showToast('Invalid QR Code');
    } else {
      updateUI(qrData);
    }
    // Future.delayed(Duration(milliseconds: 500), () {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => HomeScreen()));
    // });
  }
}
