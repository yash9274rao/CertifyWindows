import 'package:snaphybrid/api/response/response_data_token.dart';

class GetDeviceTokenResponse {
  final int responseCode;
  final int responseSubCode;
  final String responseMessage;
  final ResponseDataToken responseData;

  const GetDeviceTokenResponse(
      {required this.responseCode,
      required this.responseSubCode,
      required this.responseMessage,
      required this.responseData});

  factory GetDeviceTokenResponse.fromJson(Map<String, dynamic> json) {
    return GetDeviceTokenResponse(
        responseCode: json['responseCode'],
        responseSubCode: json['responseSubCode'],
        responseMessage: json['responseMessage'],
        responseData: ResponseDataToken.fromJson(json['responseData']));
  }
}
