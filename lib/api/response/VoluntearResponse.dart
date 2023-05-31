import 'package:snaphybrid/api/response/response_data_voluntear.dart';

class VolunteerResponse {
  final int responseCode;
  final int responseSubCode;
  final String? responseMessage;
  final ResponseDataVolunteer? responseData;

  const VolunteerResponse(
      {required this.responseCode,
        required this.responseSubCode,
        required this.responseMessage,
        required this.responseData});

  factory VolunteerResponse.fromJson(Map<String, dynamic> json) {
    return VolunteerResponse(
        responseCode: json['responseCode'],
        responseSubCode: json['responseSubCode'],
        responseMessage: json['responseMessage'] ?? "Invalid QRCode",
        responseData:
        ResponseDataVolunteer.fromJson(json['responseData'] ?? {}));
  }
}
