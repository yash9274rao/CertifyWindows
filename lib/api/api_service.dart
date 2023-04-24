import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:snaphybrid/api/response/activate_application_response.dart';
import 'package:snaphybrid/api/response/getdevice_token_response.dart';
import 'package:snaphybrid/api/response/register_device_response.dart';
import 'package:snaphybrid/api/response/response_data_token.dart';
import 'package:snaphybrid/api/response/validate_qrcode_response.dart';
import 'package:snaphybrid/common/qr_data.dart';
import '../common/sharepref.dart';
import 'response/settings_response/settings_response.dart';
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
        return activateApplicationResponse;
        // if (aaR.responseCode == 1) getGenerateToken(headers, bodys, sn);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<GetDeviceTokenResponse?> getGenerateToken(bodys) async {
    try {
      print('jsonEncode =${jsonEncode(bodys)}');
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
      return const GetDeviceTokenResponse(
          responseCode: 0,
          responseSubCode: 0,
          responseMessage: "Invalid Login Credentials",
          responseData: ResponseDataToken(
              access_token: "",
              token_type: "",
              expires_in: 454,
              institutionID: "",
              command: "",
              expiryTime: ""));
    }
  }

  Future<QrData?> validateVendor(accessToken, bodys) async {
    QrData qrData = new QrData();
    qrData.isValid = false;
    qrData.setFirstName = "Anonymous";
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
      QrData qrData = QrData();
      if (res.statusCode == 200) {
        ValidateVendorResponse validateVendorResponse =
            ValidateVendorResponse.fromJson(json.decode(res.body));
        if (validateVendorResponse.responseCode == 1) {
          qrData.setFirstName =
              (validateVendorResponse.responseData?.vendorName ?? "");
          qrData.setIsValid = true;
          return qrData;
        } else {
          qrData.setFirstName = "Anonymous";
          qrData.setIsValid = false;
          return qrData;
        }
      }
    } catch (e) {
      log("validateVendorvalidateVendor =$e");
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
      log("AccessLogs =$e");
      return "Invalid QRCode";
    }
  }

  Future<QrData?> validateQRCode(accessToken, bodys) async {
    QrData qrData = new QrData();
    qrData.isValid = false;
    qrData.setFirstName = "InValid QR Code";

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

  Future<String?> deviceSetting(pref) async {
    // SettingsResponse settingsResponse = new SettingsResponse(responseCode: responseCode, responseSubCode: responseSubCode, responseMessage: responseMessage, responseData: responseData)
    try {
      Map<String, dynamic> deviceSetting = new HashMap();
      deviceSetting['deviceSN'] = '${pref.getString(Sharepref.serialNo)}';
      deviceSetting['institutionId'] =
          '${pref.getString(Sharepref.institutionID)}';

      var url = Uri.parse("${_apiBaseUrl}GetDeviceConfiguration");
      var res = await http.post(url,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Authorization': 'bearer ${pref.getString(Sharepref.accessToken)}'
          },
          body: jsonEncode(deviceSetting));
      print('deviceSetting request = ${res.request}');

      print('deviceSetting ${res.statusCode}');

      print('deviceSetting = ${res.body}');
      if (res.statusCode == 200) {
        SettingsResponse settingsResponse =
            SettingsResponse.fromJson(json.decode(res.body));
        if (settingsResponse.responseCode == 1) {
          pref.setString(
              Sharepref.deviceName, settingsResponse.responseData?.deviceName);
          pref.setString(Sharepref.settingName,
              settingsResponse.responseData?.settingName);
          pref.setString(
              Sharepref.line1HomePageView,
              settingsResponse
                  .responseData?.jsonValue?.homePageSettings?.line1);
          pref.setString(
              Sharepref.line2HomePageView,
              settingsResponse
                  .responseData?.jsonValue?.homePageSettings?.line2);
          pref.setString(Sharepref.logoHomePageView,
              settingsResponse.responseData?.jsonValue?.homePageSettings?.logo);
          pref.setString(
              Sharepref.line1ConfirmationView,
              settingsResponse.responseData?.jsonValue?.confirmationViewSettings
                  ?.normalViewLine1);
          pref.setString(
              Sharepref.line2ConfirmationView,
              settingsResponse.responseData?.jsonValue?.confirmationViewSettings
                  ?.normalViewLine2);
          // pref.setString(
          //     Sharepref.line1HomePageView, Sharepref.line1HomePageView);
          return "1";
        }
      }
      return "0";
    } catch (e) {
      log("deviceSetting =$e");
      return "0";
    }
  }

  Future<RegisterDeviceResponse?> registerDeviceForApp(pref, bodys) async {
    try {
      print('registerDeviceForApp ${jsonEncode(bodys)}');

      var url = Uri.parse("${_apiBaseUrl}RegisterDeviceForApp");
      var res = await http.post(url,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Authorization': 'bearer ${pref.getString(Sharepref.accessToken)}'
          },
          body: jsonEncode(bodys));
      print('registerDeviceForApp request = ${res.request}');

      print('registerDeviceForApp ${res.statusCode}');

      print('registerDeviceForApp = ${res.body}');
      if (res.statusCode == 200) {
        RegisterDeviceResponse registerDeviceResponse =
        RegisterDeviceResponse.fromJson(json.decode(res.body));
          return registerDeviceResponse;
      }
      return const RegisterDeviceResponse(responseCode: 0, responseSubCode: 0, responseMessage: "Pleace Try agin");
    } catch (e) {
      log("registerDeviceForApp =$e");
      return const RegisterDeviceResponse(responseCode: 0, responseSubCode: 0, responseMessage: "");
    }
  }
}
