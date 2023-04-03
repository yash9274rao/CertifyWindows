import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:snaphybrid/api/response/activate_application_response.dart';
import 'package:snaphybrid/api/response/generate_token_response.dart';

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
      if (res.statusCode == 200) {
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

        if (aaR.responseCode == 1) getGenerateToken(headers, bodys, sn);
      }
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
      if (res.statusCode == 200) {
        var resData = res.body.replaceAll('\/', '');
       var enc = jsonEncode(resData);
        print("1111111111=" + enc);
        var valueMap = json.decode(enc);
        GenerateTokenResponse aaR =
        GenerateTokenResponse.fromJson(valueMap);
       //  var response = jsonDecode(resData);
       //  print(response);
       //  dynamic jsonObject = jsonDecode(response);
       //  print(jsonObject[0]["access_token"]);
       //  // var encode = jsonEncode(response);
       //  // print('GenerateToken =${}');
       // // var response = jsonDecode(value);
       //  print(response[0]['access_token']);
        // GenerateTokenResponse aaR =
        //     GenerateTokenResponse.fromJson(response);
        print('GenerateToken =${aaR.access_token}');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
