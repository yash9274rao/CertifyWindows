import 'package:certify_me_kiosk/api/response/response_data_validate_vendor.dart';

class ValidateVendorResponse {
  final int responseCode;
  final int responseSubCode;
  final String? responseMessage;
  final ResponseDataValidateVendor? responseData;

  const ValidateVendorResponse(
      {required this.responseCode,
      required this.responseSubCode,
      required this.responseMessage,
      required this.responseData});

  factory ValidateVendorResponse.fromJson(Map<String, dynamic> json) {
    return ValidateVendorResponse(
        responseCode: json['responseCode'],
        responseSubCode: json['responseSubCode'],
        responseMessage: json['responseMessage'] ?? "Invalid QR Code",
        responseData:
            ResponseDataValidateVendor.fromJson(json['responseData'] ?? {}));
  }
}
