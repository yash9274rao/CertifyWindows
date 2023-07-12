

import 'package:certify_me_kiosk/api/response/register_device/response_data.dart';

class GetDeviceTokenResponse {
  final int responseCode;
  final int responseSubCode;
  final String responseMessage;
  final ResponseDataDevice responseData;

  const GetDeviceTokenResponse(
      {required this.responseCode,
      required this.responseSubCode,
      required this.responseMessage,
      required this.responseData});

  factory GetDeviceTokenResponse.fromJson(Map<String, dynamic> json) {
    return GetDeviceTokenResponse(
        responseCode: json['responseCode'],
        responseSubCode: json['responseSubCode'],
        responseMessage: json['responseMessage'] ?? "Invalid Login Credentials",
        responseData: ResponseDataDevice.fromJson(json['responseData'] ?? {}));
  }
}
