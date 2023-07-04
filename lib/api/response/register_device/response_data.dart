
class ResponseDataDevice {
  final List<OfflineDeviceData>? offlineDeviceData;
  final List<TabletSettingData>? tabletSettingData;

  const ResponseDataDevice(
      {required this.offlineDeviceData,
      required this.tabletSettingData});

  factory ResponseDataDevice.fromJson(Map<String, dynamic> json) {
    return ResponseDataDevice(
      offlineDeviceData: json['OfflineDeviceData'],
      tabletSettingData: json['TabletSettingData'],

    );
  }
}

class OfflineDeviceData {
  final String deviceName;
  final String serialNumber;

  const OfflineDeviceData(
      {required this.deviceName,
        required this.serialNumber});

  factory OfflineDeviceData.fromJson(Map<String, dynamic> json) {
    return OfflineDeviceData(
      deviceName: json['deviceName'],
      serialNumber: json['serialNumber'],

    );
  }
}
class TabletSettingData {
  final int id;
  final String settingName;

  const TabletSettingData(
      {required this.id,
        required this.settingName});

  factory TabletSettingData.fromJson(Map<String, dynamic> json) {
    return TabletSettingData(
      id: json['id'],
      settingName: json['settingName'],

    );
  }
}
