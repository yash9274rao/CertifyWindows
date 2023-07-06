import '../response_data_token.dart';

class ResponseDataDevice {
  final List<OfflineDeviceData>? offlineDeviceData ;
  final List<TabletSettingData>? tabletSettingData;
  final ResponseDataToken responseData;
  const ResponseDataDevice(
      {
        required this.offlineDeviceData,
        required this.tabletSettingData,
         required this.responseData
      });

  factory ResponseDataDevice.fromJson(Map<String, dynamic> json) {
    return ResponseDataDevice(
       offlineDeviceData: List.from(json['OfflineDeviceData'] ).map((e) => OfflineDeviceData.fromJson(e)).toList(),
        tabletSettingData : List.from(json['TabletSettingData']).map((e) => TabletSettingData.fromJson(e)).toList(),
         responseData: ResponseDataToken.fromJson(json['responseString'] ?? {})
        );
  }
}

class OfflineDeviceData {
  final String deviceName;
  final String serialNumber;

  const OfflineDeviceData(
      {required this.deviceName, required this.serialNumber});

  factory OfflineDeviceData.fromJson(json) {
    return OfflineDeviceData(
      deviceName: json['deviceName'],
      serialNumber: json['serialNumber'],
    );
  }
}

class TabletSettingData {
  final int id;
  final String settingName;

  const TabletSettingData({required this.id, required this.settingName});

  factory TabletSettingData.fromJson(Map<String, dynamic> json) {
    return TabletSettingData(
      id: json['id'],
      settingName: json['settingName'],
    );
  }
}
