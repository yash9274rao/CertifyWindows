import 'package:flutter/cupertino.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Util {
  Future<void> initPlatformState() async {
    WidgetsFlutterBinding.ensureInitialized();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    //   if (defaultTargetPlatform == TargetPlatform.android) {
    //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //     print('Running on ${androidInfo.serialNumber}'); // e.g. "Moto G (4)"
    //     pref.putString("Key", "This is data I want to save to local storage",
    //         isEncrypted: true);
    //
    //     pref.put ${
    //       androidInfo.id
    //           .replaceAll(".", "")
    //           .replaceAll
    //
    //       diveInfo['osVersion'] = '${androidInfo.version.baseOS}';
    //       diveInfo['uniqueDeviceId'] = '${androidInfo.id}';
    //       diveInfo['deviceModel'] = '${androidInfo.model}';
    //       diveInfo['deviceSN'] = '${androidInfo.id}';
    //     } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    //     setState(() {
    //       textHolderModalController =
    //       'If you have already added the device on the '
    //           'portal SL NO: ${iosInfo.identifierForVendor}';
    //     });
    //     diveInfo['osVersion'] = '${iosInfo.systemVersion}';
    //     diveInfo['uniqueDeviceId'] = '${iosInfo.identifierForVendor}';
    //     diveInfo['deviceModel'] = '${iosInfo.model}';
    //     diveInfo['deviceSN'] = '${iosInfo.identifierForVendor}';
    //     //   print('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"
    //   } else if (defaultTargetPlatform == TargetPlatform.windows) {
    //     WebBrowserInfo webBrowserDeviceInfo = await deviceInfo.webBrowserInfo;
    //     // textHolderModal = 'If you have already added the device on the '
    //     //     'portal SL NO:${webBrowserInfo.userAgent}';
    //     setState(() {
    //       textHolderModalController =
    //       'If you have already added the device on the '
    //           'portal SL NO: ${webBrowserDeviceInfo.productSub}';
    //     });
    //     diveInfo['osVersion'] = '${webBrowserDeviceInfo.browserName}';
    //     diveInfo['uniqueDeviceId'] = '${webBrowserDeviceInfo.productSub}';
    //     diveInfo['deviceModel'] = '${webBrowserDeviceInfo.appName}';
    //     diveInfo['deviceSN'] = '${webBrowserDeviceInfo.productSub}';
    //   } else if (defaultTargetPlatform == TargetPlatform.macOS) {
    //     MacOsDeviceInfo macOsDeviceInfo = await deviceInfo.macOsInfo;
    //     setState(() {
    //       textHolderModalController =
    //       'If you have already added the device on the '
    //           'portal SL NO: ${macOsDeviceInfo.systemGUID}';
    //     });
    //   }
    // }
  }

  static String getAppUpTime(appLaunchTime) {
    // DateTime appLaunchDateTime = new DateTime.fromMillisecondsSinceEpoch(appLaunchTime );
    // DateTime currentDateTime = new DateTime.now().millisecondsSinceEpoch as DateTime;
    // long differenceInTime = currentDateTime.getTime() - appLaunchDateTime.getTime();
    // long seconds = TimeUnit.MILLISECONDS.toSeconds(differenceInTime) % 60;
    // long minutes = TimeUnit.MILLISECONDS.toMinutes(differenceInTime) % 60;
    // long hours = TimeUnit.MILLISECONDS.toHours(differenceInTime) % 24;
    // long days = TimeUnit.MILLISECONDS.toDays(differenceInTime) % 365;
    // long totalHours = hours + days * 24;
    // return String.format(Locale.getDefault(), "%d:%02d:%02d", totalHours, minutes, seconds);
    return "";
  }

  static Future<String> getUTCDate() async {
    return DateFormat("yyyy-MM-dd HH:mm:ss")
        .format(DateTime.now().toUtc())
        .toString();
  }

  static Future<void> showToastError(String message) async {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }


}
