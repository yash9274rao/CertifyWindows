import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiService {
  Future<String?> getUsers(headers, bodys) async {
    try {
      var url = Uri.parse("https://apiqa.certify.me/ActivateApplication");
      var res = await http.post(url,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
           'device_sn': 'A060980P03900057'
          },
          body: jsonEncode(bodys));
      print(res.body);
      // var response = await htt.get(url);
      // if (response.statusCode == 200) {
      //   List<UserModel> _model = userModelFromJson(response.body);
      //   return _model;
      // }\
        getGenerateToken(headers, bodys);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> getGenerateToken(headers, bodys) async {
    try {
      var url = Uri.parse("https://apiqa.certify.me/GenerateToken");
      var res = await http.post(url, headers: {
        "Access-Control-Allow-Origin": "*",
        'Accept': '*/*',
        'DeviceSN': 'A060980P03900057'
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
