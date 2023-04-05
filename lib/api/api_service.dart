import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:snaphybrid/api/response/activate_application_response.dart';
import 'package:snaphybrid/api/response/getdevice_token_response.dart';

import 'response/validate_vendor_response.dart';

class ApiService {
  static const String _apiBaseUrl = "https://apiqa.certify.me/";

  Future<ActivateApplicationResponse?> getUsers(headers, bodys, sn) async {
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
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Accept': '*/*'
          },
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
  Future<String?> validateVendor(accessToken,bodys) async {
    try {
      var url = Uri.parse("${_apiBaseUrl}validateVendor");
      var res = await http.post(url,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Authorization':'Bearer $accessToken'
          },
          body: jsonEncode(bodys));
      print('validateVendor = ${res.body}');
      if (res.statusCode == 200) {
        ValidateVendorResponse validateVendorResponse =
        ValidateVendorResponse.fromJson(json.decode(res.body));
        if (validateVendorResponse.responseCode == 1)
          return validateVendorResponse.responseData?.vendorName;
        else validateVendorResponse.responseMessage;
      }
    } catch (e) {
      log("validateVendorvalidateVendor ="+e.toString());
      return "Invalid QRCode";
    }
  }
}
