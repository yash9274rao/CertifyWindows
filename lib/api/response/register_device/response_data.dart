import '../response_data_token.dart';

class ResponseDataDevice {
  final List<OfflineDeviceData>? offlineDeviceData ;
  final List<TabletSettingData>? tabletSettingData;
  final List<FacilityListData>? facilityListData;
  final ResponseDataToken responseData;
  const ResponseDataDevice(
      {
        required this.offlineDeviceData,
        required this.tabletSettingData,
        required this.facilityListData,
         required this.responseData
      });

  factory ResponseDataDevice.fromJson(Map<String, dynamic> json) {
    return ResponseDataDevice(
       offlineDeviceData: List.from(json['OfflineDeviceData'] ).map((e) => OfflineDeviceData.fromJson(e)).toList(),
        tabletSettingData : List.from(json['TabletSettingData']).map((e) => TabletSettingData.fromJson(e)).toList(),
        facilityListData :json['FacilityListData'] == null? []: List.from(json['FacilityListData']).map((e) => FacilityListData.fromJson(e)).toList(),
         responseData: ResponseDataToken.fromJson(json['responseString'] ?? {})
        );
  }
}

class OfflineDeviceData {
  final int deviceId;
  final String deviceName;
  final String serialNumber;
  final int deviceStatus;
  final int settingId;
  final int isActivated;
  final int facilityId;

  const OfflineDeviceData(
      {required this.deviceId, required this.deviceName, required this.serialNumber,required this.deviceStatus,required this.settingId,required this.isActivated,required this.facilityId});

  factory OfflineDeviceData.fromJson(Map<String, dynamic> json) {
    return OfflineDeviceData(
      deviceId: json['deviceId'],
      deviceName: json['deviceName'],
      serialNumber: json['serialNumber'],
      deviceStatus: json['deviceStatus'],
        settingId:json['settingId'],
        isActivated:json['isActivated'],
        facilityId:json['facilityId']
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

class FacilityListData{
  final int facilityId;
  final String facilityName;

  const FacilityListData({required this.facilityId, required this.facilityName});
  factory FacilityListData.fromJson(Map<String, dynamic> json) {
    return FacilityListData(
      facilityId: json['facilityId'],
      facilityName: json['facilityName'],
    );
  }


}
