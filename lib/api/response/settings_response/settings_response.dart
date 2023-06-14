import 'device_settings.dart';
import 'json_value.dart';

class SettingsResponse {
  final int responseCode;
  final int responseSubCode;
  final String? responseMessage;
  final JsonValue? responseData;

  const SettingsResponse(
      {required this.responseCode,
      required this.responseSubCode,
      required this.responseMessage,
      required this.responseData});

  factory SettingsResponse.fromJson(Map<String, dynamic> json) {
    return SettingsResponse(
        responseCode: json['responseCode'],
        responseSubCode: json['responseSubCode'],
        responseMessage: json['responseMessage'] ?? "No data found",
        responseData: JsonValue.fromJson(json['responseData']?? {}));
  }
}
