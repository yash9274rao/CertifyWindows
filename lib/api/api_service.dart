import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:snaphybrid/api/response/activate_application_response.dart';

class ApiService {
  static const String _apiBaseUrl = "https://apiqa.certify.me/";

  Future<String?> getUsers(headers, bodys, sn) async {
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
      ActivateApplicationResponse aaR =
          ActivateApplicationResponse.fromJson(jsonDecode(res.body));
      Fluttertoast.showToast(
          msg: aaR.responseMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      // var response = await htt.get(url);
      // if (response.statusCode == 200) {
      //   List<UserModel> _model = userModelFromJson(response.body);
      //   return _model;
      // }\
      getGenerateToken(headers, bodys, sn);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> getGenerateToken(headers, bodys, sn) async {
    try {
      var url = Uri.parse("${_apiBaseUrl}GenerateToken");
      var res = await http.post(url, headers: {
        "Access-Control-Allow-Origin": "*",
        'Accept': '*/*',
        'DeviceSN': sn
      }, body: {});
      print('GenerateToken =${res.body}');
      // var response = await htt.get(url);
      // if (response.statusCode == 200) {
      //   List<UserModel> _model = userModelFromJson(response.body);
      //   return _model;
      // }
    } catch (e) {
      log(e.toString());
    }
  }
}
