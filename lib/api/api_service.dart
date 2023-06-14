import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
// import 'dart:js' ;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:snaphybrid/api/response/VoluntearResponse.dart';
import 'package:snaphybrid/api/response/accesslogs_Response.dart';
import 'package:snaphybrid/api/response/activate_application_response.dart';
import 'package:snaphybrid/api/response/getdevice_token_response.dart';
import 'package:snaphybrid/api/response/register_device_response.dart';
import 'package:snaphybrid/api/response/response_data_token.dart';
import 'package:snaphybrid/api/response/validate_qrcode_response.dart';
import 'package:snaphybrid/common/qr_data.dart';
import '../common/sharepref.dart';
import '../confirm_screen.dart';
import 'response/settings_response/settings_response.dart';
import 'response/validate_vendor_response.dart';

class ApiService {
  static const String _apiBaseUrl = "https://apidev.certify.me/";
  String responseData = "";

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
    qrData.setFirstName = "InValid QR Code";

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
          qrData.setFirstName = "InValid QR Code";
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
      return "";
    } catch (e) {
      log("validateVendorvalidateVendor =" + e.toString());
      return "Invalid QRCode";
    }
  }


  Future<AccesslogsResponse> accessLogs(accessToken, bodys) async {
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
      if (res.statusCode == 200) {
        AccesslogsResponse accesslogsResponse =
        AccesslogsResponse.fromJson(json.decode(res.body));
        return accesslogsResponse;
      }
      return const AccesslogsResponse(responseCode: 0,
          responseSubCode: 0,
          responseMessage: "Pleace Try agin");
    } catch (e) {
      log("AccessLogs =$e");
      return const AccesslogsResponse(
          responseCode: 0, responseSubCode: 0, responseMessage: "");
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
        ValidateQrCodeResponse validateQrCodeResponse =
        ValidateQrCodeResponse.fromJson(json.decode(res.body));
        if (validateQrCodeResponse.responseCode == 1) {
          qrData.firstName =
              validateQrCodeResponse.responseData?.firstName ?? "";
          qrData.lastName = validateQrCodeResponse.responseData?.lastName ?? "";
          qrData.middleName =
              validateQrCodeResponse.responseData?.middleName ?? "";
          qrData.id = validateQrCodeResponse.responseData?.id ?? "";
          qrData.memberId = validateQrCodeResponse.responseData?.memberId ?? "";
          qrData.accessId = validateQrCodeResponse.responseData?.accessId ?? "";
          qrData.trqStatus =
              validateQrCodeResponse.responseData?.trqStatus ?? 0;
          qrData.memberTypeId =
              validateQrCodeResponse.responseData?.memberTypeId ?? 0;
          qrData.isValid = true;
          qrData.memberTypeName =
              validateQrCodeResponse.responseData?.memberTypeName ?? "";
          qrData.faceTemplate =
              validateQrCodeResponse.responseData?.faceTemplate ?? "";
          qrData.isVisitor =
              validateQrCodeResponse.responseData?.isVisitor ?? 0;
          qrData.scheduleId =
          validateQrCodeResponse.responseData?.scheduleId ?? 0;
          return qrData;
        } else {
          return qrData;
        }
      }
    } catch (e) {
      log("validateQrCodeResponse =" + e.toString());
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
      deviceSetting['settingType'] = 10;

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

      print('deviceSetting body = ${res.body}');
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
          pref.setString(
              Sharepref.enableConfirmationScreen,
              settingsResponse.responseData?.jsonValue?.confirmationViewSettings
                  ?.enableConfirmationScreen);
          pref.setString(
              Sharepref.viewDelay,
              settingsResponse.responseData?.jsonValue?.confirmationViewSettings
                  ?.viewDelay);
          pref.setString(
              Sharepref.mainText,
              settingsResponse.responseData?.jsonValue?.confirmationViewSettings
                  ?.mainText);
          pref.setString(
              Sharepref.subText,
              settingsResponse.responseData?.jsonValue?.confirmationViewSettings
                  ?.subText);
          pref.setString(
              Sharepref.enableAnonymousQRCode,
              settingsResponse.responseData?.jsonValue?.identificationSettings
                  ?.enableAnonymousQRCode);
          pref.setString(
              Sharepref.enableVendorQR,
              settingsResponse.responseData?.jsonValue?.identificationSettings
                  ?.enableVendorQR);
          pref.setString(
              Sharepref.enableVisitorQR,
              settingsResponse.responseData?.jsonValue?.identificationSettings
                  ?.enableVisitorQR);
          pref.setString(
              Sharepref.enableVisitorCheckout,
              settingsResponse.responseData?.jsonValue?.identificationSettings
                  ?.enableVisitorCheckout);
          pref.setString(
              Sharepref.checkInMode,
              settingsResponse.responseData?.jsonValue?.identificationSettings
                  ?.checkInMode);
          pref.setString(
              Sharepref.enableVolunteerQR,
              settingsResponse.responseData?.jsonValue?.identificationSettings
                  ?.enableVolunteerQR);
          // pref.setString(
          //     Sharepref.enableBufferTime,
          //     settingsResponse.responseData?.jsonValue?.bufferTimeSettings?.enableBufferTime);
          // pref.setString(
          //     Sharepref.allowBufferTime,
          //     settingsResponse.responseData?.jsonValue?.bufferTimeSettings?.allowBufferTime);
          // pref.setString(
          //     Sharepref.enableMembersVisitors,
          //     settingsResponse.responseData?.jsonValue?.bufferTimeSettings?.enableMembersVisitors);
          // pref.setString(
          //     Sharepref.enableVendors,
          //     settingsResponse.responseData?.jsonValue?.bufferTimeSettings?.enableVendors);
          // pref.setString(
          //     Sharepref.enableVolunteers,
          //     settingsResponse.responseData?.jsonValue?.bufferTimeSettings?.enableVolunteers);



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
      print('registerDeviceForApp res body = ${res.body}');

      print('registerDeviceForApp request = ${res.request}');


      if (res.statusCode == 200) {
        RegisterDeviceResponse registerDeviceResponse =
        RegisterDeviceResponse.fromJson(json.decode(res.body));
        return registerDeviceResponse;
      }
      return const RegisterDeviceResponse(responseCode: 0,
          responseSubCode: 0,
          responseMessage: "Pleace Try agin");
    } catch (e) {
      log("registerDeviceForApp ="+e.toString());

      return const RegisterDeviceResponse(
          responseCode: 0, responseSubCode: 0, responseMessage: "");
    }
  }

  Future<VolunteerResponse?> volunteerApiCall(accessToken, bodys) async {
    try {
      var url = Uri.parse("${_apiBaseUrl}VolunteerValidation");
      var res = await http.post(url,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Authorization': 'Bearer $accessToken'
          },
          body: jsonEncode(bodys));
      print('Volunteer =${res.body}');
      if (res.statusCode == 200) {
        VolunteerResponse volunteerResponse =
            VolunteerResponse.fromJson(json.decode(res.body));
        return volunteerResponse;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
