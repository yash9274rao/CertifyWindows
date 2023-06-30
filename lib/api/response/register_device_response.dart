
class RegisterDeviceResponse {
  final int responseCode;
  final int responseSubCode;
  final String? responseMessage;

  const RegisterDeviceResponse(
      {required this.responseCode,
      required this.responseSubCode,
      required this.responseMessage});

  factory RegisterDeviceResponse.fromJson(Map<String, dynamic> json) {
    return RegisterDeviceResponse(
      responseCode: json['responseCode'],
      responseSubCode: json['responseSubCode'],
      responseMessage:
          json['responseMessage'] ?? "Device serial number already exists",
    );
  }
}
