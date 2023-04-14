import 'package:snaphybrid/api/response/response_data_qrcode.dart';

class SettingsResponse {
  final int responseCode;
  final int responseSubCode;
  final String? responseMessage;
  final ResponseDataQrCode? responseData;

  const SettingsResponse(
      {required this.responseCode,
      required this.responseSubCode,
      required this.responseMessage,
      required this.responseData});

  factory SettingsResponse.fromJson(Map<String, dynamic> json) {
    return SettingsResponse(
        responseCode: json['responseCode'],
        responseSubCode: json['responseSubCode'],
        responseMessage: json['responseMessage'] ?? "Invalid QRCode",
        responseData:
        ResponseDataQrCode.fromJson(json['responseData'] ?? {}));
  }
}
