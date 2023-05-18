import 'package:flutter/cupertino.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Util {
  Future<void> initPlatformState() async {
    WidgetsFlutterBinding.ensureInitialized();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

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

  static Future<void> showToastErrorAccessLogs(String message) async {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.black,
        fontSize: 20.0);
  }

}
