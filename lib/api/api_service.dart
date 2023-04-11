import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:snaphybrid/api/response/activate_application_response.dart';
import 'package:snaphybrid/api/response/getdevice_token_response.dart';
import 'package:snaphybrid/api/response/validate_qrcode_response.dart';
import 'package:snaphybrid/common/qr_data.dart';

import 'response/validate_vendor_response.dart';

class ApiService {
  static const String _apiBaseUrl = "https://apiqa.certify.me/";

  Future<ActivateApplicationResponse?> activateApplication(bodys, sn) async {
    try {
      var url = Uri.parse('${_apiBaseUrl}ActivateApplication');
      var res = await http.post(url,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'device_sn': sn
          },
          body: jsonEncode(bodys));
      print(res.body);
      if (res.statusCode == 200) {
        ActivateApplicationResponse activateApplicationResponse =
            ActivateApplicationResponse.fromJson(jsonDecode(res.body));
        Fluttertoast.showToast(
            msg: activateApplicationResponse.responseMessage,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        return activateApplicationResponse;
        // if (aaR.responseCode == 1) getGenerateToken(headers, bodys, sn);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<GetDeviceTokenResponse?> getGenerateToken(bodys) async {
    try {
      var url = Uri.parse("${_apiBaseUrl}GetDeviceToken");
      var res = await http.post(url,
          headers: {"Access-Control-Allow-Origin": "*", 'Accept': '*/*'},
          body: jsonEncode(bodys));
      print('GenerateToken =${res.body}');
      if (res.statusCode == 200) {
        GetDeviceTokenResponse getDeviceTokenResponse =
            GetDeviceTokenResponse.fromJson(json.decode(res.body));
        return getDeviceTokenResponse;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<QrData?> validateVendor(accessToken, bodys) async {
    QrData qrData = new QrData();
    qrData.isValid = false;
    qrData.firstName = "Anonymous";
    try {
      var url = Uri.parse("${_apiBaseUrl}validateVendor");
      var res = await http.post(url,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Authorization': 'Bearer $accessToken'
          },
          body: jsonEncode(bodys));
      print('validateVendor = ${res.body}');
      QrData qrData = new QrData();
      if (res.statusCode == 200) {
        ValidateVendorResponse validateVendorResponse =
            ValidateVendorResponse.fromJson(json.decode(res.body));
        if (validateVendorResponse.responseCode == 1) {
          qrData.setFirstName = (validateVendorResponse.responseData?.vendorName ?? "");
          qrData.isValid = true;
          return qrData;
        } else {
          qrData.isValid = false;
          qrData.setFirstName = "Anonymous";
          return qrData;
        }
      }
    } catch (e) {
      log("validateVendorvalidateVendor =" + e.toString());
      return qrData;
    }
  }

  Future<String?> deviceHealthCheck(accessToken, bodys, deviceSn) async {
    try {
      print('deviceHealthCheck ${jsonEncode(bodys)}');

      var url = Uri.parse("${_apiBaseUrl}DeviceHealthCheck");
      var res = await http.post(url,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Authorization': 'Bearer ${accessToken}',
            'DeviceSN': '${deviceSn}'
          },
          body: jsonEncode(bodys));
      print('deviceHealthCheck request = ${res.request}');

      print('deviceHealthCheck ${res.statusCode}');

      print('deviceHealthCheck = ${res.body}');
      // if (res.statusCode == 200) {
      //   ActivateApplicationResponse validateVendorResponse =
      //   ActivateApplicationResponse.fromJson(json.decode(res.body));
      //   if (validateVendorResponse.responseCode == 1)
      //     return validateVendorResponse.responseMessage;
      //   else validateVendorResponse.responseMessage;
      // }
      return "";
    } catch (e) {
      log("validateVendorvalidateVendor =" + e.toString());
      return "Invalid QRCode";
    }
  }

  Future<String?> accessLogs(accessToken, bodys) async {
    try {
      print('AccessLogs ${bodys}');

      var url = Uri.parse("${_apiBaseUrl}AccessLogs");
      var res = await http.post(url,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Authorization': 'Bearer ${accessToken}'
          },
          body: jsonEncode(bodys));
      print('AccessLogs request = ${res.request}');

      print('AccessLogs ${res.statusCode}');

      print('AccessLogs = ${res.body}');
      // if (res.statusCode == 200) {
      //   ActivateApplicationResponse validateVendorResponse =
      //   ActivateApplicationResponse.fromJson(json.decode(res.body));
      //   if (validateVendorResponse.responseCode == 1)
      //     return validateVendorResponse.responseMessage;
      //   else validateVendorResponse.responseMessage;
      // }
      return "";
    } catch (e) {
      log("AccessLogs =" + e.toString());
      return "Invalid QRCode";
    }
  }

  Future<QrData?> validateQRCode(accessToken, bodys) async {
    QrData qrData = new QrData();
    qrData.isValid = false;
    qrData.firstName = "Anonymous";

    try {
      var url = Uri.parse("${_apiBaseUrl}ValidateQRCode");
      var res = await http.post(url,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Authorization': 'Bearer $accessToken'
          },
          body: jsonEncode(bodys));
      print('validateQRCode = ${res.body}');
      QrData qrData = new QrData();
      if (res.statusCode == 200) {
        ValidateQrCodeResponse validateVendorResponse =
            ValidateQrCodeResponse.fromJson(json.decode(res.body));
        if (validateVendorResponse.responseCode == 1) {
          qrData.firstName =
              validateVendorResponse.responseData?.firstName ?? "";
          qrData.lastName = validateVendorResponse.responseData?.lastName ?? "";
          qrData.id = validateVendorResponse.responseData?.id ?? "";
          qrData.memberId = validateVendorResponse.responseData?.memberId ?? "";
          qrData.accessId = validateVendorResponse.responseData?.accessId ?? "";
          qrData.trqStatus =
              validateVendorResponse.responseData?.trqStatus ?? 0;
          qrData.memberTypeId =
              validateVendorResponse.responseData?.memberTypeId ?? 0;
          qrData.isValid = true;
          qrData.memberTypeName =
              validateVendorResponse.responseData?.memberTypeName ?? "";
          qrData.faceTemplate =
              validateVendorResponse.responseData?.faceTemplate ?? "";
          qrData.isVisitor =
              validateVendorResponse.responseData?.isVisitor ?? 0;
          return qrData;
        } else {
          return qrData;
        }
      }
    } catch (e) {
      log("validateVendorvalidateVendor =" + e.toString());
      return qrData;
    }
  }
}
