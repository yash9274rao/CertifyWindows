import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';

class util{
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
}