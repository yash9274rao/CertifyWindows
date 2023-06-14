import 'device_settings.dart';

class JsonValue {
  final DeviceSettings? jsonValue;
  final String deviceName;
  final String? settingName;
  final int? settingVersion;
  final String deviceMasterCode;
  final String configuredLanguageCode;

  const JsonValue(
      {required this.deviceName,
      required this.settingName,
      required this.settingVersion,
      required this.deviceMasterCode,
      required this.jsonValue,
      required this.configuredLanguageCode});

  factory JsonValue.fromJson(Map<String, dynamic> json) {
    return JsonValue(
        deviceName: json['deviceName'],
        settingName: json['settingName'],
        settingVersion: json['settingVersion'] ?? "",
        deviceMasterCode: json['deviceMasterCode'],
        jsonValue: DeviceSettings.fromJson(json['jsonValue'] ?? {}),
        configuredLanguageCode: json['configuredLanguageCode'] ?? "");
  }
}
